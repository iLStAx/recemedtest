defmodule Recemedtest.PrescriptionsTest do
  use Recemedtest.DataCase

  alias Recemedtest.Prescriptions

  describe "prescriptions" do
    alias Recemedtest.Prescriptions.Prescription

    import Recemedtest.PrescriptionsFixtures

    @invalid_attrs %{detail: nil}

    test "list_prescriptions/0 returns all prescriptions" do
      prescription = prescription_fixture()
      assert Prescriptions.list_prescriptions() == [prescription]
    end

    test "get_prescription!/1 returns the prescription with given id" do
      prescription = prescription_fixture()
      assert Prescriptions.get_prescription!(prescription.id) == prescription
    end

    test "create_prescription/1 with valid data creates a prescription" do
      patient = Recemedtest.PatientsFixtures.patient_fixture()
      practitioner = Recemedtest.PractitionersFixtures.practitioner_fixture()
      valid_attrs = %{detail: "some detail", patient_id: patient.id, practitioner_id: practitioner.id}

      assert {:ok, %Prescription{} = prescription} = Prescriptions.create_prescription(valid_attrs)
      assert prescription.detail == "some detail"
    end

    test "create_prescription/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Prescriptions.create_prescription(@invalid_attrs)
    end

    test "update_prescription/2 with valid data updates the prescription" do
      prescription = prescription_fixture()
      update_attrs = %{detail: "some updated detail"}

      assert {:ok, %Prescription{} = prescription} = Prescriptions.update_prescription(prescription, update_attrs)
      assert prescription.detail == "some updated detail"
    end

    test "update_prescription/2 with invalid data returns error changeset" do
      prescription = prescription_fixture()
      assert {:error, %Ecto.Changeset{}} = Prescriptions.update_prescription(prescription, @invalid_attrs)
      assert prescription == Prescriptions.get_prescription!(prescription.id)
    end

    test "delete_prescription/1 deletes the prescription" do
      prescription = prescription_fixture()
      assert {:ok, %Prescription{}} = Prescriptions.delete_prescription(prescription)
      assert_raise Ecto.NoResultsError, fn -> Prescriptions.get_prescription!(prescription.id) end
    end

    test "change_prescription/1 returns a prescription changeset" do
      prescription = prescription_fixture()
      assert %Ecto.Changeset{} = Prescriptions.change_prescription(prescription)
    end
  end
end
