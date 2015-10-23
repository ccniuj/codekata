#kata21 test
require 'test/unit'
require 'minitest/autorun'
require_relative 'kata21'

describe 'List' do 
  it 'can find node' do
  list = List.new
  list.add("fred")
  list.add("wilma")
  list.add("betty")
  list.add("barney")
 
	assert_equal("fred",  list.find("fred").value())
	assert_equal("wilma", list.find("wilma").value())
  end

  it 'can delete node' do
    list = List.new
    list.add("fred")
    list.add("wilma")
    list.add("betty")
    list.add("barney")
   	list.delete(list.find("wilma"))
  	assert_equal(["fred", "betty", "barney"], list.values())
  end
  
  it 'can delete tail' do
    list = List.new
    list.add("fred")
    list.add("wilma")
    list.add("betty")
    list.add("barney")
   	list.delete(list.find("barney"))
  	assert_equal(["fred", "wilma", "betty"], list.values())
  end	
  
  it 'can delete head' do
    list = List.new
    list.add("fred")
    list.add("betty")
    list.delete(list.find("fred"))
   	assert_equal(["betty"], list.values())
  end

  it 'can delete the last node' do
	  list = List.new
    list.add("betty")
    list.delete(list.find("betty"))
	  assert_equal([], list.values()) 
  end

end