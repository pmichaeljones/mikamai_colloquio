class Order << ActiveRecord::Base

  validates_presence_of :customer_id, :code

  has_many :line_items
  has_many :products, through: :line_items

end


class LineItem << ActiveRecord::Base

  validates_presence_of :order_id, :product_id

  belongs_to :order
  belongs_to :product

end


class Product << ActiveRecord::Base
  
  validates_presence_of :sku

  has_many :line_items
  has_many :orders, through: :line_items
  
end

### --- Rails JSON API Controller --- ###

# Controller API::Products containing the show action that must be visualized:
# ○ 404 if the order does not exist
# ○ The JSON order (containing line items and products) if the order exists

# The instructions are above. I created an Orders controller instead of a Products controller. Products are
# not related to a specific order. They occur in many different orders.
# So, it is not possible to produce a specific order based on a specific Product. 
# However, an order DOES have specific line items and products. So, if they request an order ID that exists, 
# they get back the order information. If they request an order that does not exist, they get 404ed.


module API

  include 'JSON'

  class OrdersController < ApplicationController

    before_action :set_authorization_header
    respond_to :json

    def show
      @order = Order.find(params[:id])
      if @order
        render json: @order.to_json(:include => [:products, :line_items]), status: 200
      else
        render json: { error: "That order doesn't exist" }.to_json, status: 404
    end
  end 

end


### --- RSpec Tests --- ###

require 'railers_helper'

describe API::OrdersController do 

  describe "GET show" do

  # order exists in database
  # order = Order.new
  # order.id => 2

    before { authenticate_user }

    it "should set authentication string" do 
      session["Authentication"] = nil 
      get '/api/orders/2'
      expect(request.session["Authorization"]).to be_a_kind_of(String)
      expect(response.status).to eq(404)
    end

    it "should return a 404 an unauthenticated users" do
      session["Authentication"] = nil 
      get '/api/orders/2'
      expect(response.status).to eq(404)
    end

    context "if order doesn't exist" do 
      
      it "should return a 404 error" do 
        get '/api/orders/xyz'
        expect(request.session["Authorization"]).to be_a_kind_of(String)
        expect(response.status).to eq(404)
      end
    
    end

    context "if order exists" do 

      it "should return a JSON object" do 
        get '/api/orders/2'
        expect(response.headers["Content-Type"]).to eq("application/json")
        expect(response.status).to eq(200)
      end
    
    end

  end


end
