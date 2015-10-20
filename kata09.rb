#kata09

require 'pry'

class CheckOut
  
  attr_accessor :pricing_rules, :amounts

  def initialize(p=[])
    if params_check(p) then
      @pricing_rules = p 
      @amounts = Hash.new(0)
    else
      puts 'The setting of pricing_rules are incorrect!'
    end
  end

  def total
    total = 0
    @amounts.each{ |k, v|
      pricing_rule = @pricing_rules.select{|a| a['item'] == k}.first
      case pricing_rule['rule']
        when 'p%'
          total += v*pricing_rule['price']*pricing_rule['params'].first/100.0
        when 'n4m'
          n = pricing_rule['params'].shift
          m = pricing_rule['params'].shift
          total += (v/n)*m + (v%n)*pricing_rule['price']
        when 'n4p%'
          puts 'n4p%'
      end
    }
    total
  end

  def scan(item)
    @amounts[item] += 1
  end

  private
  # There are 3 types of pricing rule: "p%", "n4m" and "n4p%".
  # The pricing rule can be presented as an array
  # pricing_rules = [ h1, h2...hn ]
  # hn = { 'item' => 'A' , 'price' => 99, 'rule' => 'p%', 'params' => [90, nil] }
  def params_check(p=[])
    p.all? {|h|
      h.key?('item') && h['item'].kind_of?(String)
      h.key?('price') && h['price'].kind_of?(Integer)
      h.key?('rule') && %w(p% n4m n4p%).include?(h['rule'])
      h.key?('params') && h['params'].kind_of?(Array) &&h['params'].to_a.all? {|e| e.kind_of?(Integer) }
    }
  end
end

a = CheckOut.new([
  {'item'=>'A', 'price'=>10, 'rule'=>'p%', 'params'=>[60]}, 
  {'item'=>'B', 'price'=>20, 'rule'=>'n4m', 'params'=>[3,50]}
])
3.times {a.scan('A')}
6.times {a.scan('B')}
puts a.total
