defmodule TaskappWeb.TaskController do
  use TaskappWeb, :controller

  alias Taskapp.Tracker
  alias Taskapp.Tracker.Task
  alias Taskapp.Accounts

  def index(conn, _params) do
    tasks = Tracker.list_tasks()
   # users = Accounts.list_users()
    #current_user = conn.assigns[:current_user]
    #underlings = Taskapp.Tracker.managers_map_for(current_user.id)
    #manager = Taskapp.Tracker.get_manager_id(current_user.id)
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    #users = Accounts.list_users()
    changeset = Tracker.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    #users = Accounts.list_users()
    case Tracker.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
   # users = Accounts.list_users()
    task = Tracker.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    #users = Accounts.list_users()
    task = Tracker.get_task!(id)
    changeset = Tracker.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tracker.get_task!(id)
    #users = Accounts.list_users()
    case Tracker.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tracker.get_task!(id)
    {:ok, _task} = Tracker.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: page_path(conn, :feed))
  end
end
