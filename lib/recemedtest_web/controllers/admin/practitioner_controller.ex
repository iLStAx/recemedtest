defmodule RecemedtestWeb.Admin.PractitionerController do
  use RecemedtestWeb, :controller

  alias Recemedtest.Practitioners
  alias Recemedtest.Practitioners.Practitioner

  action_fallback RecemedtestWeb.FallbackController

  def index(conn, params) do
    { practitioners, meta } = Practitioners.list_practitioners(params)
    render(conn, :index, practitioners: practitioners, meta: meta)
  end

  def new(conn, _params) do
    changeset = Practitioners.change_practitioner(%Practitioner{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"practitioner" => practitioner_params}) do
    case Practitioners.create_practitioner(practitioner_params) do
      {:ok, practitioner} ->
        conn
        |> put_flash(:info, "Practitioner created successfully.")
        |> redirect(to: ~p"/admin/practitioners/#{practitioner}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    try do
      practitioner = Practitioners.get_practitioner!(id)
      render(conn, :show, practitioner: practitioner)
    rescue
      Ecto.NoResultsError ->
        {:error, :not_found}
    end
  end

  def edit(conn, %{"id" => id}) do
    try do
      practitioner = Practitioners.get_practitioner!(id)
      changeset = Practitioners.change_practitioner(practitioner)
      render(conn, :edit, practitioner: practitioner, changeset: changeset)
    rescue
      Ecto.NoResultsError ->
        {:error, :not_found}
    end
  end

  def update(conn, %{"id" => id, "practitioner" => practitioner_params}) do
    try do
      practitioner = Practitioners.get_practitioner!(id)

      case Practitioners.update_practitioner(practitioner, practitioner_params) do
        {:ok, practitioner} ->
          conn
          |> put_flash(:info, "Practitioner updated successfully.")
          |> redirect(to: ~p"/admin/practitioners/#{practitioner}")

        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, :edit, practitioner: practitioner, changeset: changeset)
      end
    rescue
      Ecto.NoResultsError ->
        {:error, :not_found}
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      practitioner = Practitioners.get_practitioner!(id)
      {:ok, _practitioner} = Practitioners.delete_practitioner(practitioner)

      conn
      |> put_flash(:info, "Practitioner deleted successfully.")
      |> redirect(to: ~p"/admin/practitioners")
    rescue
      Ecto.NoResultsError ->
        {:error, :not_found}
    end
  end
end
