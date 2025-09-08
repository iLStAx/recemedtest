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
        email: "some email",
        first_name: "some first_name",
        last_name: "some last_name",
        phone: "some phone"
      })
      |> Recemedtest.Practitioners.create_practitioner()

    practitioner
  end
end
