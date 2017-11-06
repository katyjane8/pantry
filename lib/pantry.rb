class Pantry
  attr_reader :stock

  def initialize
    @stock = Hash.new(0)
    @shopping_list = []
  end

  def stock_check(ingredient)
    @stock[ingredient]
  end

  def restock(ingredient, pounds)
    @stock[ingredient] += pounds
  end

  def add_to_shopping_list(food)
    @shopping_list << food.ingredients
  end

  def shopping_list
    @shopping_list.reduce(Hash.new) do |result, list|
      result.merge(list) {|k, v1, v2| v1 + v2}
    end
  end

  def print_shopping_list
    shopping_list.each do |k, v|
    end
  end

end
