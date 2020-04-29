class AdminsController < ApplicationController
    def panel
        
    end
    def index
        @products = Product.all.order("updated_at DESC") 
        @users = User.all.order("updated_at DESC")
    end
end
