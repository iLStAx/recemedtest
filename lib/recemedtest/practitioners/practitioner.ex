defmodule Recemedtest.Practitioners.Practitioner do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {
    Flop.Schema,
    filterable: [:first_name, :last_name],
    sortable: [:first_name, :last_name]
  }

  schema "practitioners" do
    field :first_name, :string
    field :last_name, :string
    field :phone, :string
    field :birthdate, :date
    field :email, :string
    has_many :prescriptions, Recemedtest.Prescriptions.Prescription

    timestamps(type: :utc_datetime)
  end

  @doc """
  Returns first_name + last_name for an Practitioner

  ## Example

    Marco Salinas
  """
  def full_name(practitioner) do
    "#{practitioner.first_name} #{practitioner.last_name}"
  end

  @doc false
  def changeset(practitioner, attrs) do
    practitioner
    |> cast(attrs, [:first_name, :last_name, :phone, :birthdate, :email])
    |> validate_required([:first_name, :last_name, :phone, :birthdate, :email])
  end
end
