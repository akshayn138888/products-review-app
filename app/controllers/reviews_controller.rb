class ReviewsController < ApplicationController
    def create 
        @product = Product.find(params[:product_id])
        @review = Review.new review_params
        @review.product = @product
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
        @review.destroy 
        redirect_to product_path(@review.product)
    end 
    
   ``
    
    private 
    def review_params 
        params.require(:review).permit(:rating,:body)
    end
    
end
