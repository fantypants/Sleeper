defmodule Sleeper do
  @moduledoc """
  Sleeper keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """



  def accept(port) do

  with {:ok, socket} <- :gen_tcp.listen(port,[:binary, packet: :line, active: false]) do
    IO.puts "Sleeper is Accepting connections on port #{port}"
    loop_acceptor(socket)
  else
    {:error, :eaddrinuse} -> IO.puts "Sleeper is Blocked/Busy on port #{port}"
  end
end


defp loop_acceptor(socket) do
  {:ok, client} = :gen_tcp.accept(socket)
  Task.Supervisor.start_child(Sleeper.TaskSupervisor, fn -> serve(client) end)
  loop_acceptor(socket)
end


defp serve(client) do
  client
  |> read_line()
  |> write_line(client)

  serve(client)
end

defp read_line(socket) do
  {:ok, data} = :gen_tcp.recv(socket, 0)
  data
end

defp write_line(line, socket) do
  :gen_tcp.send(socket, "The Server Returns: "<>line)
end

end
