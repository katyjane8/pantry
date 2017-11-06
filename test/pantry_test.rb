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

   def test_shopping_list_returns_empty_hash_by_default
     pantry = Pantry.new
     r = Recipe.new("Cheese Pizza")

     assert_equal ({}), pantry.shopping_list
   end

   def test_ingredients_can_be_added_to_shopping_list
     pantry = Pantry.new
     r = Recipe.new("Cheese Pizza")
     r.add_ingredient("Flour", 20)
     r.add_ingredient("Cheese", 20)
     result = pantry.add_to_shopping_list(r)

     assert_equal [{"Flour"=>20, "Cheese"=>20}], result
   end

   def test_shopping_list_returns_ingredients
     pantry = Pantry.new
     r = Recipe.new("Cheese Pizza")
     r.add_ingredient("Flour", 20) # 500 "UNIVERSAL UNITS"
     r.add_ingredient("Cheese", 20)
     pantry.add_to_shopping_list(r)

     assert_equal ({"Cheese" => 20, "Flour" => 20}), pantry.shopping_list
   end

   def test_another_recipe_can_be_added
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Flour", 20)
    r1.add_ingredient("Cheese", 20)
    pantry.add_to_shopping_list(r1)

    r2 = Recipe.new("Spaghetti")
    r2.add_ingredient("Spaghetti Noodles", 10)
    r2.add_ingredient("Marinara Sauce", 10)
    r2.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r2)
    result = ({"Cheese" => 25, "Flour" => 20, "Spaghetti Noodles" => 10,
               "Marinara Sauce" => 10})

    assert_equal result, pantry.shopping_list
   end

   def test_shopping_list_can_be_printed
     skip
     pantry = Pantry.new
     r1 = Recipe.new("Cheese Pizza")
     r1.add_ingredient("Flour", 20)
     r1.add_ingredient("Cheese", 20)
     pantry.add_to_shopping_list(r1)

     r2 = Recipe.new("Spaghetti")
     r2.add_ingredient("Spaghetti Noodles", 10)
     r2.add_ingredient("Marinara Sauce", 10)
     r2.add_ingredient("Cheese", 5)
     pantry.add_to_shopping_list(r2)
     result = "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"

     assert_equal result, pantry.print_shopping_list
   end

   def test_recipes_can_be_added_to_cookbook
     pantry = Pantry.new
     r1 = Recipe.new("Cheese Pizza")
     r1.add_ingredient("Cheese", 20)
     r1.add_ingredient("Flour", 20)

     r2 = Recipe.new("Pickles")
     r2.add_ingredient("Brine", 10)
     r2.add_ingredient("Cucumbers", 30)

     r3 = Recipe.new("Peanuts")
     r3.add_ingredient("Raw nuts", 10)
     r3.add_ingredient("Salt", 10)

     assert_equal "Peanuts", pantry.add_to_cookbook(r3).first.name
   end

   def test_make_something_from_food_i_have
     pantry = Pantry.new
     r1 = Recipe.new("Cheese Pizza")
     r1.add_ingredient("Cheese", 20)
     r1.add_ingredient("Flour", 20)

     r2 = Recipe.new("Pickles")
     r2.add_ingredient("Brine", 10)
     r2.add_ingredient("Cucumbers", 30)

     r3 = Recipe.new("Peanuts")
     r3.add_ingredient("Raw nuts", 10)
     r3.add_ingredient("Salt", 10)
     pantry.add_to_cookbook(r1)
     pantry.add_to_cookbook(r2)
     pantry.add_to_cookbook(r3)

     pantry.restock("Cheese", 10)
     pantry.restock("Flour", 20)
     pantry.restock("Brine", 40)
     pantry.restock("Cucumbers", 120)
     pantry.restock("Raw nuts", 20)
     pantry.restock("Salt", 20)

     assert_equal ["Pickles", "Peanuts"], pantry.what_can_i_make
   end

end
