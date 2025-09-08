defmodule Recemedtest.Patients do
  @moduledoc """
  The Patients context.
  """

  import Ecto.Query, warn: false
  alias Recemedtest.Repo

  alias Recemedtest.Patients.Patient


  @doc """
  Insert 100 fake objects as a Patient
  Returns an array of 100 Patients

  ## Example

  [
    %Recemedtest.Patients.Patient{
      __meta__: #Ecto.Schema.Metadata<:loaded, "patients">,
      id: 38,
      first_name: "Natalia",
      last_name: "Arroyo",
      phone: "+23599299256",
      birthdate: ~D[2004-07-09],
      email: "epozo@aguilar.es",
      inserted_at: ~U[2025-09-08 17:47:07Z],
      updated_at: ~U[2025-09-08 17:47:07Z]
    },
    %Recemedtest.Patients.Patient{
      __meta__: #Ecto.Schema.Metadata<:loaded, "patients">,
      id: 39,
      first_name: "Helena",
      last_name: "Barrios",
      phone: "+2636611808231",
      birthdate: ~D[2005-04-25],
      email: "ncerda@diez.com.es",
      inserted_at: ~U[2025-09-08 17:47:07Z],
      updated_at: ~U[2025-09-08 17:47:07Z]
    },...
  ]
  """
  def loader do
    case HTTPoison.get("https://fakerapi.it/api/v1/persons?_locale=es_ES&_quantity=100") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        patients =
          body
          |> Jason.decode!()
          |> Map.get("data")
          |> Enum.map(fn patient ->
            {:ok, date} = Date.from_iso8601(patient["birthday"])
            now = DateTime.utc_now() |> DateTime.truncate(:second)
            %{
              first_name: patient["firstname"],
              last_name: patient["lastname"],
              phone: patient["phone"],
              birthdate: date,
              email: patient["email"],
              inserted_at: now,
              updated_at: now
            }
          end)
        Repo.insert_all(Patient, patients)
        emails = Enum.map(patients, & &1.email)
        Repo.all(from p in Patient, where: p.email in ^emails)
      {:ok, %HTTPoison.Response{status_code: status}} ->
        {:error, "Request failed with status #{status}"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Returns the list of patients.

  ## Examples

      iex> list_patients()
      [%Patient{}, ...]

  """
  def list_patients do
    Repo.all(Patient)
  end

  @doc """
  Gets a single patient.

  Raises `Ecto.NoResultsError` if the Patient does not exist.

  ## Examples

      iex> get_patient!(123)
      %Patient{}

      iex> get_patient!(456)
      ** (Ecto.NoResultsError)

  """
  def get_patient!(id), do: Repo.get!(Patient, id)

  @doc """
  Creates a patient.

  ## Examples

      iex> create_patient(%{field: value})
      {:ok, %Patient{}}

      iex> create_patient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_patient(attrs) do
    %Patient{}
    |> Patient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a patient.

  ## Examples

      iex> update_patient(patient, %{field: new_value})
      {:ok, %Patient{}}

      iex> update_patient(patient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_patient(%Patient{} = patient, attrs) do
    patient
    |> Patient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a patient.

  ## Examples

      iex> delete_patient(patient)
      {:ok, %Patient{}}

      iex> delete_patient(patient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_patient(%Patient{} = patient) do
    Repo.delete(patient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking patient changes.

  ## Examples

      iex> change_patient(patient)
      %Ecto.Changeset{data: %Patient{}}

  """
  def change_patient(%Patient{} = patient, attrs \\ %{}) do
    Patient.changeset(patient, attrs)
  end
end
