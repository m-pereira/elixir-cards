defmodule CardsTest do
  use ExUnit.Case, async: true

  alias Cards.Card

  doctest Cards

  describe "hand_of/1" do
    test "returns the hand of cards of given size" do
      size = 3

      assert [%Card{value: _, suit: _}, %Card{value: _, suit: _}, %Card{value: _, suit: _}] =
               Cards.hand_of(size)
    end
  end

  describe "create_deck/0" do
    test "returns the default deck when no args given" do
      deck = Cards.create_deck()

      result = [
        %Card{suit: "Hearts", value: "Ace"},
        %Card{suit: "Hearts", value: "Two"},
        %Card{suit: "Hearts", value: "Three"},
        %Card{suit: "Hearts", value: "Four"},
        %Card{suit: "Hearts", value: "Five"},
        %Card{suit: "Hearts", value: "Six"},
        %Card{suit: "Hearts", value: "Seven"},
        %Card{suit: "Hearts", value: "Eight"},
        %Card{suit: "Hearts", value: "Nine"},
        %Card{suit: "Hearts", value: "Ten"},
        %Card{suit: "Hearts", value: "Jack"},
        %Card{suit: "Hearts", value: "Queen"},
        %Card{suit: "Hearts", value: "King"},
        %Card{suit: "Spades", value: "Ace"},
        %Card{suit: "Spades", value: "Two"},
        %Card{suit: "Spades", value: "Three"},
        %Card{suit: "Spades", value: "Four"},
        %Card{suit: "Spades", value: "Five"},
        %Card{suit: "Spades", value: "Six"},
        %Card{suit: "Spades", value: "Seven"},
        %Card{suit: "Spades", value: "Eight"},
        %Card{suit: "Spades", value: "Nine"},
        %Card{suit: "Spades", value: "Ten"},
        %Card{suit: "Spades", value: "Jack"},
        %Card{suit: "Spades", value: "Queen"},
        %Card{suit: "Spades", value: "King"},
        %Card{suit: "Clubs", value: "Ace"},
        %Card{suit: "Clubs", value: "Two"},
        %Card{suit: "Clubs", value: "Three"},
        %Card{suit: "Clubs", value: "Four"},
        %Card{suit: "Clubs", value: "Five"},
        %Card{suit: "Clubs", value: "Six"},
        %Card{suit: "Clubs", value: "Seven"},
        %Card{suit: "Clubs", value: "Eight"},
        %Card{suit: "Clubs", value: "Nine"},
        %Card{suit: "Clubs", value: "Ten"},
        %Card{suit: "Clubs", value: "Jack"},
        %Card{suit: "Clubs", value: "Queen"},
        %Card{suit: "Clubs", value: "King"},
        %Card{suit: "Diamonds", value: "Ace"},
        %Card{suit: "Diamonds", value: "Two"},
        %Card{suit: "Diamonds", value: "Three"},
        %Card{suit: "Diamonds", value: "Four"},
        %Card{suit: "Diamonds", value: "Five"},
        %Card{suit: "Diamonds", value: "Six"},
        %Card{suit: "Diamonds", value: "Seven"},
        %Card{suit: "Diamonds", value: "Eight"},
        %Card{suit: "Diamonds", value: "Nine"},
        %Card{suit: "Diamonds", value: "Ten"},
        %Card{suit: "Diamonds", value: "Jack"},
        %Card{suit: "Diamonds", value: "Queen"},
        %Card{suit: "Diamonds", value: "King"}
      ]

      assert deck == result
    end
  end

  describe "create_deck/1" do
    test "returns a deck with the given possible values" do
      deck = Cards.create_deck(["Ace", "King"])

      result = [
        %Card{suit: "Hearts", value: "Ace"},
        %Card{suit: "Hearts", value: "King"},
        %Card{suit: "Spades", value: "Ace"},
        %Card{suit: "Spades", value: "King"},
        %Card{suit: "Clubs", value: "Ace"},
        %Card{suit: "Clubs", value: "King"},
        %Card{suit: "Diamonds", value: "Ace"},
        %Card{suit: "Diamonds", value: "King"}
      ]

      assert deck == result
    end
  end

  describe "create_deck/2" do
    test "returns a deck with the given values of cards and suits" do
      deck = Cards.create_deck(["Ace", "Jack"], ["Hearts", "Diamonds"])

      assert deck == [
               %Card{suit: "Hearts", value: "Ace"},
               %Card{suit: "Hearts", value: "Jack"},
               %Card{suit: "Diamonds", value: "Ace"},
               %Card{suit: "Diamonds", value: "Jack"}
             ]
    end
  end

  describe "shuffle/1" do
    test "returns a shuffled deck" do
      deck = Cards.create_deck()

      refute Cards.shuffle(deck) == deck
    end
  end

  describe "contains?/2" do
    setup do
      deck = Cards.create_deck(["Ace"], ["Hearts"])

      {:ok, deck: deck}
    end

    test "returns true if the deck contains the given card", %{deck: deck} do
      assert Cards.contains?(deck, %Card{suit: "Hearts", value: "Ace"})
    end

    test "returns false if the deck does not contain the given card", %{deck: deck} do
      refute Cards.contains?(deck, %Card{suit: "Diamonds", value: "Ace"})
    end
  end

  describe "deal/2" do
    test "returns the hand on the first element, and the rest of the deck on the second" do
      hand_size = 3

      {hand, rest} = Cards.create_deck() |> Cards.deal(hand_size)

      assert Enum.count(hand) == hand_size
      assert Enum.count(rest) == 49

      assert [
               %Card{suit: _, value: _},
               %Card{suit: _, value: _},
               %Card{suit: _, value: _}
             ] = hand
    end
  end

  describe "save/2" do
    test "creates a file with the given deck" do
      deck = Cards.create_deck()
      Cards.save(deck, "test/tmp/save_2.txt")

      assert File.exists?("test/tmp/save_2.txt")

      File.rm("test/tmp/save_2.txt")
    end
  end

  describe "load/1" do
    test "when success, returns the deck from the given file" do
      deck = Cards.create_deck()
      Cards.save(deck, "test/tmp/load_1.txt")

      assert Cards.load("test/tmp/load_1.txt") == {:ok, deck}

      File.rm("test/tmp/load_1.txt")
    end

    test "when failure, raises ArgumentError" do
      assert Cards.load("test/tmp/wrong_file.txt") == {:error, "Could not load deck from file"}
    end
  end
end
