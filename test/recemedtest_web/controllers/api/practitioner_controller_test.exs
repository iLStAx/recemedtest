defmodule RecemedtestWeb.Api.PractitionerControllerTest do
  use RecemedtestWeb.ConnCase

  import Recemedtest.PractitionersFixtures
  import Recemedtest.PrescriptionsFixtures
  alias Recemedtest.Practitioners.Practitioner

  @create_attrs %{
    first_name: "First Name",
    last_name: "Last Name",
    phone: "+56999999999",
    birthdate: ~D[2025-09-08],
    email: "example@gmail.com"
  }
  @update_attrs %{
    first_name: "Updated Name",
    last_name: "Updated Last Name",
    phone: "+56988888888",
    birthdate: ~D[2025-09-09],
    email: "updated@gmail.com"
  }
  @invalid_attrs %{first_name: nil, last_name: nil, phone: nil, birthdate: nil, email: nil}

  setup :register_and_log_in_user

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all practitioners", %{conn: conn} do
      conn = get(conn, ~p"/api/practitioners")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create practitioner" do
    test "renders practitioner when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/practitioners", practitioner: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/practitioners/#{id}")

      assert %{
               "id" => ^id,
               "birthdate" => "2025-09-08",
               "email" => "example@gmail.com",
               "first_name" => "First Name",
               "last_name" => "Last Name",
               "phone" => "+56999999999"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/practitioners", practitioner: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update practitioner" do
    setup [:create_practitioner]

    test "renders practitioner when data is valid", %{conn: conn, practitioner: %Practitioner{id: id} = practitioner} do
      conn = put(conn, ~p"/api/practitioners/#{practitioner}", practitioner: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/practitioners/#{id}")

      assert %{
               "id" => ^id,
               "birthdate" => "2025-09-09",
               "email" => "updated@gmail.com",
               "first_name" => "Updated Name",
               "last_name" => "Updated Last Name",
               "phone" => "+56988888888"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, practitioner: practitioner} do
      conn = put(conn, ~p"/api/practitioners/#{practitioner}", practitioner: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete practitioner" do
    setup [:create_practitioner]

    test "deletes chosen practitioner", %{conn: conn, practitioner: practitioner} do
      conn = delete(conn, ~p"/api/practitioners/#{practitioner}")
      assert response(conn, 204)

      conn = get(conn, ~p"/api/practitioners/#{practitioner}")
      assert response(conn, 404)
    end

    test "deletes chosen practitioner with his prescriptions", %{conn: conn, practitioner: practitioner} do
      prescription = prescription_by_practitioner(practitioner)
      assert prescription
      conn = delete(conn, ~p"/api/practitioners/#{practitioner}")
      assert response(conn, 204)

      conn = get(conn, ~p"/api/practitioners/#{practitioner}")
      assert response(conn, 404)

      assert Recemedtest.Repo.get(Recemedtest.Prescriptions.Prescription, prescription.id) == nil
    end
  end

  defp create_practitioner(_context) do
    practitioner = practitioner_fixture()

    %{practitioner: practitioner}
  end
end
