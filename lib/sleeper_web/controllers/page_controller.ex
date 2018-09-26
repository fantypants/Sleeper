defmodule SleeperWeb.PageController do
  use SleeperWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
