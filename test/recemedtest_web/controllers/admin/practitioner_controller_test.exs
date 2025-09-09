defmodule RecemedtestWeb.Admin.PractitionerControllerTest do
  use RecemedtestWeb.ConnCase

  import Recemedtest.PractitionersFixtures
  import Recemedtest.AccountsFixtures

  @create_attrs %{first_name: "some first_name", last_name: "some last_name", phone: "some phone", birthdate: ~D[2025-09-07], email: "some email"}
  @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", phone: "some updated phone", birthdate: ~D[2025-09-08], email: "some updated email"}
  @invalid_attrs %{first_name: nil, last_name: nil, phone: nil, birthdate: nil, email: nil}

  setup %{conn: conn} do
    user = user_fixture()
    conn = log_in_user(conn, user)
    {:ok, conn: conn, user: user}
  end

  describe "index" do
    test "lists all practitioners", %{conn: conn} do
      conn = get(conn, ~p"/admin/practitioners")
      assert html_response(conn, 200) =~ "Listing Practitioners"
    end
  end

  describe "new practitioner" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/admin/practitioners/new")
      assert html_response(conn, 200) =~ "New Practitioner"
    end
  end

  describe "create practitioner" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/admin/practitioners", practitioner: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/admin/practitioners/#{id}"

      conn = get(conn, ~p"/admin/practitioners/#{id}")
      assert html_response(conn, 200) =~ "Practitioner #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/admin/practitioners", practitioner: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Practitioner"
    end
  end

  describe "edit practitioner" do
    setup [:create_practitioner]

    test "renders form for editing chosen practitioner", %{conn: conn, practitioner: practitioner} do
      conn = get(conn, ~p"/admin/practitioners/#{practitioner}/edit")
      assert html_response(conn, 200) =~ "Edit Practitioner"
    end
  end

  describe "update practitioner" do
    setup [:create_practitioner]

    test "redirects when data is valid", %{conn: conn, practitioner: practitioner} do
      conn = put(conn, ~p"/admin/practitioners/#{practitioner}", practitioner: @update_attrs)
      assert redirected_to(conn) == ~p"/admin/practitioners/#{practitioner}"

      conn = get(conn, ~p"/admin/practitioners/#{practitioner}")
      assert html_response(conn, 200) =~ "some updated first_name"
    end

    test "renders errors when data is invalid", %{conn: conn, practitioner: practitioner} do
      conn = put(conn, ~p"/admin/practitioners/#{practitioner}", practitioner: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Practitioner"
    end
  end

  describe "delete practitioner" do
    setup [:create_practitioner]

    test "deletes chosen practitioner", %{conn: conn, practitioner: practitioner} do
      conn = delete(conn, ~p"/admin/practitioners/#{practitioner}")
      assert redirected_to(conn) == ~p"/admin/practitioners"

      assert_error_sent 404, fn ->
        get(conn, ~p"/admin/practitioners/#{practitioner}")
      end
    end
  end

  defp create_practitioner(_) do
    practitioner = practitioner_fixture()

    %{practitioner: practitioner}
  end
end
