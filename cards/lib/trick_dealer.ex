defmodule TrickDealer do
  def deal(cards, number_of_players) do
    cards |> Enum.chunk_every(5) |> Enum.take(number_of_players)
  end
end
