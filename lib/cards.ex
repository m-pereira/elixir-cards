defmodule Cards do
  @moduledoc """
  Provides a simple interface to the cards in the game.
  """

  alias Cards.Card

  @spec hand_of(integer) :: list(Card)
  def hand_of(size) when is_integer(size) do
    create_deck()
    |> deal(size)
    |> parse()
  end

  @spec create_deck :: list(Card)
  def create_deck, do: build_deck(default_values(), default_suits())

  @doc """
  Creates a deck of cards with given values and for default suits.

  ## Example
  ```
  iex(2)> Cards.create_deck(["Queen"])
  [
    %Cards.Card{suit: "Hearts", value: "Queen"},
    %Cards.Card{suit: "Spades", value: "Queen"},
    %Cards.Card{suit: "Clubs", value: "Queen"},
    %Cards.Card{suit: "Diamonds", value: "Queen"}
  ]
  ```
  """
  @spec create_deck(list(Card)) :: list(Card)
  def create_deck(values) when is_list(values), do: build_deck(values, default_suits())

  @doc """
  Creates a deck of cards with the given values and suits.

  ## Example
  ```
  iex(1)> Cards.create_deck(["Ace", "Two"], ["Diamonds", "Clubs"])
  [
    %Cards.Card{suit: "Diamonds", value: "Ace"},
    %Cards.Card{suit: "Diamonds", value: "Two"},
    %Cards.Card{suit: "Clubs", value: "Ace"},
    %Cards.Card{suit: "Clubs", value: "Two"}
  ]
  ```
  """
  @spec create_deck(list(Card), list(Card)) :: list(Card)
  def create_deck(values, suits) when is_list(values) and is_list(suits) do
    build_deck(values, suits)
  end

  @spec deal(list(Card), integer) :: {list(Card), list(Card)}
  def deal(deck, hand_number) do
    deck
    |> shuffle
    |> Enum.split(hand_number)
  end

  @spec shuffle(list(Card)) :: list(Card)
  def shuffle(deck), do: Enum.shuffle(deck)

  @doc """
  Checks if the given card is in the given deck.

  ## Example
  ```
  iex(1)> deck = Cards.create_deck(["Ace"], ["Clubs"])
  iex(2)> Cards.contains?(deck, %Cards.Card{suit: "Clubs", value: "Ace"})
  true
  ```
  """
  @spec contains?(list(Card), String.t()) :: boolean
  def contains?(deck, card), do: Enum.member?(deck, card)

  @spec save(list(Card), String.t()) :: :ok
  def save(deck, filename) when is_list(deck) and is_binary(filename) do
    File.write!(filename, :erlang.term_to_binary(deck))
  end

  @spec load(String.t()) :: {:ok, list(Card)} | {:error, String.t()}
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> {:ok, :erlang.binary_to_term(binary)}
      {:error, _} -> {:error, "Could not load deck from file"}
    end
  end

  defp build_deck(values, suits) do
    for suit <- suits, value <- values do
      %Card{value: value, suit: suit}
    end
  end

  defp parse({hand, _}) when is_list(hand), do: hand

  defp default_values do
    [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]
  end

  defp default_suits do
    [
      "Hearts",
      "Spades",
      "Clubs",
      "Diamonds"
    ]
  end
end
