defmodule GenLocation.ProducerConsumer do
  use GenStage

  require Integer

  def start_link(_initial) do
    GenStage.start_link(__MODULE__, :state_doesnt_matter, name: __MODULE__)
  end

  def init(state) do
    {:producer_consumer, state, subscribe_to: [GenLocation.Producer]}
  end

  def handle_events(events, _from, state) do
    # check for incomplete data and duplicates
    numbers =
      events
      # remove duplicates
      |> Enum.uniq_by(fn row -> row end)
      |> Enum.filter(fn row ->
        # check if a list has empty values
        with false <- any_empty_elements?(row),
             {:ok, longitude_input} <- string_to_float(Enum.at(row, 5)),
             {:ok, latitude_input} <- string_to_float(Enum.at(row, 4)),
             true <- coordinates?(latitude_input, longitude_input) do
          true
        else
          _error -> false
        end
      end)

    {:noreply, numbers, state}
  end

  def coordinates?(latitude_input, longitude_input) do
    latitude?(latitude_input) && longitude?(longitude_input)
  end

  defp any_empty_elements?(row) do
    Enum.member?(row, "")
  end

  defp latitude?(lat) when is_float(lat) do
    -90.0 <= lat and lat <= 90.0
  end

  defp latitude?(:error) do
    false
  end

  defp longitude?(long) when is_float(long) do
    -180.0 <= long and long <= 180.0
  end

  defp longitude?(:error) do
    false
  end

  defp string_to_float(l) do
    case Float.parse(l) do
      {f, _} ->
        f

      _anything_else ->
        :error
    end
  end
end
