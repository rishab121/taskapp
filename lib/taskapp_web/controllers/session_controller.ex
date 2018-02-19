defmodule TaskappWeb.SessionController do
    use TaskappWeb, :controller
  
    alias Taskapp.Accounts
    alias Taskapp.Accounts.User
  
    def create(conn, %{"name" => name}) do
     #choice made here add things
     # user id is the right choice here
     # up to date version of user object if the assigned pbject gets changed

      user = Accounts.get_user_by_name(name)
      if user do
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Welcome back #{user.name}")
        |> redirect(to: "/feed")
      else
        conn
        |> put_flash(:error, "Can't create session")
        |> redirect(to: page_path(conn, :index))
      end
    end
  
    def delete(conn, _params) do
      conn
      |> delete_session(:user_id)
      |> put_flash(:info, "Logged out")
      |> redirect(to: page_path(conn, :index))
    end
  end