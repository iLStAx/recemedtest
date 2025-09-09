defmodule RecemedtestWeb.Api.PatientController do
  use RecemedtestWeb, :controller

  alias Recemedtest.Patients
  alias Recemedtest.Patients.Patient

  action_fallback RecemedtestWeb.FallbackController

  def index(conn, params) do
    { patients, _meta } = Patients.list_patients(params)
    render(conn, :index, patients: patients)
  end

  def create(conn, %{"patient" => patient_params}) do
    with {:ok, %Patient{} = patient} <- Patients.create_patient(patient_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/api/patients/#{patient}")
      |> render(:show, patient: patient)
    end
  end

  def show(conn, %{"id" => id}) do
    patient = Patients.get_patient!(id)
    render(conn, :show, patient: patient)
  end

  def update(conn, %{"id" => id, "patient" => patient_params}) do
    patient = Patients.get_patient!(id)

    with {:ok, %Patient{} = patient} <- Patients.update_patient(patient, patient_params) do
      render(conn, :show, patient: patient)
    end
  end

  def delete(conn, %{"id" => id}) do
    patient = Patients.get_patient!(id)

    with {:ok, %Patient{}} <- Patients.delete_patient(patient) do
      send_resp(conn, :no_content, "")
    end
  end
end
