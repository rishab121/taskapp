defmodule Taskapp.TrackerTest do
  use Taskapp.DataCase

  alias Taskapp.Tracker

  describe "tasks" do
    alias Taskapp.Tracker.Task

    @valid_attrs %{description: "some description", task_completed: true, time_taken: 42, title: "some title"}
    @update_attrs %{description: "some updated description", task_completed: false, time_taken: 43, title: "some updated title"}
    @invalid_attrs %{description: nil, task_completed: nil, time_taken: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Tracker.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Tracker.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Tracker.create_task(@valid_attrs)
      assert task.description == "some description"
      assert task.task_completed == true
      assert task.time_taken == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Tracker.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.description == "some updated description"
      assert task.task_completed == false
      assert task.time_taken == 43
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_task(task, @invalid_attrs)
      assert task == Tracker.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Tracker.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Tracker.change_task(task)
    end
  end

  describe "managers" do
    alias Taskapp.Tracker.Manage

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def manage_fixture(attrs \\ %{}) do
      {:ok, manage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_manage()

      manage
    end

    test "list_managers/0 returns all managers" do
      manage = manage_fixture()
      assert Tracker.list_managers() == [manage]
    end

    test "get_manage!/1 returns the manage with given id" do
      manage = manage_fixture()
      assert Tracker.get_manage!(manage.id) == manage
    end

    test "create_manage/1 with valid data creates a manage" do
      assert {:ok, %Manage{} = manage} = Tracker.create_manage(@valid_attrs)
    end

    test "create_manage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_manage(@invalid_attrs)
    end

    test "update_manage/2 with valid data updates the manage" do
      manage = manage_fixture()
      assert {:ok, manage} = Tracker.update_manage(manage, @update_attrs)
      assert %Manage{} = manage
    end

    test "update_manage/2 with invalid data returns error changeset" do
      manage = manage_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_manage(manage, @invalid_attrs)
      assert manage == Tracker.get_manage!(manage.id)
    end

    test "delete_manage/1 deletes the manage" do
      manage = manage_fixture()
      assert {:ok, %Manage{}} = Tracker.delete_manage(manage)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_manage!(manage.id) end
    end

    test "change_manage/1 returns a manage changeset" do
      manage = manage_fixture()
      assert %Ecto.Changeset{} = Tracker.change_manage(manage)
    end
  end

  describe "times" do
    alias Taskapp.Tracker.TimeBlocks

    @valid_attrs %{end: ~T[14:00:00.000000], start: ~T[14:00:00.000000]}
    @update_attrs %{end: ~T[15:01:01.000000], start: ~T[15:01:01.000000]}
    @invalid_attrs %{end: nil, start: nil}

    def time_blocks_fixture(attrs \\ %{}) do
      {:ok, time_blocks} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_time_blocks()

      time_blocks
    end

    test "list_times/0 returns all times" do
      time_blocks = time_blocks_fixture()
      assert Tracker.list_times() == [time_blocks]
    end

    test "get_time_blocks!/1 returns the time_blocks with given id" do
      time_blocks = time_blocks_fixture()
      assert Tracker.get_time_blocks!(time_blocks.id) == time_blocks
    end

    test "create_time_blocks/1 with valid data creates a time_blocks" do
      assert {:ok, %TimeBlocks{} = time_blocks} = Tracker.create_time_blocks(@valid_attrs)
      assert time_blocks.end == ~T[14:00:00.000000]
      assert time_blocks.start == ~T[14:00:00.000000]
    end

    test "create_time_blocks/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_time_blocks(@invalid_attrs)
    end

    test "update_time_blocks/2 with valid data updates the time_blocks" do
      time_blocks = time_blocks_fixture()
      assert {:ok, time_blocks} = Tracker.update_time_blocks(time_blocks, @update_attrs)
      assert %TimeBlocks{} = time_blocks
      assert time_blocks.end == ~T[15:01:01.000000]
      assert time_blocks.start == ~T[15:01:01.000000]
    end

    test "update_time_blocks/2 with invalid data returns error changeset" do
      time_blocks = time_blocks_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_time_blocks(time_blocks, @invalid_attrs)
      assert time_blocks == Tracker.get_time_blocks!(time_blocks.id)
    end

    test "delete_time_blocks/1 deletes the time_blocks" do
      time_blocks = time_blocks_fixture()
      assert {:ok, %TimeBlocks{}} = Tracker.delete_time_blocks(time_blocks)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_time_blocks!(time_blocks.id) end
    end

    test "change_time_blocks/1 returns a time_blocks changeset" do
      time_blocks = time_blocks_fixture()
      assert %Ecto.Changeset{} = Tracker.change_time_blocks(time_blocks)
    end
  end
end
