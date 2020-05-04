defmodule TodoAppWeb.TaskLive.Index do
  use TodoAppWeb, :live_view

  alias TodoApp.Todos
  alias TodoApp.Todos.Task

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       tasks: fetch_tasks(),
       changeset: Todos.change_task(%Task{})
     )}
  end

  @impl true
  def handle_event("toggle-task", %{"_target" => [task_id]}, socket) do
    with task <- Todos.get_task!(task_id),
         {:ok, _} <- Todos.update_task(task, %{done: not task.done}),
         task_list <- fetch_tasks() do
      {:noreply, assign(socket, :tasks, task_list)}
    end
  end

  def handle_event("create-task", %{"task" => task}, socket) do
    case Todos.create_task(task) do
      {:ok, _} ->
        {:noreply,
         assign(socket,
           tasks: fetch_tasks(),
           changeset: Todos.change_task(%Task{})
         )}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_event("validate", %{"task" => task}, socket) do
    changeset =
      %Task{}
      |> Todos.change_task(task)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  defp fetch_tasks do
    Todos.list_tasks()
  end
end
