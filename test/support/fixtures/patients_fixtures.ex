defmodule Recemedtest.PatientsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Recemedtest.Patients` context.
  """

  @doc """
  Generate a patient.
  """
  def patient_fixture(attrs \\ %{}) do
    {:ok, patient} =
      attrs
      |> Enum.into(%{
        birthdate: ~D[2025-09-07],
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        phone: "some phone"
      })
      |> Recemedtest.Patients.create_patient()

    patient
  end
end
