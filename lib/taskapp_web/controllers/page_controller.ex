defmodule TaskappWeb.PageController do
  use TaskappWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
  def feed(conn, _params) do
    current_user = conn.assigns[:current_user]
    underlings = Taskapp.Tracker.managers_map_for(current_user.id)
    tasks= Taskapp.Tracker.get_tasks_of_underlings(current_user.id)
    manager = Taskapp.Tracker.get_manager_id(current_user.id)
    #tasks = Taskapp.Tracker.list_tasks()
    changeset = Taskapp.Tracker.change_task(%Taskapp.Tracker.Task{})
    render(conn, "feed.html", tasks: tasks, changeset: changeset, underlings: underlings, manager: manager)
  end
  def input(conn, _params) do
    changeset = Taskapp.Tracker.change_time_blocks(%Taskapp.Tracker.TimeBlocks{})
    render(conn,"input.html", changeset: changeset)
  end
end
