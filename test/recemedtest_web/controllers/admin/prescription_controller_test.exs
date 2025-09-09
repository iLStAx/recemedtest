defmodule RecemedtestWeb.Admin.PrescriptionControllerTest do
  use RecemedtestWeb.ConnCase

  import Recemedtest.PrescriptionsFixtures
  import Recemedtest.AccountsFixtures

  @create_attrs %{detail: "some detail"}
  @update_attrs %{detail: "some updated detail"}
  @invalid_attrs %{detail: nil}

  setup %{conn: conn} do
    user = user_fixture()
    conn = log_in_user(conn, user)
    {:ok, conn: conn, user: user}
  end

  describe "index" do
    test "lists all prescriptions", %{conn: conn} do
      conn = get(conn, ~p"/admin/prescriptions")
      assert html_response(conn, 200) =~ "Listing Prescriptions"
    end
  end
end
