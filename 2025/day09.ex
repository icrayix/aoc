defmodule Day09 do
  def combinations(list, acc \\ [])

  def combinations([], acc),
    do: acc

  def combinations([head | rest], acc),
    do: combinations(rest, for(el <- rest, do: {head, el}) ++ acc)
end

corners =
  File.read!("day09.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(fn line ->
    String.split(line, ",") |> Enum.map(&String.to_integer/1) |> List.to_tuple()
  end)

# part one
corners
|> Day09.combinations()
|> Enum.map(fn {{x1, y1}, {x2, y2}} ->
  (abs(x2 - x1) + 1) * (abs(y2 - y1) + 1)
end)
|> Enum.sort(:desc)
|> Enum.take(1)
|> IO.inspect()
