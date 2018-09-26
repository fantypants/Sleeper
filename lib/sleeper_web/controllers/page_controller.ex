defmodule SleeperWeb.PageController do
  use SleeperWeb, :controller

  def index(conn, _params) do

    #Sleeper.Services.Parent.make_active(:serverA)
    Supervisor.which_children(Sleeper.Supervisor) |> IO.inspect
    render conn, "index.html"
  end
end
