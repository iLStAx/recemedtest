defmodule RecemedtestWeb.Api.PrescriptionController do
  use RecemedtestWeb, :controller

  alias Recemedtest.Prescriptions
  alias Recemedtest.Prescriptions.Prescription
  alias Recemedtest.Repo

  action_fallback RecemedtestWeb.FallbackController

  def index(conn, _params) do
    prescriptions = Prescriptions.list_prescriptions()
    render(conn, :index, prescriptions: prescriptions)
  end

  def create(conn, %{"prescription" => prescription_params}) do
    with {:ok, %Prescription{} = prescription} <- Prescriptions.create_prescription(prescription_params) do
      prescription = Repo.preload(prescription, [:patient, :practitioner])

      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/prescriptions/#{prescription}")
      |> render(:show, prescription: prescription)
    end
  end

  def show(conn, %{"id" => id}) do
    try do
      prescription =
        Prescriptions.get_prescription!(id)
        |> Repo.preload([:patient, :practitioner])
      render(conn, :show, prescription: prescription)
    rescue
      Ecto.NoResultsError ->
        {:error, :not_found}
    end
  end

  def update(conn, %{"id" => id, "prescription" => prescription_params}) do
    try do
      prescription = Prescriptions.get_prescription!(id)

      with {:ok, %Prescription{} = prescription} <- Prescriptions.update_prescription(prescription, prescription_params) do
        prescription = Repo.preload(prescription, [:patient, :practitioner])
        render(conn, :show, prescription: prescription)
      end
    rescue
      Ecto.NoResultsError ->
        {:error, :not_found}
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      prescription = Prescriptions.get_prescription!(id)

      with {:ok, %Prescription{}} <- Prescriptions.delete_prescription(prescription) do
        send_resp(conn, :no_content, "")
      end
    rescue
      Ecto.NoResultsError ->
        {:error, :not_found}
    end
  end
end
