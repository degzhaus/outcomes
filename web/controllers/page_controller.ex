defmodule Outcomes.PageController do
  use Outcomes.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
