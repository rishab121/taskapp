defmodule TaskappWeb.ManageController do
  use TaskappWeb, :controller

  alias Taskapp.Tracker
  alias Taskapp.Tracker.Manage

  def index(conn, _params) do
    managers = Tracker.list_managers()
    current_user = conn.assigns[:current_user]
    get_users_without_managers = Taskapp.Tracker.get_users_without_managers()
    render(conn, "index.html", managers: managers, get_users_without_managers: get_users_without_managers)
  end

  def new(conn, _params) do
    changeset = Tracker.change_manage(%Manage{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"manage" => manage_params}) do
    case Tracker.create_manage(manage_params) do
      {:ok, manage} ->
        conn
        |> put_flash(:info, "Manage created successfully.")
        |> redirect(to: manage_path(conn, :show, manage))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    manage = Tracker.get_manage!(id)
    render(conn, "show.html", manage: manage)
  end

  def edit(conn, %{"id" => id}) do
    manage = Tracker.get_manage!(id)
    changeset = Tracker.change_manage(manage)
    render(conn, "edit.html", manage: manage, changeset: changeset)
  end

  def update(conn, %{"id" => id, "manage" => manage_params}) do
    manage = Tracker.get_manage!(id)

    case Tracker.update_manage(manage, manage_params) do
      {:ok, manage} ->
        conn
        |> put_flash(:info, "Manage updated successfully.")
        |> redirect(to: manage_path(conn, :show, manage))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", manage: manage, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    manage = Tracker.get_manage!(id)
    {:ok, _manage} = Tracker.delete_manage(manage)

    conn
    |> put_flash(:info, "Manage deleted successfully.")
    |> redirect(to: manage_path(conn, :index))
  end
end
