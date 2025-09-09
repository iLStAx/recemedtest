defmodule Recemedtest.Prescriptions do
  @moduledoc """
  The Prescriptions context.
  """

  import Ecto.Query, warn: false
  alias Recemedtest.Repo
  alias Recemedtest.Patients.Patient
  alias Recemedtest.Practitioners.Practitioner
  alias Recemedtest.Prescriptions.Prescription

  @doc """
  Create random prescriptions from the las 100
  patients and practitioners already created by
  the faker api

  Returns an array of Prescriptions
  """
  def loader do
    limit = 100
    practitioners =
      Practitioner
      |> order_by(desc: :inserted_at)
      |> limit(^limit)
      |> Repo.all
    data_prescriptions = 
      Patient
      |> order_by(desc: :inserted_at)
      |> limit(^limit)
      |> Repo.all
      |> Enum.with_index
      |> Enum.map(fn { patient, index } ->
        practitioner = Enum.at(practitioners, index)
        now = DateTime.utc_now() |> DateTime.truncate(:second)
        %{
          detail: Faker.Lorem.sentence(),
          patient_id: patient.id,
          practitioner_id: practitioner.id,
          updated_at: now,
          inserted_at: now
        }
      end)
    Repo.insert_all(Prescription, data_prescriptions)
    Prescription
      |> order_by(desc: :inserted_at)
      |> limit(^limit)
      |> Repo.all
  end

  @doc """
  Returns the list of prescriptions.

  ## Examples

      iex> list_prescriptions()
      [%Prescription{}, ...]

  """
  def list_prescriptions do
    Repo.all(Prescription) |> Repo.preload([:practitioner, :patient])
  end

  @doc """
  Gets a single prescription.

  Raises `Ecto.NoResultsError` if the Prescription does not exist.

  ## Examples

      iex> get_prescription!(123)
      %Prescription{}

      iex> get_prescription!(456)
      ** (Ecto.NoResultsError)

  """
  def get_prescription!(id) do
    Repo.get!(Prescription, id) |> Repo.preload([:patient, :practitioner])
  end

  @doc """
  Creates a prescription.

  ## Examples

      iex> create_prescription(%{field: value})
      {:ok, %Prescription{}}

      iex> create_prescription(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_prescription(attrs) do
    %Prescription{}
    |> Prescription.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a prescription.

  ## Examples

      iex> update_prescription(prescription, %{field: new_value})
      {:ok, %Prescription{}}

      iex> update_prescription(prescription, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_prescription(%Prescription{} = prescription, attrs) do
    prescription
    |> Prescription.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a prescription.

  ## Examples

      iex> delete_prescription(prescription)
      {:ok, %Prescription{}}

      iex> delete_prescription(prescription)
      {:error, %Ecto.Changeset{}}

  """
  def delete_prescription(%Prescription{} = prescription) do
    Repo.delete(prescription)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking prescription changes.

  ## Examples

      iex> change_prescription(prescription)
      %Ecto.Changeset{data: %Prescription{}}

  """
  def change_prescription(%Prescription{} = prescription, attrs \\ %{}) do
    Prescription.changeset(prescription, attrs)
  end
end
