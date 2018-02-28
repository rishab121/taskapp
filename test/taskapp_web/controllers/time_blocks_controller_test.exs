defmodule TaskappWeb.TimeBlocksControllerTest do
  use TaskappWeb.ConnCase

  alias Taskapp.Tracker
  alias Taskapp.Tracker.TimeBlocks

  @create_attrs %{end: ~T[14:00:00.000000], start: ~T[14:00:00.000000]}
  @update_attrs %{end: ~T[15:01:01.000000], start: ~T[15:01:01.000000]}
  @invalid_attrs %{end: nil, start: nil}

  def fixture(:time_blocks) do
    {:ok, time_blocks} = Tracker.create_time_blocks(@create_attrs)
    time_blocks
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all times", %{conn: conn} do
      conn = get conn, time_blocks_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create time_blocks" do
    test "renders time_blocks when data is valid", %{conn: conn} do
      conn = post conn, time_blocks_path(conn, :create), time_blocks: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, time_blocks_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "end" => ~T[14:00:00.000000],
        "start" => ~T[14:00:00.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, time_blocks_path(conn, :create), time_blocks: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update time_blocks" do
    setup [:create_time_blocks]

    test "renders time_blocks when data is valid", %{conn: conn, time_blocks: %TimeBlocks{id: id} = time_blocks} do
      conn = put conn, time_blocks_path(conn, :update, time_blocks), time_blocks: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, time_blocks_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "end" => ~T[15:01:01.000000],
        "start" => ~T[15:01:01.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn, time_blocks: time_blocks} do
      conn = put conn, time_blocks_path(conn, :update, time_blocks), time_blocks: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete time_blocks" do
    setup [:create_time_blocks]

    test "deletes chosen time_blocks", %{conn: conn, time_blocks: time_blocks} do
      conn = delete conn, time_blocks_path(conn, :delete, time_blocks)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, time_blocks_path(conn, :show, time_blocks)
      end
    end
  end

  defp create_time_blocks(_) do
    time_blocks = fixture(:time_blocks)
    {:ok, time_blocks: time_blocks}
  end
end
