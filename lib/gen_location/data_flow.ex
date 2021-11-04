defmodule GenLocation.DataFlow do
  use Flow
  import GenLocation.Utils
  NimbleCSV.define(MyParser, separator: ",", escape: "\"")

  def csv_data(path) do
    File.stream!(path, read_ahead: 100_000)
    |> MyParser.parse_stream()
    |> Flow.from_enumerable()
    |> Flow.uniq_by(fn a -> a end)
    |> Flow.filter(fn row ->
      # check if a list has empty values
      with false <- any_empty_elements?(row),
           {:ok, longitude_input} <- string_to_float(Enum.at(row, 5)),
           {:ok, latitude_input} <- string_to_float(Enum.at(row, 4)),
           true <- coordinates?(latitude_input, longitude_input) do
        row
      end
    end)
    |> Flow.flat_map(fn x -> IO.inspect(x, label: "____________data_______________") end)
    |> Flow.run()
  end
end
