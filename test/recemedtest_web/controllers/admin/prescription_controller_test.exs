defmodule RecemedtestWeb.Admin.PrescriptionControllerTest do
  use RecemedtestWeb.ConnCase

  import Recemedtest.PrescriptionsFixtures

  @create_attrs %{detail: "some detail"}
  @update_attrs %{detail: "some updated detail"}
  @invalid_attrs %{detail: nil}

  describe "index" do
    test "lists all prescriptions", %{conn: conn} do
      conn = get(conn, ~p"/admin/prescriptions")
      assert html_response(conn, 200) =~ "Listing Prescriptions"
    end
  end

  describe "new prescription" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/admin/prescriptions/new")
      assert html_response(conn, 200) =~ "New Prescription"
    end
  end

  describe "create prescription" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/admin/prescriptions", prescription: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/admin/prescriptions/#{id}"

      conn = get(conn, ~p"/admin/prescriptions/#{id}")
      assert html_response(conn, 200) =~ "Prescription #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/admin/prescriptions", prescription: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Prescription"
    end
  end

  describe "edit prescription" do
    setup [:create_prescription]

    test "renders form for editing chosen prescription", %{conn: conn, prescription: prescription} do
      conn = get(conn, ~p"/admin/prescriptions/#{prescription}/edit")
      assert html_response(conn, 200) =~ "Edit Prescription"
    end
  end

  describe "update prescription" do
    setup [:create_prescription]

    test "redirects when data is valid", %{conn: conn, prescription: prescription} do
      conn = put(conn, ~p"/admin/prescriptions/#{prescription}", prescription: @update_attrs)
      assert redirected_to(conn) == ~p"/admin/prescriptions/#{prescription}"

      conn = get(conn, ~p"/admin/prescriptions/#{prescription}")
      assert html_response(conn, 200) =~ "some updated detail"
    end

    test "renders errors when data is invalid", %{conn: conn, prescription: prescription} do
      conn = put(conn, ~p"/admin/prescriptions/#{prescription}", prescription: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Prescription"
    end
  end

  describe "delete prescription" do
    setup [:create_prescription]

    test "deletes chosen prescription", %{conn: conn, prescription: prescription} do
      conn = delete(conn, ~p"/admin/prescriptions/#{prescription}")
      assert redirected_to(conn) == ~p"/admin/prescriptions"

      assert_error_sent 404, fn ->
        get(conn, ~p"/admin/prescriptions/#{prescription}")
      end
    end
  end

  defp create_prescription(_) do
    prescription = prescription_fixture()

    %{prescription: prescription}
  end
end
