defmodule ChpokServer.UserSocket do
  use Phoenix.Socket

  channel "seeders:*", ChpokServer.SeederChannel
  channel "leachers:*", ChpokServer.LeacherChannel

  transport :websocket, Phoenix.Transports.WebSocket
  transport :longpoll, Phoenix.Transports.LongPoll

  def connect(_params, socket) do
    IO.puts("HELLO FROM USER SOCKET")
    {:ok, socket}
  end

  def id(_socket), do: nil
end
