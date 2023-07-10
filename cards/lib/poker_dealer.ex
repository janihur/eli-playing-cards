defmodule PokerDealer do
  def deal(cards, :preflop, number_of_players) do
    Enum.reduce(1..number_of_players, %{:hands => [], :cards => cards}, fn _, acc ->
      {next_hand, rest_cards} = Map.get(acc, :cards) |> Enum.split(2)
      hands = Map.get(acc, :hands)
      hands = Enum.concat(hands, [next_hand])
      acc = Map.put(acc, :hands, hands)
      acc = Map.put(acc, :cards, rest_cards)
      acc
    end)
  end

  def deal(cards, :flop) do
    cards |> Enum.split(3)
  end

  def deal(cards, :turn) do
    cards |> Enum.split(1)
  end

  def deal(cards, :river) do
    cards |> Enum.split(1)
  end
end
