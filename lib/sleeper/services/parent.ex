defmodule Sleeper.Services.Parent do
  # API

  def start_link do
    GenServer.start_link(__MODULE__, "serverA", name: :serverA)
    GenServer.start_link(__MODULE__, "serverB", name: :serverB)
    GenServer.start_link(__MODULE__, "serverC", name: :serverC)
  end

  def add_message(name, message) do
    GenServer.cast(name, {:add_message, message})
  end

  def spin_server(name) do
    GenServer.cast(name, {:spin_server, name})
  end

  def make_active(name) do
    GenServer.call(name, :make_active)
  end


  def get_messages() do
    GenServer.call(:chat_room, :get_messages)
  end

  def get_servers() do
    GenServer.call(:chat_room, :get_servers)
  end

# SERVER

def init(server_name) do
  IO.puts "Sleeper Server: #{server_name}"
  #Sleeper.accept(8888)
  {:ok, server_name}
end



def handle_cast({:add_message, new_message}, messages) do
  {:noreply, [new_message | messages]}
end

def handle_cast({:spin_server, name}, name) do
  IO.puts "Spinning Server For: #{name}"
  {:noreply, Sleeper.accept(8889)}
end

def handle_call(:get_servers, _from, servers) do
  {:reply, servers, servers}
end

def handle_call(:make_active, _from, name) do
  IO.puts "Making Server: #{name} the Master"
  Sleeper.accept(8888)
  {:reply, name, name}
end

end
