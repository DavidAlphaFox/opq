defmodule OPQ.Worker do
  @moduledoc """
  A default worker that simply executes an item if it's a function.
  """

  def start_link(item) do
    Task.start_link(fn ->
      Process.flag(:trap_exit, true)
      process_item(item)
    end)
  end

  defp process_item({mod, fun, args}), do: apply(mod, fun, args)
  defp process_item(item) when is_function(item), do: item.()
  defp process_item(item), do: item
end
