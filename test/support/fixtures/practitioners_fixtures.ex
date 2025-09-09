defmodule Recemedtest.PractitionersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Recemedtest.Practitioners` context.
  """

  @doc """
  Generate a practitioner.
  """
  def practitioner_fixture(attrs \\ %{}) do
    {:ok, practitioner} =
      attrs
      |> Enum.into(%{
        birthdate: ~D[2025-09-07],
        email: Faker.Internet.email,
        first_name: Faker.Person.first_name,
        last_name: Faker.Person.last_name,
        phone: Faker.Phone.EnUs.phone
      })
      |> Recemedtest.Practitioners.create_practitioner()

    practitioner
  end
end
