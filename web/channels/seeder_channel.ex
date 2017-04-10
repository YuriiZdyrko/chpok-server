defmodule ChpokServer.SeederChannel do
  use Phoenix.Channel
  require Logger
  alias ChpokServer.SeedersStore

  @doc """
  Authorize socket to subscribe and broadcast events on this channel & topic
  Possible Return Values
  `{:ok, socket}` to authorize subscription for channel for requested topic
  `:ignore` to deny subscription/broadcast on this channel
  for the requested topic
  """
  def join("seeders:" <> seeder, message, socket) do

    # Store seeder name
    SeedersStore.put(seeder)
    IO.puts("Seeder #{seeder} joined")

    Process.flag(:trap_exit, true)
    :timer.send_interval(5000, :ping)
    send(self(), {:after_join, message})

    {:ok, socket}
  end

  def handle_in("new:" <> path, %{"leacher" => leacher} = msg, socket) do
    ChpokServer.Endpoint.broadcast(
      "leachers:" <> leacher,
      "new:" <> path,
      msg
    )
    {:reply, :new_msg_handled, socket}
  end

  def handle_info({:after_join, _msg}, socket) do
    push socket, "join", %{status: "connected"}
    {:noreply, socket}
  end

  def handle_info(:ping, socket) do
    {:noreply, socket}
  end

  def terminate(reason, _socket) do
    Logger.debug"> leave #{inspect reason}"
    :ok
  end
end
