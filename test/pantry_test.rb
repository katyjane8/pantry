require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
   def test_it_exists
     pantry = Pantry.new

     assert_instance_of Pantry, pantry
   end

   def test_pantry_has_stock
     pantry = Pantry.new

     assert_equal ({}), pantry.stock
   end

   def test_pantry_stock_can_be_checked
     pantry = Pantry.new

     assert_equal 0, pantry.stock_check("Cheese")
   end

   def test_pantry_can_be_restocked_with_ingredient
     pantry = Pantry.new
     pantry.restock("Cheese", 10)

     assert_equal 10, pantry.stock_check("Cheese")
   end

   def test_pantry_keeps_stock_and_adds_more
     pantry = Pantry.new
     pantry.restock("Cheese", 10)
     pantry.restock("Cheese", 20)

     assert_equal 30, pantry.stock_check("Cheese")
   end

   def test_add_ingredients_to_shopping_list
     pantry = Pantry.new
     r = Recipe.new("Cheese Pizza")
     r.add_ingredient("Flour", 20) # 500 "UNIVERSAL UNITS"
     r.add_ingredient("Cheese", 20)
     pantry.add_to_shopping_list(r)

     assert_equal ({"Cheese" => 20, "Flour" => 20) pantry.shoppinglist 
   end

end
