defmodule TaskappWeb.TimeBlocksController do
  use TaskappWeb, :controller

  alias Taskapp.Tracker
  alias Taskapp.Tracker.TimeBlocks

  action_fallback TaskappWeb.FallbackController

  def index(conn, _params) do
    times = Tracker.list_times()
    render(conn, "index.json", times: times)
  end

  def create(conn, %{"time_blocks" => time_blocks_params}) do
    with {:ok, %TimeBlocks{} = time_blocks} <- Tracker.create_time_blocks(time_blocks_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", time_blocks_path(conn, :show, time_blocks))
      |> render("show.json", time_blocks: time_blocks)
    end
  end

  def show(conn, %{"id" => id}) do
    time_blocks = Tracker.get_time_blocks!(id)
    render(conn, "show.json", time_blocks: time_blocks)
  end

  def update(conn, %{"id" => id, "time_blocks" => time_blocks_params}) do
    time_blocks = Tracker.get_time_blocks!(id)

    with {:ok, %TimeBlocks{} = time_blocks} <- Tracker.update_time_blocks(time_blocks, time_blocks_params) do
      render(conn, "show.json", time_blocks: time_blocks)
    end
  end

  def delete(conn, %{"id" => id}) do
    time_blocks = Tracker.get_time_blocks!(id)
    with {:ok, %TimeBlocks{}} <- Tracker.delete_time_blocks(time_blocks) do
      send_resp(conn, :no_content, "")
    end
  end
end
