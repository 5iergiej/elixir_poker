defmodule Card do
  defstruct [:value, :suit]
  @enforce_keys [:value, :suit]

  @values [2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A]
  @suits [C, D, H, S]

  def new(value, suit) do
    %Card{value: value, suit: suit}
  end

  def random() do
    Card.new(
      Enum.random(@values),
      Enum.random(@suits)
    )
  end

  def face_to_number(card) do
    case card.value do
      A -> 14
      K -> 13
      Q -> 12
      J -> 11
      _ -> card.value
    end
  end

  def equals?(card1, card2) do
    card1.suit === card2.suit and card1.value === card2.value
  end

  def equals_suit?(card1, card2) do
    card1.suit === card2.suit
  end

  def equals_value?(card1, card2) do
    card1.value === card2.value
  end
end
