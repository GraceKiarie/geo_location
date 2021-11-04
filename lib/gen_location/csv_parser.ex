defmodule GenLocation.CsvParser do
  # NimbleCSV.define(MyParser, separator: ",", escape: "\"")

  def parse_data(path \\ "/home/kiarie/Documents/data_dump.csv") do
    path
    |> File.stream!([:trim_bom])
    |> MyParser.parse_stream()
    |> Enum.map(& &1)
  end
end
