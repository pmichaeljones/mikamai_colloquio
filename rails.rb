class Order << ActiveRecord::Base

  validates_presence_of :customer_id, :code

  belongs_to :customer
  has_many :line_items


end


class LineItem << ActiveRecord::Base

  validates_presence_of :order_id, :product_id

  belongs_to :order
  belongs_to :product

end


class Product << ActiveRecord::Base
  
  validates_presence_of :sku

end



# class ProductController < ApplicationController
#   include 'API'

# end

class API

  class ProductsController

    def self.say_hi
      puts "hello"
    end

  end

end
