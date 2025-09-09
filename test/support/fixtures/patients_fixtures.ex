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
        email: Faker.Internet.email,
        first_name: Faker.Person.first_name,
        last_name: Faker.Person.last_name,
        phone: Faker.Phone.EnUs.phone
      })
      |> Recemedtest.Patients.create_patient()

    patient
  end
end
