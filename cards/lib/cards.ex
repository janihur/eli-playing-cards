defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """
  Returns a standard unshuffled 52-card French suited deck:
  https://en.wikipedia.org/wiki/Standard_52-card_deck

  ## Examples

      iex> Cards.deck()
      [
        clubs: 2, clubs: 3, clubs: 4, clubs: 5, clubs: 6, clubs: 7, clubs: 8, clubs: 9, clubs: 10, clubs: 11, clubs: 12, clubs: 13, clubs: 14,
        diamonds: 2, diamonds: 3, diamonds: 4, diamonds: 5, diamonds: 6, diamonds: 7, diamonds: 8, diamonds: 9, diamonds: 10, diamonds: 11, diamonds: 12, diamonds: 13, diamonds: 14,
        hearts: 2, hearts: 3, hearts: 4, hearts: 5, hearts: 6, hearts: 7, hearts: 8, hearts: 9, hearts: 10, hearts: 11, hearts: 12, hearts: 13, hearts: 14,
        spades: 2, spades: 3, spades: 4, spades: 5, spades: 6, spades: 7, spades: 8, spades: 9, spades: 10, spades: 11, spades: 12, spades: 13, spades: 14
      ]
  """
  @spec deck :: list
  def deck do
    for suit <- [:clubs, :diamonds, :hearts, :spades],
        rank <- 2..14
    do
      {suit, rank}
    end
  end

  @doc """
  Returns a standard shuffled 52-card French suited deck:
  https://en.wikipedia.org/wiki/Standard_52-card_deck

  ## Examples

      iex> Cards.shuffled_deck()
      [
        diamonds: 12, spades: 7, clubs: 3, spades: 10, clubs: 10, spades: 5,
        hearts: 8, diamonds: 14, diamonds: 3, clubs: 5, hearts: 7,
        hearts: 5, diamonds: 5, clubs: 2, clubs: 4, hearts: 3,
        hearts: 4, diamonds: 2, diamonds: 7, hearts: 6, hearts: 12,
        spades: 14, diamonds: 11, clubs: 14, diamonds: 8, hearts: 10,
        diamonds: 9, hearts: 11, spades: 12, clubs: 7, spades: 13,
        diamonds: 13, hearts: 14, diamonds: 6, hearts: 2, clubs: 9,
        spades: 9, clubs: 11, spades: 8, spades: 6, clubs: 13,
        spades: 4, spades: 2, diamonds: 10, diamonds: 4, spades: 3,
        hearts: 13, clubs: 6, spades: 11, clubs: 8,
        clubs: 12, hearts: 9
      ]
  """
  @spec shuffled_deck :: list
  def shuffled_deck do
    deck() |> Enum.shuffle()
  end

  @doc """
  Returns dealt cards and the rest of the deck.

  ## Examples

    iex> [diamonds: 12, spades: 7, clubs: 3, spades: 10, clubs: 10, spades: 5] |> Cards.deal(2)
    {
      [diamonds: 12, spades: 7],
      [clubs: 3, spades: 10, clubs: 10, spades: 5]
    }
  """
  @spec deal(deck :: list, number_of_cards :: integer) :: {list, list}
  def deal(deck, number_of_cards) do
    deck |> Enum.split(number_of_cards)
  end

  @doc """
  Returns stronger (winning) card. `card1` defines the suit `card2`has to follow.

  ## Examples

    iex> Cards.compare({:spades, 12}, {:clubs, 10})
    {:spades, 12}

    iex> Cards.compare({:clubs, 12}, {:clubs, 10})
    {:clubs, 12}

    iex> Cards.compare({:clubs, 12}, {:clubs, 13})
    {:clubs, 13}
  """
  def compare(card1, card2) do
    {suit1, rank1} = card1
    {suit2, rank2} = card2
    cond do
      suit1 != suit2 -> card1 # wins because suit is not followed
      rank1 > rank2  -> card1 # wins by rank
      true           -> card2 # wins otherwise
    end
  end

  @doc """
  Returns a stringified representation of a `card`.

  ## Examples

    iex> Cards.print({:spades, 12})
    "QS"
    iex> Cards.print({:hearts, 10})
    "TH"
  """
  def print(card) do
    {suit, rank} = card
    case rank do
      10 -> "T"
      11 -> "J"
      12 -> "Q"
      13 -> "K"
      14 -> "A"
      _  -> Integer.to_string(rank)
    end
    <>
    case suit do
      :clubs    -> "C"
      :diamonds -> "D"
      :hearts   -> "H"
      :spades   -> "S"
    end
  end
end
