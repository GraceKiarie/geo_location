defmodule GenLocationWeb.CsvPathLive do
  use GenLocationWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, assign(socket, title: "CSV")}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <h2><%= @title %></h2>

      <form phx-submit="save">
        <input type="text" name="csv_path"
               placeholder="Paste the path to your CSV file"/>

        <button type="submit">
         Submit
        </button>
      </form>
    """
  end

  @impl true
  def handle_event("save", %{"csv_path" => csv_path}, socket) do
    IO.inspect(csv_path)
    {:noreply, socket |> put_flash(:info, "Data cleaning and upload started")}
  end
end
