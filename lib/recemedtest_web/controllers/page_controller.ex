defmodule RecemedtestWeb.PageController do
  use RecemedtestWeb, :controller

  def home(conn, _params) do
    if @current_scope do
      redirect(conn, to: ~p"/users/log-in")
    else
      redirect(conn, to: ~p"/admin/practitioners")
    end
  end
end
