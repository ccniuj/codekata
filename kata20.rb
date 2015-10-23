#kata20
require 'pry'
require 'colorize'

class Klondike
  attr_accessor :stock, :discard, :tableau, :foundation, :send_number, :card_number

  def initialize
    @suits = %w{s h d c}
    @ranks = %w{a 2 3 4 5 6 7 8 9 10 j q k}
    
    @stock, @discard, @tableau, @foundation, @send_number = 
    @suits.map { |s| @ranks.map { |r| [s, r, false] } }.flatten(1).shuffle, [], {}, {}, 1
    
    # sending cards to tableau
    (1..7).each { |i|
      @tableau[i] = @stock.pop(i).map { |t| t.flatten(1) }
      @tableau[i].last[2] = true
    }

    @suits.each { |s| @foundation[s] = [] }
  end
  
  def send
    @send_number.times { @discard.push(@stock.pop).map {|d| d[2] = true } unless @stock.empty? }
    @card_number = @send_number
  end

  def restart
    @stock = @discard.pop(@discard.length).map {|d| d[0, 2].push(false) }.reverse if @stock.empty?
  end

  def move_to_tableau(from_collection, to_collection, n)
    if from_collection.any? then
      if check_tableau(from_collection[-n], to_collection.last) then
        from_collection.pop(n).each {|f| to_collection.push(f) }
      end
    end
  end

  def move_to_foundation(collection)
    collection.any? ? (@foundation[collection.last[0]].push(collection.pop) if check_foundation(collection.last)) : nil
  end

  def flip(top)
    top[2] = true if top[2] == false
  end

  def check_tableau(from, to)
    suit_from = from[0]
    rank_from = rank(from[1], @ranks)
    if to then
      suit_to = to[0] 
      rank_to = rank(to[1], @ranks)
    end
    red = %w[h d]
    black = %w[s c]

    (red.include?(suit_from) && black.include?(suit_to)) || (black.include?(suit_from) && red.include?(suit_to)) ? 
    ((rank_to - rank_from == 1) ? true : false) : (rank_from == 13 && to == nil ? true : false)
  end

  def check_foundation(from)
    suit, r = from[0], rank(from[1], @ranks)

    (@foundation[suit].empty? && r == 1) ? true : 
    (@foundation[suit].any? { |f| r - rank(f[1], @ranks) == 1 } ? true : false)
  end

  def start_new_game
    puts "="*50
    puts 'Starting a new klondike game!'
    puts 'Sending cards to tableau...'
    puts 'How many cards do you want to send at one time? 1~3'
    puts "="*50

    @send_number = gets.chomp.to_i
    @card_number = @send_number
  end

  def show
    puts "="*50
    puts "STOCK: #{@stock.any? ? @stock.length : 0} card(s) left"
    puts "DISCARD: "
    @card_number = @stock.length if @send_number > @stock.length
    @discard.last(@card_number).each {|d| print format(d) }
    puts
    puts "You need to restart the stock!" if @stock.empty?
    puts "FOUNDATION:"
    @foundation.each { |k, v|
      print "#{k}:"
      v.each { |f|
        print format(f)
      }
      puts
    }
    puts "TABLEAU:"
    @tableau.each { |k, v|
      print "#{k}:"
      v.each {|t|
        up = format(t)
        down = '***'.center(5)
        t[2] ? (print up) : (print down)
      }
      puts
    }
    puts "="*50
  end

  def operation_prompt(str)
    puts "*"*50
    puts "Select an operation:\n#{title(str)}"
    puts "*"*50
    gets.chomp.to_i
  end

  def type_prompt(str)
    s = title(str)
    puts "*"*50
    puts "FROM:\n#{s}"
    puts "*"*50
    opt_from = gets.chomp.to_i

    if opt_from == 9 then
      puts "*"*50
      puts "FROM WHICH SUIT(s/h/d/c):\n"
      puts "*"*50
      fs = gets.chomp
    end
    puts "*"*50
    puts "TO:\n#{s}"
    puts "*"*50
    opt_to = gets.chomp.to_i

    if (1..7).include?(opt_from) && (1..7).include?(opt_to) then
      puts "*"*50
      puts "HOW MANY CARD(S):\n"
      puts "*"*50
      number = gets.chomp.to_i
    end

    # 1.Tableau:1
    # 2.Tableau:2
    # 3.Tableau:3
    # 4.Tableau:4
    # 5.Tableau:5
    # 6.Tableau:6
    # 7.Tableau:7
    # 8.Discard
    # 9.Foundation

    #case 1: from_discard_to_tableau
    move_to_tableau(@discard, @tableau[opt_to], 1) && @card_number -=1 if (opt_from == 8 && (1..7).include?(opt_to))

    #case 2: from_foundation_to_tableau
    move_to_tableau(@foundation[fs], @tableau[opt_to], 1) if (opt_from == 9 && (1..7).include?(opt_to))
    
    #case 3: from_tableau_to_tableau
    move_to_tableau(@tableau[opt_from], @tableau[opt_to], number) if ((1..7).include?(opt_from) && (1..7).include?(opt_to))

    #case 4: from_discard_to_foundation
    move_to_foundation(@discard) && @card_number -=1 if (opt_from == 8 && opt_to == 9)
    
    #case 5: from tableau_to_foundation
    move_to_foundation(@tableau[opt_from]) if ((1..7).include?(opt_from) && opt_to == 9)

  end

  def flip_prompt(str)
    s = title(str)
    puts "*"*50
    puts "WHICH TABLEAU:\n#{s}"
    puts "*"*50
    flip(@tableau[gets.chomp.to_i].last)
  end

  private
  def rank(r, ranks)
    #ace
    r ? ranks.find_index(r) + 1 : nil
  end

  def format(card)
    c = card[0, 2].join('-').center(5)
    black = %w{s c}
    black.include?(card[0]) ? c.green : c.red
  end

  def title(str)
    str.each_with_index { |o, index| str[index] = "#{index+1}." + o.capitalize }
    str.map { |w| w.gsub(/_/, ' ') }.join("\n")
  end

end
