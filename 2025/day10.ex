defmodule Machine do
  def apply_button_to_lights(lights, button) do
    nil
  end
end

machines =
  File.read!("day10.txt")
  |> String.split("\n", trim: true)
  |> Enum.map(fn line ->
    [lights | buttons_and_joltage] = String.split(line)
    {buttons, joltage} = Enum.split(buttons_and_joltage, -1)

    lights =
      lights
      |> String.slice(1..-2//1)
      |> String.to_charlist()
      |> Enum.with_index()
      |> Enum.filter(fn {state, _index} -> state == ?# end)
      |> Enum.map(fn {_state, index} -> index end)

    buttons =
      Enum.map(buttons, fn button ->
        String.slice(button, 1..-2//1) |> String.split(",") |> Enum.map(&String.to_integer/1)
      end)

    joltage =
      Enum.flat_map(joltage, fn j ->
        String.slice(j, 1..-2//1) |> String.split(",") |> Enum.map(&String.to_integer/1)
      end)

    {lights, buttons, joltage}
  end)

machines |> Enum.map(fn {lights, buttons, _} -> nil end)
