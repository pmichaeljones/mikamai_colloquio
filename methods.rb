require "test/unit"

#Given an array with various levels of nesting, implement a method that flattens the array/
def flatten_array(array)
  return nil unless array.instance_of?(Array)
  result = []
  array.to_s.tr('[]',"").split(",").each do |x|
    result << x.to_i
  end
  result
end

#Given an array of ordered strings, implement a method that gives the location of the searched item
def search_for(array, query)
  array.each_with_index do |item, index|
    return index if query == item
  end
  nil
end


#Given an array of numbers, implement a method to rearrange them in ascending order

def ascending_sort(array)
  return nil unless array.instance_of?(Array)
  sorted_array = []
  until array.length == 0
    amount_of_times_in_array = array.count(array.min)
    
    amount_of_times_in_array.times do 
      sorted_array << array.min
    end
    
    array.delete(array.min)
  end
  sorted_array
end



# Code below adds instance methods to the Array class
class Array
  def search_for(query)
    self.each_with_index do |item, index|
      return index if query == item
    end
    nil
  end

  def ascending_sort
    sorted_array = []
    until self.length == 0
      amount_of_times_in_array = self.count(self.min)
      
      amount_of_times_in_array.times do 
        sorted_array << self.min
      end
      
      self.delete(self.min)
    end
    sorted_array
  end

  def flatten_array
    result = []
    self.to_s.tr('[]',"").split(",").each do |x|
      result << x.to_i
    end
    result
  end

end




###########---------------TEST CASES-------------------############

class TestMethods < Test::Unit::TestCase

  def test_search_for
    animals = ["dog", "cat", "pig", "skunk", "fox"]
    assert_equal search_for(animals, "fox"), 4
    assert_equal search_for(animals, "leopard"), nil
  end

  def test_search_for_instance_method
    animals = ["dog", "cat", "pig", "skunk", "fox"]
    assert_equal animals.search_for("fox"), 4
    assert_equal animals.search_for("leopard"), nil
  end

  def test_flatten_array
    assert_equal flatten_array([1,[4,5],[2,[3,4]]]), [1, 4, 5, 2, 3, 4]
    assert_equal flatten_array([[1,3],3,5,[5,6,[2,6]]]), [1, 3, 3, 5, 5, 6, 2, 6]
    assert_equal flatten_array("bla bla bla"), nil
  end

  def test_flatten_array_instance_method
    array = [1,[4,5],[2,[3,4]]]
    assert_equal array.flatten_array, [1, 4, 5, 2, 3, 4]
    array_2 = [[1,3],3,5,[5,6,[2,6]]]
    assert_equal array_2.flatten_array, [1, 3, 3, 5, 5, 6, 2, 6]
  end

  def test_ascending_order
    assert_equal ascending_sort([5,5,5,4,3,8,9,9,2,1]), [1, 2, 3, 4, 5, 5, 5, 8, 9, 9]
    assert_equal ascending_sort([1,2,6,3,3,8,9,5,4,7,8,6,4]), [1, 2, 3, 3, 4, 4, 5, 6, 6, 7, 8, 8, 9]
    assert_equal ascending_sort("dogs"), nil
  end

  def test_ascending_order_instance_method
    array = [5,5,5,4,3,8,9,9,2,1]
    assert_equal array.ascending_sort, [1, 2, 3, 4, 5, 5, 5, 8, 9, 9]
    array_2 = [1,2,6,3,3,8,9,5,4,7,8,6,4]
    assert_equal array_2.ascending_sort, [1, 2, 3, 3, 4, 4, 5, 6, 6, 7, 8, 8, 9]
  end

end

