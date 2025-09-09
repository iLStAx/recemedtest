defmodule RecemedtestWeb.Api.PractitionerController do
  use RecemedtestWeb, :controller

  alias Recemedtest.Practitioners
  alias Recemedtest.Practitioners.Practitioner

  def index(conn, params) do
    practitioners = Practitioners.list_practitioners(params)
    render(conn, :index, practitioners: practitioners)
  end

  def create(conn, %{"practitioner" => practitioner_params}) do
    case Practitioners.create_practitioner(practitioner_params) do
      {:ok, practitioner} ->
        conn
        |> put_flash(:info, "Practitioner created successfully.")
        |> redirect(to: ~p"/api/practitioners/#{practitioner}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    practitioner = Practitioners.get_practitioner!(id)
    render(conn, :show, practitioner: practitioner)
  end

  def update(conn, %{"id" => id, "practitioner" => practitioner_params}) do
    practitioner = Practitioners.get_practitioner!(id)

    case Practitioners.update_practitioner(practitioner, practitioner_params) do
      {:ok, practitioner} ->
        conn
        |> put_flash(:info, "Practitioner updated successfully.")
        |> redirect(to: ~p"/api/practitioners/#{practitioner}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, practitioner: practitioner, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    practitioner = Practitioners.get_practitioner!(id)
    {:ok, _practitioner} = Practitioners.delete_practitioner(practitioner)

    conn
    |> put_flash(:info, "Practitioner deleted successfully.")
    |> redirect(to: ~p"/api/practitioners")
  end
end
