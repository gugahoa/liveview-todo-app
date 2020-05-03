defmodule TodoApp.Todos.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
