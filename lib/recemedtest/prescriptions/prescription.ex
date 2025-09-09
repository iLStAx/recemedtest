defmodule Recemedtest.Prescriptions.Prescription do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prescriptions" do
    field :detail, :string
    belongs_to :practitioner, Recemedtest.Practitioners.Practitioner
    belongs_to :patient, Recemedtest.Patients.Patient

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(prescription, attrs) do
    prescription
    |> cast(attrs, [:detail, :patient_id, :practitioner_id])
    |> validate_required([:detail, :patient_id, :practitioner_id])
  end
end
