defmodule Taskapp.Tracker.TimeBlocks do
  use Ecto.Schema
  import Ecto.Changeset
  alias Taskapp.Tracker.TimeBlocks


  schema "times" do
    field :end, :time
    field :start, :time
    #field :task_assigned_id, :id
    belongs_to :task_assigned, Taskapp.Tracker.TimeBlocks

    timestamps()
  end

  @doc false
  def changeset(%TimeBlocks{} = time_blocks, attrs) do
    time_blocks
    |> cast(attrs, [:start, :end, :task_assigned_id])
    |> validate_required([:start, :end, :task_assigned_id])
  end
end
