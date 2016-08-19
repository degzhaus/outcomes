defmodule Outcomes.ReportController do
  use Outcomes.Web, :controller

  alias Guardian.Plug.EnsurePermissions

  plug EnsurePermissions, [handler: __MODULE__, default: ~w(report)] when action in [:report]

  def report(conn, params) do
    IO.inspect params
    conn
  end

  def login(conn, _params, current_user, _claims) do
    render conn, "login.html", current_user: current_user, current_auths: auths(current_user)
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "Admin authentication required")
    |> redirect(to: admin_login_path(conn, :new))
  end
end
