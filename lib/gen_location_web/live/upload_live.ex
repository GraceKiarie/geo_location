defmodule GenLocationWeb.CsvPathLive do
  use GenLocationWeb, :live_view

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    {:ok, assign(socket, title: "CSV")}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <h1 class="text-red-500 text-5xl font-bold text-center"><%= @title %></h1>
    <div class="min-h-full flex flex-col justify-center py-12 md:px-6 lg:px-8">
    <div class="mt-8 md:mx-auto md:w-full flex">
    <div class="bg-white py-8 px-4 shadow md:rounded-lg md:px-10 w-1/2">
      <form  phx-submit="save">
        <div>
          <label for="email" class="block text-md font-medium text-gray-700">
            CSV Path
          </label>
          <div class="mt-1">
            <input id="email" name="csv_path" type="text" required class="appearance-none block w-full px-3 py-2 border border-gray-300 rounded-md shadow-md placeholder-gray-400 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 md:text-md">
          </div>
        </div>
        <div>
          <button type="submit" class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-md text-md font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
            Submit
          </button>
        </div>
      </form>
    </div>
    </div>
    </div>
    """
  end

  @impl true
  def handle_event("save", %{"csv_path" => csv_path}, socket) do
    IO.inspect(csv_path)
    GenLocation.DataFlow.csv_data(csv_path)
    {:noreply, socket |> put_flash(:info, "Data cleaning and upload started")}
  end
end
