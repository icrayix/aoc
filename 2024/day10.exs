defmodule Trails do
  @directions [{0, -1}, {1, 0}, {0, 1}, {-1, 0}]

  def trailends(map, {x, y}) do
    next_height = Map.get(map, {x, y}) + 1

    Enum.reduce(@directions, [], fn {dx, dy}, ends ->
      case Map.get(map, {x + dx, y + dy}) do
        ^next_height when next_height == 9 -> [{x + dx, y + dy}] ++ ends
        ^next_height -> trailends(map, {x + dx, y + dy}) ++ ends
        _ -> ends
      end
    end)
  end
end

map =
  for {line, y} <- File.read!("day10.txt") |> String.split("\n") |> Enum.with_index(),
      {cell, x} <- line |> String.split("", trim: true) |> Enum.with_index(),
      into: Map.new(),
      do: {{x, y}, String.to_integer(cell)}

trailheads = Enum.filter(map, fn {_, cell} -> cell == 0 end) |> Enum.map(fn {pos, _} -> pos end)

# part 1 & 2
Enum.map(trailheads, fn trailhead ->
  ends = Trails.trailends(map, trailhead)
  {ends |> MapSet.new() |> MapSet.size(), length(ends)}
end)
|> Enum.unzip()
|> Tuple.to_list()
|> Enum.map(&IO.puts(Enum.sum(&1)))
