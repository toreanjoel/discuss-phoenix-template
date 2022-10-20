defmodule Helpers.Logger do
  def log(data) do
    IO.puts "<-------- START -------->"
    IO.inspect data
    IO.puts "<-------- END -------->"
  end
end
