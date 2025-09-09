defmodule RecemedtestWeb.Api.PrescriptionControllerTest do
  use RecemedtestWeb.ConnCase

  import Recemedtest.PrescriptionsFixtures
  alias Recemedtest.Prescriptions.Prescription

  @update_attrs %{
    detail: "some updated detail"
  }
  @invalid_attrs %{detail: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all prescriptions", %{conn: conn} do
      conn = get(conn, ~p"/api/prescriptions")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create prescription" do
    test "renders prescription when data is valid", %{conn: conn} do
      patient = Recemedtest.PatientsFixtures.patient_fixture()
      practitioner = Recemedtest.PractitionersFixtures.practitioner_fixture()

      create_attrs = %{
        detail: "some detail",
        patient_id: patient.id,
        practitioner_id: practitioner.id
      }
      conn = post(conn, ~p"/api/prescriptions", prescription: create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/prescriptions/#{id}")

      assert %{
        "id" => ^id,
        "detail" => "some detail"
      } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/prescriptions", prescription: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update prescription" do
    setup [:create_prescription]

    test "renders prescription when data is valid", %{conn: conn, prescription: %Prescription{id: id} = prescription} do
      conn = put(conn, ~p"/api/prescriptions/#{prescription}", prescription: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/prescriptions/#{id}")

      assert %{
        "id" => ^id,
        "detail" => "some updated detail"
      } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, prescription: prescription} do
      conn = put(conn, ~p"/api/prescriptions/#{prescription}", prescription: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete prescription" do
    setup [:create_prescription]

    test "deletes chosen prescription", %{conn: conn, prescription: prescription} do
      conn = delete(conn, ~p"/api/prescriptions/#{prescription.id}")
      assert response(conn, 204)

      conn = get(conn, ~p"/api/prescriptions/#{prescription.id}")
      assert response(conn, 404)
    end
  end

  defp create_prescription(_context) do
    prescription = prescription_fixture()

    %{prescription: prescription}
  end
end
