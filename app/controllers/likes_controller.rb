class LikesController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy] 
    def create
        # 1) review_id -> review that is going to be liked. This comes from params
        # 2) user_id -> user that liked this review. This comes from session
      
        review = Review.find params[:review_id]
        like = Like.new(review: review, user: current_user)
    
        if !can?(:like, review)
          flash[:danger] = "You can't like your own review...."
        elsif like.save
          flash[:success] = "review Liked"
        else
          flash[:danger] = like.errors.full_messages.join(", ")
        end
        redirect_to product_path(like.review.product)
      end
    
      def destroy
        # like = Like.find params[:id]. with this way a user is able to search ALL likes
        like = current_user.likes.find params[:id] # this way user can only search his/hers likes
    
        if !can?(:destroy, like)
          flash[:warning] = "you can't destroy a like you don't own"
        elsif like.destroy
          flash[:success] = "review Unliked"
        else
          flash[:warning] = "It's rude to unlike something you've already liked"
        end
    
        redirect_to review_path(like.review)
      end
    
end
