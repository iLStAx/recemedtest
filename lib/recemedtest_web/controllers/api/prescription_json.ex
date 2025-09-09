defmodule RecemedtestWeb.Api.PrescriptionJSON do
  alias Recemedtest.Prescriptions.Prescription

  @doc """
  Renders a list of prescriptions.
  """
  def index(%{prescriptions: prescriptions}) do
    %{data: for(prescription <- prescriptions, do: data(prescription))}
  end

  @doc """
  Renders a single prescription.
  """
  def show(%{prescription: prescription}) do
    %{data: data(prescription)}
  end

  defp data(%Prescription{} = prescription) do
    %{
      id: prescription.id,
      detail: prescription.detail,
      patient: patient_data(prescription.patient),
      practitioner: practitioner_data(prescription.practitioner)
    }
  end

  defp patient_data(nil), do: nil
  defp patient_data(patient) do
    %{
      id: patient.id,
      name: "#{patient.first_name} #{patient.last_name}",
      email: patient.email
    }
  end

  defp practitioner_data(nil), do: nil
  defp practitioner_data(practitioner) do
    %{
      id: practitioner.id,
      name: "#{practitioner.first_name} #{practitioner.last_name}",
      email: practitioner.email
    }
  end
end
