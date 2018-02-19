defmodule Taskapp.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :text, null: false
      add :time_taken, :integer, default: 0, null: false
      add :task_completed, :boolean, default: false, null: false
      add :user_assigned_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:tasks, [:user_assigned_id])
  end
end
