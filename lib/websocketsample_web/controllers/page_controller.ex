defmodule WebsocketsampleWeb.PageController do
  use WebsocketsampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
