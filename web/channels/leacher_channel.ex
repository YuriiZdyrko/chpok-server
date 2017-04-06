defmodule ChpokServer.LeacherChannel do
  use Phoenix.Channel
  alias ChpokServer.SeederChannel
  require Logger

  @doc """
  Authorize socket to subscribe and broadcast events on this channel & topic
  Possible Return Values
  `{:ok, socket}` to authorize subscription for channel for requested topic
  `:ignore` to deny subscription/broadcast on this channel
  for the requested topic
  """
  def join("leachers:" <> leacher, message, socket) do

    IO.puts("Leacher #{leacher} joined")

    Process.flag(:trap_exit, true)
    :timer.send_interval(5000, :ping)
    send(self(), {:after_join, message})

    {:ok, socket}
  end

  def handle_info({:after_join, msg}, socket) do
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

  def handle_in("leaching_request", %{"seeder" => seeder, "leacher" => leacher}, socket) do
    IO.puts("ACCEPTED leaching_request on server")
    ChpokServer.Endpoint.broadcast_from! self(), "seeders:" <> seeder,
        "leaching_request", %{leacher: leacher}
    IO.puts("LEACHING REQUEST SENT TO SEEDER")
    {:noreply, socket}
  end
end
