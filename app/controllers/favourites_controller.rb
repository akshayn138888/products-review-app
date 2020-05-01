class FavouritesController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy] 
    def create
        # 1) review_id -> review that is going to be liked. This comes from params
        # 2) user_id -> user that liked this review. This comes from session
      
        product = Product.find params[:product_id]
        favourite = Favourite.new(product: product, user: current_user)
    
        if !can?(:favourite, product)
          flash[:danger] = "You can't favourite your own product...."
        elsif favourite.save
          flash[:success] = "product favourited"
        else
          flash[:danger] = favourite.errors.full_messages.join(", ")
        end
        redirect_to product_path(product)
      end
    
      def destroy
        # like = Like.find params[:id]. with this way a user is able to search ALL likes
        favourite = current_user.favourites.find params[:id] # this way user can only search his/hers likes
     
        if !can?(:destroy, favourite)
          flash[:warning] = "you can't destroy a favourite you don't own"
        elsif favourite.destroy
          flash[:success] = "product not your favourite anymore"
        else
          flash[:warning] = "It's rude to unlike something you've already liked"
        end
    
        redirect_to product_path(favourite.product)
      end
    
end
