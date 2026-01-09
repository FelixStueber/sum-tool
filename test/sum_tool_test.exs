defmodule SumToolTest do
  use ExUnit.Case
  doctest SumTool

  test "fail on empty list" do
    assert_raise(RuntimeError, "No matching sum found.", fn ->
      SumTool.run([], 10)
    end)
  end

  test "fail on wrong format" do
    assert_raise(ArgumentError, "Wrong input format.", fn ->
      SumTool.run(1, 1)
    end)

    assert_raise(ArgumentError, "Wrong input format.", fn ->
      SumTool.run([1], {1})
    end)
  end

  test "find basic tuple" do
    assert SumTool.run([1, 2, 3], 5) == {2, 3}
  end

  test "allow multiple usage of number" do
    assert_raise(RuntimeError, "No matching sum found.", fn -> SumTool.run([1], 2) end)
  end

  test "raise exeption when no match" do
    assert_raise(RuntimeError, "No matching sum found.", fn -> SumTool.run([1, 2, 3], 7) end)
  end

  test "greedy choice with multiple possibilities" do
    assert SumTool.run([1, 2, 3], 4) == {1, 3}
  end

  test "unordered list" do
    assert SumTool.run([1, 4, 3, 2, 5], 7) == {4, 3}
  end

  test "only one value" do
    assert_raise(RuntimeError, "No matching sum found.", fn ->
      SumTool.run([5, 5, 5, 5, 5, 5], 7)
    end)

    assert SumTool.run([5, 5, 5, 5, 5, 5], 10) == {5, 5}
  end

  test "large input" do
    assert 1..100_000 |> Enum.map(& &1) |> SumTool.run(199_000) == {99_000, 100_000}
  end
end
