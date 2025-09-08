defmodule Recemedtest.PrescriptionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Recemedtest.Prescriptions` context.
  """

  @doc """
  Generate a prescription.
  """
  def prescription_fixture(attrs \\ %{}) do
    {:ok, prescription} =
      attrs
      |> Enum.into(%{
        detail: "some detail"
      })
      |> Recemedtest.Prescriptions.create_prescription()

    prescription
  end
end
