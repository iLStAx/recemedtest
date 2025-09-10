defmodule RecemedtestWeb.Admin.PatientControllerTest do
  use RecemedtestWeb.ConnCase

  import Recemedtest.PatientsFixtures
  import Recemedtest.AccountsFixtures

  @create_attrs %{first_name: "First Name", last_name: "Last Name", phone: "+56988888888", birthdate: ~D[2025-09-07], email: "example@gmail.com"}
  @update_attrs %{first_name: "Updated Name", last_name: "Updated Last Name", phone: "+56999999999", birthdate: ~D[2025-09-08], email: "updated@gmail.com"}
  @invalid_attrs %{first_name: nil, last_name: nil, phone: nil, birthdate: nil, email: nil}

  setup %{conn: conn} do
    user = user_fixture()
    conn = log_in_user(conn, user)
    {:ok, conn: conn, user: user}
  end

  describe "index" do
    test "lists all patients", %{conn: conn} do
      user = user_fixture()  # tu fixture de usuario
      conn = log_in_user(conn, user)
      conn = get(conn, ~p"/admin/patients")
      assert html_response(conn, 200) =~ "Listing Patients"
    end
  end

  describe "new patient" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/admin/patients/new")
      assert html_response(conn, 200) =~ "New Patient"
    end
  end

  describe "create patient" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/admin/patients", patient: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/admin/patients/#{id}"

      conn = get(conn, ~p"/admin/patients/#{id}")
      assert html_response(conn, 200) =~ "Patient #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/admin/patients", patient: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Patient"
    end
  end

  describe "edit patient" do
    setup [:create_patient]

    test "renders form for editing chosen patient", %{conn: conn, patient: patient} do
      conn = get(conn, ~p"/admin/patients/#{patient}/edit")
      assert html_response(conn, 200) =~ "Edit Patient"
    end
  end

  describe "update patient" do
    setup [:create_patient]

    test "redirects when data is valid", %{conn: conn, patient: patient} do
      conn = put(conn, ~p"/admin/patients/#{patient}", patient: @update_attrs)
      assert redirected_to(conn) == ~p"/admin/patients/#{patient}"

      conn = get(conn, ~p"/admin/patients/#{patient}")
      assert html_response(conn, 200) =~ "Updated Name"
    end

    test "renders errors when data is invalid", %{conn: conn, patient: patient} do
      conn = put(conn, ~p"/admin/patients/#{patient}", patient: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Patient"
    end
  end

  describe "delete patient" do
    setup [:create_patient]

    test "deletes chosen patient", %{conn: conn, patient: patient} do
      conn = delete(conn, ~p"/admin/patients/#{patient}")
      assert redirected_to(conn) == ~p"/admin/patients"

      conn = get(conn, ~p"/admin/patients/#{patient.id}")
      assert html_response(conn, 404)
    end
  end

  defp create_patient(_) do
    patient = patient_fixture()

    %{patient: patient}
  end
end
