defmodule Outcomes.Router do
  use Outcomes.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  scope "/", Outcomes do
    pipe_through [:browser, :browser_session] # Use the default browser stack

    get "/", PageController, :index

    resources "/users", UserController
    resources "/companies", CompanyController
    resources "/jobs", JobController
    resources "/applications", ApplicationController

    get "/report", ReportController, :report
  end

  # Other scopes may use custom stacks.
  # scope "/api", Outcomes do
  #   pipe_through :api
  # end
end
