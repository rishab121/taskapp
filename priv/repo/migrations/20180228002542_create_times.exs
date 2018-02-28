defmodule Taskapp.Repo.Migrations.CreateTimes do
  use Ecto.Migration

  def change do
    create table(:times) do
      add :start, :time
      add :end, :time
      add :task_assigned_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:times, [:task_assigned_id])
  end
end
