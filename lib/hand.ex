defmodule Hand do
  def new (cards) do
    cards
  end

  def random() do
    [Card.random(),Card.random(), Card.random(), Card.random(), Card.random()]
  end

  def sort(cards) do
    Enum.sort(cards, &(Card.face_to_number(&1) <= Card.face_to_number(&2)))
  end

  def asort(cards) do
    Enum.sort(cards, &(Card.face_to_number(&1) >= Card.face_to_number(&2)))
  end

  def straight_flush?(hand) do
    straight?(hand) and flush?(hand)
  end

  def full_house?(hand) do
    hand = sort(hand)
    grouped = Enum.chunk_by(hand, &(Card.face_to_number(&1)))

    (length(List.first(grouped)) === 3 and length(List.last(grouped)) === 2) or
    (length(List.first(grouped)) === 2 and length(List.last(grouped)) === 3)
  end

  def straight?(hand) do
    hand = sort(hand)
    first_card = List.first(hand)
    last_card = List.last(hand)

    # 2345A -> A2345
    last_card.value == A and Enum.at(hand, 3).value == 5 or
    # any other case
    Card.face_to_number(last_card) - Card.face_to_number(first_card) === 4
  end

  def flush?(hand) do
    [h|t] = hand
    Enum.all?(t, fn card -> Card.equals_suit?(h, card) end)
  end

  def four_of_a_kind?(hand) do
    hand = sort(hand)
    not Enum.empty?(Enum.chunk_by(hand, &(Card.face_to_number(&1))) |> Enum.filter(&(length(&1) === 4)))
  end

  def three_of_a_kind?(hand) do
    hand = sort(hand)
    not Enum.empty?(Enum.chunk_by(hand, &(Card.face_to_number(&1))) |> Enum.filter(&(length(&1) === 3)))
  end

  def two_pairs?(hand) do
    hand = sort(hand)
    pairs = Enum.chunk_by(hand, &(Card.face_to_number(&1))) |> Enum.filter(&(length(&1) === 2))
    length(pairs) === 2
  end

  def pair?(hand) do
    hand = sort(hand)
    not Enum.empty?(Enum.chunk_by(hand, &(Card.face_to_number(&1))) |> Enum.filter(&(length(&1) === 2)))
  end

  def score(hand) do
    cond do
      straight_flush?(hand) -> 100
      four_of_a_kind?(hand) -> 40
      full_house?(hand) -> 35
      flush?(hand) -> 33
      straight?(hand) -> 32
      three_of_a_kind?(hand) -> 30
      two_pairs?(hand) -> 35
      pair?(hand) -> 20
      true -> Card.face_to_number(List.first(asort(hand)))
    end
  end

  def compare(hand1, hand2) do
    score1 = score(hand1)
    score2 = score(hand2)

    cond do
      score1 === score2 -> "tie"
      score1 > score2 -> "hand1 won"
      score1 < score2 -> "hand2 won"
    end
  end
end
