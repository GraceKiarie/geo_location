defmodule GenLocation.Consumer do
  use GenStage
  require Integer

  def start_link(_initial) do
    GenStage.start_link(__MODULE__, :state)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [GenLocation.ProducerConsumer]}
  end

  def handle_events(events, _from, state) do
    counter = 0

    for event <- events do
      IO.inspect({self(), event, state, counter})
    end

    {:noreply, [], state}
  end
end
