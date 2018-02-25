defmodule Taskapp.Tracker.Manage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Taskapp.Tracker.Manage


  schema "managers" do
    belongs_to :manager, Taskapp.Accounts.User
    belongs_to :manages, Taskapp.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Manage{} = manage, attrs) do
    manage
    |> cast(attrs, [:manager_id, :manages_id])
    |> validate_required([:manager_id, :manages_id])
  end
end
