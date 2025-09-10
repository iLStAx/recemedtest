defmodule RecemedtestWeb.Admin.PrescriptionController do
  use RecemedtestWeb, :controller

  alias Recemedtest.Prescriptions
  alias Recemedtest.Prescriptions.Prescription
  alias Recemedtest.Practitioners.Practitioner

  action_fallback RecemedtestWeb.FallbackController

  def index(conn, params) do
    { prescriptions, meta } = Prescriptions.list_prescriptions(params)
    render(conn, :index, prescriptions: prescriptions, meta: meta)
  end

  def new(conn, _params) do
    changeset = Prescriptions.change_prescription(%Prescription{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"prescription" => prescription_params}) do
    case Prescriptions.create_prescription(prescription_params) do
      {:ok, prescription} ->
        conn
        |> put_flash(:info, "Prescription created successfully.")
        |> redirect(to: ~p"/admin/prescriptions/#{prescription}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    try do
      prescription = Prescriptions.get_prescription!(id)
      render(conn, :show, prescription: prescription)
    rescue
      Ecto.NoResultsError ->
        {:error, :not_found}
    end
  end

  def edit(conn, %{"id" => id}) do
    try do
      prescription = Prescriptions.get_prescription!(id)
      changeset = Prescriptions.change_prescription(prescription)
      render(conn, :edit, prescription: prescription, changeset: changeset)
    rescue
      Ecto.NoResultsError ->
        {:error, :not_found}
    end
  end

  def update(conn, %{"id" => id, "prescription" => prescription_params}) do
    try do
      prescription = Prescriptions.get_prescription!(id)

      case Prescriptions.update_prescription(prescription, prescription_params) do
        {:ok, prescription} ->
          conn
          |> put_flash(:info, "Prescription updated successfully.")
          |> redirect(to: ~p"/admin/prescriptions/#{prescription}")

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, :edit, prescription: prescription, changeset: changeset)
      end
    rescue
      Ecto.NoResultsError ->
        {:error, :not_found}
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      prescription = Prescriptions.get_prescription!(id)
      {:ok, _prescription} = Prescriptions.delete_prescription(prescription)

      conn
      |> put_flash(:info, "Prescription deleted successfully.")
      |> redirect(to: ~p"/admin/prescriptions")
    rescue
      Ecto.NoResultsError ->
        {:error, :not_found}
    end
  end
end
