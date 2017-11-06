class Pantry
  attr_reader :stock, :shopping_list

  def initialize
    @stock = Hash.new(0)
    @shopping_list = {}
  end

  def stock_check(ingredient)
    @stock[ingredient]
  end

  def restock(ingredient, pounds)
    @stock[ingredient] += pounds
  end

  def add_to_shopping_list(food)
    @shopping_list = food.ingredients
  end

end
