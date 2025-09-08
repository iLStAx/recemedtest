defmodule RecemedtestWeb.PageController do
  use RecemedtestWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
