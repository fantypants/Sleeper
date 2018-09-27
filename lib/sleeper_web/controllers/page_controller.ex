defmodule SleeperWeb.PageController do
  use SleeperWeb, :controller

  def index(conn, _params) do

    #Sleeper.Services.Parent.shift_server(:serverA, :serverB)

    Node.list |> IO.inspect
#Supervisor.which_children(Sleeper.Supervisor) |> IO.inspect
    render conn, "index.html"
  end
end
