defmodule RecemedtestWeb.Api.PractitionerController do
  use RecemedtestWeb, :controller

  alias Recemedtest.Practitioners.Practitioner
  alias Recemedtest.Practitioners

  action_fallback RecemedtestWeb.FallbackController

  def index(conn, params) do
    { practitioners, _meta } = Practitioners.list_practitioners(params)
    render(conn, :index, practitioners: practitioners)
  end

  def create(conn, %{"practitioner" => practitioner_params}) do
    with {:ok, %Practitioner{} = practitioner} <- Practitioners.create_practitioner(practitioner_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/practitioners/#{practitioner}")
      |> render(:show, practitioner: practitioner)
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

  def update(conn, %{"id" => id, "practitioner" => practitioner_params}) do
    practitioner = Practitioners.get_practitioner!(id)

    with {:ok, %Practitioner{} = practitioner} <- Practitioners.update_practitioner(practitioner, practitioner_params) do
      render(conn, :show, practitioner: practitioner)
    end
  end

  def delete(conn, %{"id" => id}) do
    try do
      practitioner = Practitioners.get_practitioner!(id)

      with {:ok, %Practitioner{}} <-Practitioners.delete_practitioner(practitioner) do
        send_resp(conn, :no_content, "")
      end
    rescue
      Ecto.NoResultsError ->
        {:error, :not_found}
    end
  end
end
