defmodule TaskappWeb.Router do
  use TaskappWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session #parses cookie header
    plug :get_current_user
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  def get_current_user(conn, _params) do
    user_id = get_session(conn, :user_id)
    user = Taskapp.Accounts.get_user(user_id || -1)
    assign(conn, :current_user, user)
  end

  scope "/", TaskappWeb do
    pipe_through :browser 
    get "/", PageController, :index
    resources "/users", UserController
    resources "/tasks", TaskController
    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
    get "/feed", PageController, :feed

  end
end
