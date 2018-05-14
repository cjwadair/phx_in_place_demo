defmodule PhxInPlaceDemoWeb.Router do
  use PhxInPlaceDemoWeb, :router

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

  scope "/", PhxInPlaceDemoWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/suppliers", SupplierController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhxInPlaceDemoWeb do
  #   pipe_through :api
  # end
end
