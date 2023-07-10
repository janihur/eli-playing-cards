defmodule CardsTest do
  use ExUnit.Case
  doctest Cards, except: [shuffled_deck: 0]
end
