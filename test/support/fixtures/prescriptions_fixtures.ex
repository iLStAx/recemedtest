defmodule Recemedtest.PrescriptionsFixtures do
  alias Recemedtest.PatientsFixtures
  alias Recemedtest.PractitionersFixtures
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Recemedtest.Prescriptions` context.
  """

  @doc """
  Generate a prescription.
  """
  def prescription_fixture(attrs \\ %{}) do
    patient = PatientsFixtures.patient_fixture()
    practitioner = PractitionersFixtures.practitioner_fixture()

    {:ok, prescription} =
      attrs
      |> Enum.into(%{
        detail: Faker.Lorem.sentence,
        patient_id: patient.id,
        practitioner_id: practitioner.id
      })
      |> Recemedtest.Prescriptions.create_prescription()

    Recemedtest.Repo.preload(prescription, [:patient, :practitioner])
  end
end
