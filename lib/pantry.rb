class Pantry
  attr_reader :stock

  def initialize
    @stock = Hash.new(0)
    @shopping_list = []
    @cookbook = []
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
    list = shopping_list.to_a
    list.each {|k, v| puts "*#{k}: #{v}"}
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    @cookbook.each do |recipe|
      stock_check(recipe)
      require "pry"; binding.pry
    end
  end

end
