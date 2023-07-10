defmodule TrickGameTest do
  use ExUnit.Case

  test "resolve_trick" do
    # initial state -----------------------------------------------------------

    game_state =
      %{
        played_tricks: [],
        players: [
          %{
            hand: [hearts: 4, diamonds: 4, clubs: 2, hearts: 7, hearts: 9],
            name: "arthur",
            starts: true
          },
          %{
            hand: [diamonds: 3, hearts: 14, spades: 5, diamonds: 7, hearts: 6],
            name: "bobby",
            starts: false
          },
          %{
            hand: [spades: 7, clubs: 6, clubs: 3, clubs: 11, diamonds: 12],
            name: "cecil",
            starts: false
          },
          %{
            hand: [spades: 14, hearts: 13, spades: 6, clubs: 5, hearts: 3],
            name: "donna",
            starts: false
          }
        ]
      }

    # 1st trick ---------------------------------------------------------------

    played_cards = [
      {"arthur", {:clubs, 2}},
      {"bobby",  {:diamonds, 3}},
      {"cecil",  {:clubs, 11}},
      {"donna",  {:clubs, 5}}
    ]

    game_state = TrickGame.resolve_trick(game_state, played_cards)
      |> IO.inspect(label: "1st trick")

    players = Map.get(game_state, :players)
    winner = Enum.find(players, fn player -> Map.get(player, :starts) == true end)
    assert "cecil" == Map.get(winner, :name)

    # 2nd trick ---------------------------------------------------------------

    played_cards = [
      {"cecil",  {:diamonds, 12}},
      {"donna",  {:hearts, 3}},
      {"arthur", {:diamonds, 4}},
      {"bobby",  {:diamonds, 7}}
    ]

    game_state = TrickGame.resolve_trick(game_state, played_cards)
      |> IO.inspect(label: "2nd trick")

    players = Map.get(game_state, :players)
    winner = Enum.find(players, fn player -> Map.get(player, :starts) == true end)
    assert "cecil" == Map.get(winner, :name)

    # 3rd trick ---------------------------------------------------------------

    played_cards = [
      {"cecil",  {:clubs, 6}},
      {"donna",  {:spades, 6}},
      {"arthur", {:hearts, 4}},
      {"bobby",  {:hearts, 6}}
    ]

    game_state = TrickGame.resolve_trick(game_state, played_cards)
      |> IO.inspect(label: "3rd trick")

    players = Map.get(game_state, :players)
    winner = Enum.find(players, fn player -> Map.get(player, :starts) == true end)
    assert "cecil" == Map.get(winner, :name)

    # 4th trick ---------------------------------------------------------------

    played_cards = [
      {"cecil",  {:clubs, 3}},
      {"donna",  {:hearts, 13}},
      {"arthur", {:hearts, 7}},
      {"bobby",  {:spades, 5}}
    ]

    game_state = TrickGame.resolve_trick(game_state, played_cards)
      |> IO.inspect(label: "4th trick")

    players = Map.get(game_state, :players)
    winner = Enum.find(players, fn player -> Map.get(player, :starts) == true end)
    assert "cecil" == Map.get(winner, :name)

    # 5th trick ---------------------------------------------------------------

    played_cards = [
      {"cecil",  {:spades, 7}},
      {"donna",  {:spades, 14}},
      {"arthur", {:hearts, 9}},
      {"bobby",  {:hearts, 14}}
    ]

    game_state = TrickGame.resolve_trick(game_state, played_cards)
      |> IO.inspect(label: "5th trick")

    players = Map.get(game_state, :players)
    winner = Enum.find(players, fn player -> Map.get(player, :starts) == true end)
    assert "donna" == Map.get(winner, :name)

  end
end
