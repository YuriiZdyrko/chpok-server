defmodule ChpokServer.PageController do
  use ChpokServer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
