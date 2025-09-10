defmodule Recemedtest.Practitioners do
  @moduledoc """
  The Practitioners context.
  """

  import Ecto.Query, warn: false
  alias Recemedtest.Repo

  alias Recemedtest.Practitioners.Practitioner


  @doc """
  Insert 100 fake objects as a Practitioner
  Returns an array of 100 Practitioners

  ## Example

  [
    %Recemedtest.Practitioners.Practitioner{
      __meta__: #Ecto.Schema.Metadata<:loaded, "practitioners">,
      id: 18,
      first_name: "Ander",
      last_name: "Marrero",
      phone: "+420494881268",
      birthdate: ~D[2009-07-02],
      email: "rascon.adam@gmail.com",
      inserted_at: ~U[2025-09-08 17:51:36Z],
      updated_at: ~U[2025-09-08 17:51:36Z]
    },
    %Recemedtest.Practitioners.Practitioner{
      __meta__: #Ecto.Schema.Metadata<:loaded, "practitioners">,
      id: 19,
      first_name: "Rodrigo",
      last_name: "Vanegas",
      phone: "+648244547909",
      birthdate: ~D[2000-02-12],
      email: "hcarrera@escribano.net",
      inserted_at: ~U[2025-09-08 17:51:36Z],
      updated_at: ~U[2025-09-08 17:51:36Z]
    }...
  ]
  """
  def loader do
    case HTTPoison.get("https://fakerapi.it/api/v1/persons?_locale=es_ES&_quantity=100") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        practitioners =
          body
          |> Jason.decode!()
          |> Map.get("data")
          |> Enum.map(fn practitioner ->
            {:ok, date} = Date.from_iso8601(practitioner["birthday"])
            now = DateTime.utc_now() |> DateTime.truncate(:second)
            %{
              first_name: practitioner["firstname"],
              last_name: practitioner["lastname"],
              phone: practitioner["phone"],
              birthdate: date,
              email: practitioner["email"],
              inserted_at: now,
              updated_at: now
            }
          end)
        Repo.insert_all(Practitioner, practitioners)
        emails = Enum.map(practitioners, & &1.email)
        Repo.all(from p in Practitioner, where: p.email in ^emails)
      {:ok, %HTTPoison.Response{status_code: status}} ->
        {:error, "Request failed with status #{status}"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Returns the list of practitioners.

  ## Examples

      iex> list_practitioners()
      [%Practitioner{}, ...]

  """
  def list_practitioners(params \\ %{}) do
    Flop.validate_and_run!(Practitioner, params, for: Practitioner, replace_invalid_params: true)
  end

  @doc """
  Gets a single practitioner.

  Raises `Ecto.NoResultsError` if the Practitioner does not exist.

  ## Examples

      iex> get_practitioner!(123)
      %Practitioner{}

      iex> get_practitioner!(456)
      ** (Ecto.NoResultsError)

  """
  def get_practitioner!(id), do: Repo.get!(Practitioner, id)

  @doc """
  Creates a practitioner.

  ## Examples

      iex> create_practitioner(%{field: value})
      {:ok, %Practitioner{}}

      iex> create_practitioner(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_practitioner(attrs) do
    %Practitioner{}
    |> Practitioner.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a practitioner.

  ## Examples

      iex> update_practitioner(practitioner, %{field: new_value})
      {:ok, %Practitioner{}}

      iex> update_practitioner(practitioner, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_practitioner(%Practitioner{} = practitioner, attrs) do
    practitioner
    |> Practitioner.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a practitioner.

  ## Examples

      iex> delete_practitioner(practitioner)
      {:ok, %Practitioner{}}

      iex> delete_practitioner(practitioner)
      {:error, %Ecto.Changeset{}}

  """
  def delete_practitioner(%Practitioner{} = practitioner) do
    Repo.delete(practitioner)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking practitioner changes.

  ## Examples

      iex> change_practitioner(practitioner)
      %Ecto.Changeset{data: %Practitioner{}}

  """
  def change_practitioner(%Practitioner{} = practitioner, attrs \\ %{}) do
    Practitioner.changeset(practitioner, attrs)
  end
end
