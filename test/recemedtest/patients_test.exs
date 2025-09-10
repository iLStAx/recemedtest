defmodule Recemedtest.PatientsTest do
  use Recemedtest.DataCase

  alias Recemedtest.Patients

  describe "patients" do
    alias Recemedtest.Patients.Patient

    import Recemedtest.PatientsFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, phone: nil, birthdate: nil, email: nil}

    test "list_patients/0 returns all patients" do
      patient = patient_fixture()
      { patients, _meta } = Patients.list_patients()
      assert patients == [patient]
    end

    test "get_patient!/1 returns the patient with given id" do
      patient = patient_fixture()
      assert Patients.get_patient!(patient.id) == patient
    end

    test "create_patient/1 with valid data creates a patient" do
      valid_attrs = %{first_name: "First Name", last_name: "Last Name", phone: "+56999999999", birthdate: ~D[2025-09-07], email: "example@gmail.com"}

      assert {:ok, %Patient{} = patient} = Patients.create_patient(valid_attrs)
      assert patient.first_name == "First Name"
      assert patient.last_name == "Last Name"
      assert patient.phone == "+56999999999"
      assert patient.birthdate == ~D[2025-09-07]
      assert patient.email == "example@gmail.com"
    end

    test "create_patient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Patients.create_patient(@invalid_attrs)
    end

    test "update_patient/2 with valid data updates the patient" do
      patient = patient_fixture()
      update_attrs = %{first_name: "Updated Name", last_name: "Updated Last Name", phone: "+56988888888", birthdate: ~D[2025-09-08], email: "updated@gmail.com"}

      assert {:ok, %Patient{} = patient} = Patients.update_patient(patient, update_attrs)
      assert patient.first_name == "Updated Name"
      assert patient.last_name == "Updated Last Name"
      assert patient.phone == "+56988888888"
      assert patient.birthdate == ~D[2025-09-08]
      assert patient.email == "updated@gmail.com"
    end

    test "update_patient/2 with invalid data returns error changeset" do
      patient = patient_fixture()
      assert {:error, %Ecto.Changeset{}} = Patients.update_patient(patient, @invalid_attrs)
      assert patient == Patients.get_patient!(patient.id)
    end

    test "delete_patient/1 deletes the patient" do
      patient = patient_fixture()
      assert {:ok, %Patient{}} = Patients.delete_patient(patient)
      assert_raise Ecto.NoResultsError, fn -> Patients.get_patient!(patient.id) end
    end

    test "change_patient/1 returns a patient changeset" do
      patient = patient_fixture()
      assert %Ecto.Changeset{} = Patients.change_patient(patient)
    end
  end
end
