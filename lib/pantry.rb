require "YAML"

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
    "*#{shopping_list.to_yaml}"
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def cookbook_recipe_ingredient_stock
    @cookbook.map do |recipe|
      recipe.ingredients.values
    end
  end

  def stock_for_recipe
    @cookbook.map do |recipe|
    recipe.amount_required(recipe)
    end
  end

  def what_can_i_make
    stock_for_recipe
  end

end
