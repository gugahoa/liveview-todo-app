defmodule TodoApp.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :text, :string, null: false
      add :done, :boolean, default: false, null: false

      timestamps()
    end

  end
end
