defmodule TrickGame do
  def start(player_names) do
    number_of_players = length(player_names)

    # get hands
    hands = Cards.shuffled_deck() |> TrickDealer.deal(number_of_players)

    # combine players and hands
    players = 
      List.zip([player_names, hands])
      |> Enum.map(fn {name, hand} ->
        %{:name => name, :starts => false, :hand => hand}
      end)
      # first player starts the first trick
      |> List.update_at(0, fn player ->
        player |> Map.put(:starts, true)
      end)

    # construct game state
    %{:players => players, :played_tricks => []}
  end

  def resolve_trick(game_state, played_cards) do
    # TODO: check the play is valid according to the rules (follow suit)

    # helper - cards played
    played_cards_plain = played_cards |> Enum.map(fn {_, card} -> card end)

    # find winning card
    winning_card = played_cards_plain |> TrickEngine.resolve()

    # find winner and winner name
    winner =
      played_cards
      |> Enum.find(fn {_, card} ->
        card == winning_card
      end)
    {winner_name, _} = winner

    # reset starting position
    players1 = Map.get(game_state, :players) #|> IO.inspect(label: "players1")
    players2 =
      players1
      |> Enum.map(fn player ->
        name = Map.get(player, :name)
        cond do
          name == winner_name -> player |> Map.put(:starts, true)
          true                -> player |> Map.put(:starts, false)
        end
      end)
      # |> IO.inspect(label: "players2")

    # remove played cards
    players3 =
      players2
      |> Enum.map(fn player ->
        old_hand = Map.get(player, :hand)
        new_hand = old_hand |> Enum.reject(fn card -> Enum.member?(played_cards_plain, card) end)
        player |> Map.put(:hand, new_hand)
      end)
      # |> IO.inspect(label: "players3")

    # adjust played tricks
    game_state = Map.put(game_state, :played_tricks, Map.get(game_state, :played_tricks) ++ [played_cards])

    # update game state
    Map.put(game_state, :players, players3)
  end
end
