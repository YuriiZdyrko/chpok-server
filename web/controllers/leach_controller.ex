defmodule ChpokServer.LeachController do
  use ChpokServer.Web, :controller
  alias ChpokServer.SeedersStore
  alias ChpokServer.SeederChannel
  import Poison
  import Plug.Conn
  import IEx

  def seeders_list(conn, _params) do
    with seeders <- SeedersStore.get_names(),
         {:ok, body} <- Poison.encode(seeders) do
      conn |> send_resp(200, body)
    end
  end
end
