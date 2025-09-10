defmodule Recemedtest.Prescriptions.Prescription do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {
      Flop.Schema,
      filterable: [:patient_first_name, :practitioner_first_name],
      sortable: [:patient_first_name, :practitioner_first_name],
      adapter_opts: [
      join_fields: [
        patient_first_name: [
          binding: :patient,
          field: :first_name,
          ecto_type: :string
        ],
        practitioner_first_name: [
          binding: :practitioner,
          field: :first_name,
          ecto_type: :string
        ]
      ]
    ]
  }

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
