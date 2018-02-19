defmodule TaskappWeb.PageController do
  use TaskappWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
  def feed(conn, _params) do
    tasks = Taskapp.Tracker.list_tasks()
    changeset = Taskapp.Tracker.change_task(%Taskapp.Tracker.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end
end
