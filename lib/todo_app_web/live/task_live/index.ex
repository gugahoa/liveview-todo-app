defmodule TodoAppWeb.TaskLive.Index do
  use TodoAppWeb, :live_view

  alias TodoApp.Todos

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :tasks, fetch_tasks())}
  end

  @impl true
  def handle_event("toggle-task", %{"_target" => [task_id]}, socket) do
    with task <- Todos.get_task!(task_id),
         {:ok, _} <- Todos.update_task(task, %{done: not task.done}),
         task_list <- fetch_tasks() do
      {:noreply, assign(socket, :tasks, task_list)}
    end
  end

  defp fetch_tasks do
    Todos.list_tasks()
  end
end
