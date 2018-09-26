defmodule Sleeper.Services.ServerSupervisor do
  use Supervisor

  def start_link(name) do
    IO.puts "Started Sleeper"
    Supervisor.start_link(__MODULE__, [name: name])
  end

  def init(_) do
    children = [
      worker(Sleeper.Services.Parent, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
