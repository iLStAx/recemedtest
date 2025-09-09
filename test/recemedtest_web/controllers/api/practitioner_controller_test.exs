defmodule RecemedtestWeb.Api.PractitionerControllerTest do
  use RecemedtestWeb.ConnCase

  import Recemedtest.PractitionersFixtures
  alias Recemedtest.Practitioners.Practitioner

  @create_attrs %{
    first_name: "some first_name",
    last_name: "some last_name",
    phone: "some phone",
    birthdate: ~D[2025-09-08],
    email: "some email"
  }
  @update_attrs %{
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    phone: "some updated phone",
    birthdate: ~D[2025-09-09],
    email: "some updated email"
  }
  @invalid_attrs %{first_name: nil, last_name: nil, phone: nil, birthdate: nil, email: nil}

  setup :register_and_log_in_user

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all practitioners", %{conn: conn} do
      conn = get(conn, ~p"/api/api/practitioners")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create practitioner" do
    test "renders practitioner when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/practitioners", practitioner: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/api/practitioners/#{id}")

      assert %{
               "id" => ^id,
               "birthdate" => "2025-09-08",
               "email" => "some email",
               "first_name" => "some first_name",
               "last_name" => "some last_name",
               "phone" => "some phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/practitioners", practitioner: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update practitioner" do
    setup [:create_practitioner]

    test "renders practitioner when data is valid", %{conn: conn, practitioner: %Practitioner{id: id} = practitioner} do
      conn = put(conn, ~p"/api/api/practitioners/#{practitioner}", practitioner: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/api/practitioners/#{id}")

      assert %{
               "id" => ^id,
               "birthdate" => "2025-09-09",
               "email" => "some updated email",
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name",
               "phone" => "some updated phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, practitioner: practitioner} do
      conn = put(conn, ~p"/api/api/practitioners/#{practitioner}", practitioner: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete practitioner" do
    setup [:create_practitioner]

    test "deletes chosen practitioner", %{conn: conn, practitioner: practitioner} do
      conn = delete(conn, ~p"/api/api/practitioners/#{practitioner}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/api/practitioners/#{practitioner}")
      end
    end
  end

  defp create_practitioner(%{scope: scope}) do
    practitioner = practitioner_fixture(scope)

    %{practitioner: practitioner}
  end
end
