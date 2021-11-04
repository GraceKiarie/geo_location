defmodule GenLocation.Utils do
  @moduledoc """
   holds all utility functions
  """

  @spec coordinates?(:error | float, any) :: boolean
  def coordinates?(latitude_input, longitude_input) do
    latitude?(latitude_input) && longitude?(longitude_input)
  end

  def any_empty_elements?(row) do
    Enum.member?(row, "")
  end

  defp latitude?(lat) when is_float(lat) do
    -90.0 <= lat and lat <= 90.0
  end

  defp latitude?(:error) do
    false
  end

  def longitude?(long) when is_float(long) do
    -180.0 <= long and long <= 180.0
  end

  def longitude?(:error) do
    false
  end

  def string_to_float(l) do
    case Float.parse(l) do
      {f, _} ->
        {:ok, f}

      _anything_else ->
        :error
    end
  end
end
