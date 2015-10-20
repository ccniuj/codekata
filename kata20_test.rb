#kata20 test
require 'minitest/autorun'
require_relative 'kata20'

describe 'Klondike' do
  k = Klondike.new 
  k.send_number = 3

  # it 'shows the cards in the discard correctly' do
  #   k.show.must_equal [['spake', 'jack', true], ['diamond', 'queen', true]]
  # end
  # it 'checks if the card can move to other tableau' do
  #   k.check_tableau(from1, to1).must_equal true
  #   k.check_tableau(from8, to8).must_equal false
  # end
  k.discard << ['s', '2']
  tableau_1 = [['h', '4', true]]
  it 'moves card from discard to tableau' do
    k.move_to_tableau(k.discard, tableau_1).must_equal nil
  end

  # it 'flips over the top card' do
  #   k.flip(top1).must_equal true
  #   k.flip(top2).must_equal nil
  # end

  # it 'checks if the card can move to the foundation' do
  #   k.check_foundation(top1).must_equal false
  #   k.check_foundation(top2).must_equal false
  #   k.check_foundation(top3).must_equal true
  #   k.move_to_foundation(tableau_3).must_equal [top3[0, 2]]
  # end

  # it 'moves card from stock to tableau' do
  #   k.discard << ['heart', '2', true]
  #   k.move('from_discard_to_tableau', tableau_1).must_equal tableau_1
  # end
end