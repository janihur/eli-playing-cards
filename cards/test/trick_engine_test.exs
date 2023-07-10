defmodule TrickEngineTest do
  use ExUnit.Case

  test "resolve" do
    assert {:clubs, 5}   == TrickEngine.resolve([{:clubs, 5}, {:hearts, 5}, {:clubs, 4}, {:hearts, 4}])
    assert {:hearts, 13} == TrickEngine.resolve([{:hearts, 11}, {:hearts, 13}, {:hearts, 10}, {:clubs, 12}])
    assert {:hearts, 9}  == TrickEngine.resolve([{:hearts, 8}, {:spades, 11}, {:hearts, 9}, {:clubs, 5}])
    assert {:clubs, 13}  == TrickEngine.resolve([{:clubs, 3}, {:hearts, 3}, {:spades, 13}, {:clubs, 13}])
    assert {:diamonds, 10} == TrickEngine.resolve([{:diamonds, 4}, {:diamonds, 6}, {:diamonds, 8}, {:diamonds, 10}])



    # {:clubs, 8},
    # {:hearts, 5},
    # {:spades, 10},
    # {:spades, 2},
    # {:clubs, 14},
    # {:spades, 4},
    # {:hearts, 14},
    # {:hearts, 2},
    # {:clubs, 9},
    # {:diamonds, 7},
    # {:spades, 6},
    # {:hearts, 4},
    # {:hearts, 7},
    # {:diamonds, 3},
    # {:spades, 8},
    # {:spades, 5},
    # {:spades, 12},
    # {:clubs, 4},
    # {:diamonds, 5},
    # {:clubs, 6},
    # {:hearts, 12},
    # {:clubs, 2},
    # {:diamonds, 12},
    # {:spades, 7},
    # {:clubs, 11},
    # {:spades, 14},
    # {:spades, 9},
    # {:clubs, 10},
    # {:spades, 3},
    # {:diamonds, 2},
    # {:diamonds, 14},
    # {:clubs, 7},
    # {:diamonds, 11},
    # {:diamonds, 13},
  end
end
