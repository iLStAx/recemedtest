defmodule RecemedtestWeb.Admin.PrescriptionController do
  use RecemedtestWeb, :controller

  alias Recemedtest.Prescriptions
  alias Recemedtest.Prescriptions.Prescription
  alias Recemedtest.Practitioners.Practitioner

  def index(conn, _params) do
    prescriptions = Prescriptions.list_prescriptions()
    render(conn, :index, prescriptions: prescriptions)
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
    prescription = Prescriptions.get_prescription!(id)
    render(conn, :show, prescription: prescription)
  end

  def edit(conn, %{"id" => id}) do
    prescription = Prescriptions.get_prescription!(id)
    changeset = Prescriptions.change_prescription(prescription)
    render(conn, :edit, prescription: prescription, changeset: changeset)
  end

  def update(conn, %{"id" => id, "prescription" => prescription_params}) do
    prescription = Prescriptions.get_prescription!(id)

    case Prescriptions.update_prescription(prescription, prescription_params) do
      {:ok, prescription} ->
        conn
        |> put_flash(:info, "Prescription updated successfully.")
        |> redirect(to: ~p"/admin/prescriptions/#{prescription}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, prescription: prescription, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    prescription = Prescriptions.get_prescription!(id)
    {:ok, _prescription} = Prescriptions.delete_prescription(prescription)

    conn
    |> put_flash(:info, "Prescription deleted successfully.")
    |> redirect(to: ~p"/admin/prescriptions")
  end
end
