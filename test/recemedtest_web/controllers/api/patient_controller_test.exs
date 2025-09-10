defmodule RecemedtestWeb.Api.PatientControllerTest do
  use RecemedtestWeb.ConnCase

  import Recemedtest.PatientsFixtures
  import Recemedtest.PrescriptionsFixtures
  alias Recemedtest.Patients.Patient

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
    test "lists all patients", %{conn: conn} do
      conn = get(conn, ~p"/api/patients")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create patient" do
    test "renders patient when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/patients", patient: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/patients/#{id}")

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
      conn = post(conn, ~p"/api/patients", patient: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update patient" do
    setup [:create_patient]

    test "renders patient when data is valid", %{conn: conn, patient: %Patient{id: id} = patient} do
      conn = put(conn, ~p"/api/patients/#{patient}", patient: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/patients/#{id}")

      assert %{
               "id" => ^id,
               "birthdate" => "2025-09-09",
               "email" => "updated@gmail.com",
               "first_name" => "Updated Name",
               "last_name" => "Updated Last Name",
               "phone" => "+56988888888"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, patient: patient} do
      conn = put(conn, ~p"/api/patients/#{patient}", patient: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete patient" do
    setup [:create_patient]

    test "deletes chosen patient", %{conn: conn, patient: patient} do
      conn = delete(conn, ~p"/api/patients/#{patient}")
      assert response(conn, 204)

      conn = get(conn, ~p"/api/patients/#{patient}")
      assert response(conn, 404)
    end

    test "deletes chosen patient with his prescriptions", %{conn: conn, patient: patient} do
      prescription = prescription_by_patient(patient)
      assert prescription
      conn = delete(conn, ~p"/api/patients/#{patient}")
      assert response(conn, 204)

      conn = get(conn, ~p"/api/patients/#{patient}")
      assert response(conn, 404)

      assert Recemedtest.Repo.get(Recemedtest.Prescriptions.Prescription, prescription.id) == nil
    end
  end

  defp create_patient(_context) do
    patient = patient_fixture()

    %{patient: patient}
  end
end
