ExUnit.start()

defmodule TestHand do
  use ExUnit.Case

  test "pair" do
    hand = Hand.new([
      Card.new(A,D),
      Card.new(K,D),
      Card.new(K,S),
      Card.new(J,D),
      Card.new(10,D)
    ])

    assert Hand.pair?(hand) === true
  end

  test "two pairs" do
    hand = Hand.new([
      Card.new(10,S),
      Card.new(K,D),
      Card.new(K,S),
      Card.new(J,D),
      Card.new(10,D)
    ])

    assert Hand.two_pairs?(hand) === true
  end

  test "three of a kind" do
    hand = Hand.new([
      Card.new(10,S),
      Card.new(K,D),
      Card.new(K,S),
      Card.new(K,H),
      Card.new(10,D)
    ])

    assert Hand.three_of_a_kind?(hand) === true
  end

  test "four of a kind" do
    hand = Hand.new([
      Card.new(10,S),
      Card.new(K,D),
      Card.new(K,S),
      Card.new(K,H),
      Card.new(K,C)
    ])

    assert Hand.four_of_a_kind?(hand) === true
  end

  test "full house" do
    hand = Hand.new([
      Card.new(10,S),
      Card.new(10,D),
      Card.new(K,S),
      Card.new(K,H),
      Card.new(K,C)
    ])

    assert Hand.full_house?(hand) === true
  end

  test "straight" do
    hand = Hand.new([
      Card.new(10,S),
      Card.new(K,D),
      Card.new(Q,S),
      Card.new(A,H),
      Card.new(J,C)
    ])

    assert Hand.straight?(hand) === true
  end

  test "flush" do
    hand = Hand.new([
      Card.new(10,S),
      Card.new(K,S),
      Card.new(2,S),
      Card.new(A,S),
      Card.new(J,S)
    ])

    assert Hand.flush?(hand) === true
  end

  test "straight flush" do
    hand = Hand.new([
      Card.new(10,S),
      Card.new(K,S),
      Card.new(Q,S),
      Card.new(A,S),
      Card.new(J,S)
    ])

    assert Hand.straight_flush?(hand) === true
  end
end
