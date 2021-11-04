defmodule GenLocation.Producer do
  use GenStage
  alias GenLocation.CsvParser

  def start_link(initial \\ 0) do
    GenStage.start_link(__MODULE__, initial, name: __MODULE__)
  end

  def init(counter), do: {:producer, counter}

  def handle_demand(demand, state) do
    events = CsvParser.parse_data()
    {:noreply, events, state + demand}
  end
end
