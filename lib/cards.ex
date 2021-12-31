defmodule Cards do
  alias Cards.Card

  @spec hand_of(integer) :: list(Card)
  def hand_of(size) do
    create_deck()
    |> deal(size)
    |> parse()
  end

  @spec create_deck :: list(Card)
  def create_deck, do: build_deck(default_values(), default_suits())

  @spec create_deck(list(Card)) :: list(Card)
  def create_deck(values) when is_list(values), do: build_deck(values, default_suits())

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
