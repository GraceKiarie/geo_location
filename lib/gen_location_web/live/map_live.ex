defmodule GenLocationWeb.MapLive do
  use GenLocationWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, locations: [])}
  end
end
