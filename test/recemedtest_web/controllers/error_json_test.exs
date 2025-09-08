defmodule RecemedtestWeb.ErrorJSONTest do
  use RecemedtestWeb.ConnCase, async: true

  test "renders 404" do
    assert RecemedtestWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert RecemedtestWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
