defmodule Cards do
  alias Cards.Card

  @spec create_deck :: list(Card)
  def create_deck, do: build_deck(default_values(), default_suits())

  @spec create_deck(list(Card)) :: list(Card)
  def create_deck(values) when is_list(values), do: build_deck(values, default_suits())

  @spec create_deck(list(Card), list(Card)) :: list(Card)
  def create_deck(values, suits) when is_list(values) and is_list(suits) do
    build_deck(values, suits)
  end

  @spec shuffle(list(Card)) :: list(Card)
  def shuffle(deck), do: Enum.shuffle(deck)

  @spec contains?(list(Card), String.t()) :: boolean
  def contains?(deck, card), do: Enum.member?(deck, card)

  @spec deal(list(Card), integer) :: {list(Card), list(Card)}
  def deal(deck, hand_number) do
    deck
    |> shuffle
    |> Enum.split(hand_number)
  end

  @spec save(list(Card), String.t) :: :ok
  def save(deck, filename) do
    File.write!(filename, :erlang.term_to_binary(deck))
  end

  @spec load(String.t) :: list(Card)
  def load(filename) do
    {:ok, binary} = File.read(filename)

    :erlang.binary_to_term(binary)
  end

  defp build_deck(values, suits) do
    for suit <- suits, value <- values do
      %Card{value: value, suit: suit}
    end
  end

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
