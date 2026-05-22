defmodule Reactor do
  def find_paths(devices, from, to) do
    do_find_paths(devices, from, to, MapSet.new([from]))
  end

  defp do_find_paths(devices, from, to, visited) do
    next = Map.get(devices, from)

    if next == [to] do
      [to]
    else
      Enum.flat_map(next, fn device ->
        if MapSet.member?(visited, device) do
          nil
        else
          do_find_paths(devices, device, to, MapSet.put(visited, device))
          |> Enum.map(fn path -> [device] ++ List.wrap(path) end)
        end
      end)
    end
  end
end

devices =
  File.read!("day11.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(fn line ->
    [name | outputs] = String.replace(line, ":", "") |> String.split([":", " "])
    {name, outputs}
  end)
  |> Map.new()

# part one
Reactor.find_paths(devices, "you", "out")
|> Enum.count()
|> IO.puts()

# part two
Reactor.find_paths(devices, "svr", "out")
|> Enum.count(fn path ->
  Enum.member?(path, "dac") and Enum.member?(path, "fft")
end)
|> IO.puts()
