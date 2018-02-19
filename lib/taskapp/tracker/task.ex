defmodule Taskapp.Tracker.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Taskapp.Tracker.Task


  schema "tasks" do
    field :description, :string
    field :task_completed, :boolean, default: false
    field :time_taken, :integer
    field :title, :string
    belongs_to :user_assigned, Taskapp.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :time_taken, :task_completed, :user_assigned_id])
    |> validate_required([:title, :description, :time_taken, :task_completed, :user_assigned_id])
  end
end
