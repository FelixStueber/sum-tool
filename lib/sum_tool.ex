defmodule SumTool do
  @moduledoc """
  Extracts two numbers from an array that add to the desired input.
  """

  @doc """
  Greedily extract the first two numbers that add to the given sum.
  Note: A number can get combined with itself.
  ## Examples

      iex> SumTool.run([1, 3, 7, 9], 12)
      {3, 9}

  """
  def run(array, input) when array |> is_list and input |> is_integer do
    find_summands(array, array, input)
  end

  def run(_input1, _input2), do: raise(ArgumentError, "Wrong input format.")

  # raise Error if no more combinations possible
  defp find_summands([], _rest, _int), do: raise("No matching sum found.")

  # try out next number when first did not produce a match
  defp find_summands([_candidate | rest], [], input), do: find_summands(rest, rest, input)

  # keep on searching, if summands do not add to input number
  defp find_summands([candidate1 | _rest1] = rest, [candidate2 | rest2], input)
       when candidate1 + candidate2 != input do
    find_summands(rest, rest2, input)
  end

  # else return tuple
  defp find_summands([candidate1 | _rest1], [candidate2 | _rest2], _input) do
    {candidate1, candidate2}
  end
end
