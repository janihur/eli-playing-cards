defmodule Player do
  def new(player_names) do
    number_of_players = length(player_names)
    _cards = TrickGame.start(number_of_players)
  end
end
