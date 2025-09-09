defmodule Recemedtest.Utils.DateParser do
  @moduledoc """
  Utility module for parsing date strings from various formats into `Date` structs.
  """

  @doc """
  Parses the `:birthdate` field in the given changeset into a `Date` struct.

  This function ensures that if the `:birthdate` field is provided as a string, it will be
  converted into a valid `Date`. It supports both standard ISO8601 format (`"YYYY-MM-DD"`)
  and the custom `"DD-MM-YYYY"` format.

  If parsing fails, an error is added to the changeset.

  ## Behavior

    * If `:birthdate` is not present in the changeset, it returns the changeset unchanged.
    * If `:birthdate` is a valid string in either `"YYYY-MM-DD"` or `"DD-MM-YYYY"` format, it converts it to a `Date`.
    * If parsing fails, it adds an error `"Invalid date"` to the changeset.
    * If the value is not a string, the changeset is returned unchanged.

  ## Examples

      iex> changeset = Ecto.Changeset.change(%Patient{}, %{birthdate: "2023-10-01"})
      iex> parse_birthdate(changeset)
      # Ecto.Changeset with `birthdate` converted to %Date{year: 2023, month: 10, day: 1}

      iex> changeset = Ecto.Changeset.change(%Patient{}, %{birthdate: "01-10-2023"})
      iex> parse_birthdate(changeset)
      # Ecto.Changeset with `birthdate` converted to %Date{year: 2023, month: 10, day: 1}

      iex> changeset = Ecto.Changeset.change(%Patient{}, %{birthdate: "invalid-date"})
      iex> parse_birthdate(changeset)
      # Ecto.Changeset with error in the `birthdate` field

  """
  def parse_birthdate(changeset) do
    case Ecto.Changeset.get_change(changeset, :birthdate) do
      nil ->
        changeset

      date_str when is_binary(date_str) ->
        case Date.from_iso8601(date_str) do
          {:ok, date} -> Ecto.Changeset.put_change(changeset, :birthdate, date)
          _ -> Ecto.Changeset.add_error(changeset, :birthdate, "Fecha inválida")
        end

      _ ->
        changeset
    end
  end
end
