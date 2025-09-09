defmodule RecemedtestWeb.Api.PrescriptionControllerTest do
  use RecemedtestWeb.ConnCase

  import Recemedtest.PrescriptionsFixtures
  alias Recemedtest.Prescriptions.Prescription

  @create_attrs %{
    detail: "some detail"
  }
  @update_attrs %{
    detail: "some updated detail"
  }
  @invalid_attrs %{detail: nil}

  setup :register_and_log_in_user

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all prescriptions", %{conn: conn} do
      conn = get(conn, ~p"/api/api/prescriptions")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create prescription" do
    test "renders prescription when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/prescriptions", prescription: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/api/prescriptions/#{id}")

      assert %{
               "id" => ^id,
               "detail" => "some detail"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/api/prescriptions", prescription: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update prescription" do
    setup [:create_prescription]

    test "renders prescription when data is valid", %{conn: conn, prescription: %Prescription{id: id} = prescription} do
      conn = put(conn, ~p"/api/api/prescriptions/#{prescription}", prescription: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/api/prescriptions/#{id}")

      assert %{
               "id" => ^id,
               "detail" => "some updated detail"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, prescription: prescription} do
      conn = put(conn, ~p"/api/api/prescriptions/#{prescription}", prescription: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete prescription" do
    setup [:create_prescription]

    test "deletes chosen prescription", %{conn: conn, prescription: prescription} do
      conn = delete(conn, ~p"/api/api/prescriptions/#{prescription}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/api/prescriptions/#{prescription}")
      end
    end
  end

  defp create_prescription(%{scope: scope}) do
    prescription = prescription_fixture(scope)

    %{prescription: prescription}
  end
end
