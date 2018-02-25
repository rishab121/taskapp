defmodule Taskapp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Taskapp.Accounts.User
  alias Taskapp.Tracker.Manage

  schema "users" do
    field :name, :string
    # preload the users who this user manages(manages)
    # this.user = manager_id
    # A user has one manager
    has_many :manager_managers, Manage, foreign_key: :manager_id
    # A user has manages many
    has_many :manages_managers, Manage, foreign_key: :manages_id

    # get the manager from manages
    # to get our managers get the list of manages 
    # our manager is the manager of manages
    has_one :managers, through: [:manages_managers, :manager]

    # get the manges from manager
    has_many :managess, through: [:manager_managers, :manages]
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
