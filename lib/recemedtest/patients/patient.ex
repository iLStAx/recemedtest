defmodule Recemedtest.Patients.Patient do
  use Ecto.Schema
  import Ecto.Changeset

  schema "patients" do
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
  def full_name(patient) do
    "#{patient.first_name} #{patient.last_name}"
  end

  @doc false
  def changeset(patient, attrs) do
    patient
    |> cast(attrs, [:first_name, :last_name, :phone, :birthdate, :email])
    |> validate_required([:first_name, :last_name, :phone, :birthdate, :email])
    |> validate_format(:email, ~r/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/)
    |> unique_constraint(:email)
  end
end
