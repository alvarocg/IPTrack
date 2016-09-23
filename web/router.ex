defmodule Iptrack.Router do
  use Iptrack.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Iptrack.Auth, repo: Iptrack.Repo    
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Iptrack do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/manage", Iptrack do
    pipe_through [:browser, :authenticate_user] # Use the default browser stack

    resources "/portfolios", PortfolioController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Iptrack do
  #   pipe_through :api
  # end
end
