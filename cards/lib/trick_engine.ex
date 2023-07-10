defmodule TrickEngine do
  # https://en.wikipedia.org/wiki/Trick-taking_game
  def resolve(trick) do
    # return the winning card
    trick
    |> Enum.reduce(fn next_card, winning_card ->
      Cards.compare(winning_card, next_card)
    end)
  end
end
