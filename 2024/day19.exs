Mix.install([{:memoize, "~> 1.4"}])

defmodule Onsen do
  use Memoize

  def possible_patterns("", _) do
    1
  end

  defmemo possible_patterns(pattern, towels) do
    Enum.sum_by(towels, fn towel ->
      (String.starts_with?(pattern, towel) &&
         possible_patterns(String.split_at(pattern, String.length(towel)) |> elem(1), towels)) ||
        0
    end)
  end
end

[towels | patterns] = File.read!("day19.txt") |> String.split("\n", trim: true)
towels = String.split(towels, ", ")

possible_patterns =
  Enum.map(patterns, fn pattern ->
    Onsen.possible_patterns(pattern, towels)
  end)

# part 1
possible_patterns |> Enum.count(&(&1 > 0)) |> IO.puts()

# part 2
possible_patterns |> Enum.sum() |> IO.puts()
