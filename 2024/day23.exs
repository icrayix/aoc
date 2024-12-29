computers =
  File.read!("day23.txt") |> String.split(["\n", "-"], trim: true)

connections = computers |> Enum.chunk_every(2)

connected =
  Map.new(computers, fn computer ->
    connected =
      Enum.filter(connections, &Enum.member?(&1, computer))
      |> Enum.concat()
      |> Enum.reject(&(&1 == computer))
      |> MapSet.new()

    {computer, connected}
  end)

connected
|> Enum.filter(fn {c, _} -> String.starts_with?(c, "t") end)
|> Enum.map(fn {from, to} ->
  for(x <- to, y <- to, x != y, x < y, do: {x, y})
  |> Enum.filter(fn {x, y} ->
    Map.get(connected, x) |> MapSet.member?(y)
  end)
  |> Enum.map(fn {x, y} -> MapSet.new([from, x, y]) end)
end)
|> Enum.concat()
|> MapSet.new()
|> MapSet.size()
|> IO.puts()
