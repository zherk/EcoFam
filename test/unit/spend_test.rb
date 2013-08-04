require 'test_helper'

class SpendTest < ActiveSupport::TestCase
  test "should not create a spend without amount" do
    spend = Spend.new(:titulo => "Sin monto", :spend_date => Time.now)
    assert !spend.save
  end
  
  test "should not create a spend without tittle" do
    spend = Spend.new(:amount => 1, :spend_date => Time.now)
    assert !spend.save
  end
  
  test "should not create a spend without date" do
    spend = Spend.new(:titulo => "nada", :amount => 1)
    assert !spend.save
  end
  
  test "create a spend" do
    spend = Spend.new(:titulo => "nada", :amount => 1, :spend_date => Time.now)
    assert spend.save
  end

  test "should have a period" do
    spend = Spend.new(:titulo => "nada", :amount => 1, :spend_date => Time.now)
    assert spend.save
    assert spend.period
  end
end
