require 'minitest/autorun'
require './sales_engine'
require 'minitest/pride'

class SalesEngineTest < Minitest::Test
  def test_a_sales_engine_can_be_instantiated
    assert SalesEngine.new
  end

  def test_a_sales_engine_has_a_item_repository
    se = SalesEngine.new
    assert se.item_repository
  end
end

class ItemRepositoryTest < Minitest::Test
  def test_it_creates_items
    ir = ItemRepository.new(nil)
    assert_equal 0, ir.count
    ir.create_item(:name => "Sample 1")
    ir.create_item(:name => "Sample 2")
    assert_equal 2, ir.count
    assert_equal "Sample 1", ir.items[0].name
    assert_equal "Sample 2", ir.items[1].name
  end
end

class ItemTest < Minitest::Test
  def test_it_knows_where_it_came_from
    item_repo = ItemRepository.new(nil)
    item_repo.create_item(:name => "The Thing")
    item = item_repo.items.first
    assert_equal item_repo, item.repository
  end

  def test_it_can_find_the_associated_merchant
    se = SalesEngine.new
    se.merchant_repository.create_merchant(:name => "The Merch", :id => 24)
    merchant = se.merchant_repository.merchants.first
    se.item_repository.create_item(:name => "Thing 3", :merchant_id => 24)
    item = se.item_repository.items.first

    assert_equal merchant, item.merchant
  end
end
