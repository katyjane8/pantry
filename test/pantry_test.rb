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
end
