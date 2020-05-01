class ReviewsController < ApplicationController
    before_action :authorize!, only: [:create, :destroy]
  
    def create 
        @product = Product.find(params[:product_id])
        @review = Review.new review_params
        @review.product = @product
        @review.user = current_user
        if @review.save
            redirect_to product_path(@product)
        else
            # For the list of answers
            @reviews = @product.reviews.order(created_at: :desc)
            render 'products/show'
        end
        
    end
    
    def destroy 
        @review = Review.find params[:id]
        if can?(:crud, @review)
            @review.destroy 
            redirect_to product_path(@review.product)
        else 
            #head will send an empty HTTP response with 
            # a particular response code, in this case
            # unauthorized 401. 
            # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
            head :unauthorized
            # redirect_to root_path, alert: 'Not Authorized'
        end
    end 
    
    def liked
        # all the questions that this particular logged in user has liked
        @reviews = current_user.liked_reviews.order(created_at: :desc)
      end
    
    private 
    def review_params 
        params.require(:review).permit(:rating,:body)
    end
    
end
