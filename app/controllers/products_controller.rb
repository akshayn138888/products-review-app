class ProductsController < ApplicationController
    
  before_action :authenticate_user!, except: [:index, :show] 
  before_action :authorize!, only: [:edit, :update, :destroy]

  def index  
    #if we search throught questions by tags, for example:
    # localhost:3000/questions?tag=Action
    if params[:token] 
      @token = Token.find_or_initialize_by(name: params[:token])
      @products = @token.products.all.all_with_review_counts.order('updated_at DESC')
    else
    @products = Product.all.order('updated_at DESC')
    end
  end
   
  def new
    @product = Product.new 
  end
  
  def create
    # params.require(:question).permit(:title, :body) => tells rails to allow an object on the params that is called question. And on that question object allow the keys :title and :body
    @product = Product.new(params.require(:product).permit(:title, :description, :price,:sales_price,:token_names))
    @product.user = current_user
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end
  
  def show
    id = params[:id]
    @product = Product.find(id)
    #### a change is very important here also if your relating it to other things.
    @review = Review.new 
    
    @reviews = @product.reviews.order(created_at: :desc)
    @favourite = @product.favourites.find_by(user: current_user)

  end
  def destroy
    id = params[:id]
    @product = Product.find(id)
    @product.destroy
    redirect_to products_path
  end

  def edit
    id = params[:id]
    @product = Product.find(id)
  end
  def update
    id = params[:id]
    @product = Product.find(id)
    if @product.update(params.require(:product).permit(:title, :description,:price, :sales_price,:tag_names))
      redirect_to product_path(@product)
    else
      render :edit
    end
  end
  def favourited
    # all the questions that this particular logged in user has liked
    @products = current_user.favourited_products.all_with_review_counts.order(created_at: :desc)
  end

  # def favourited_by?(user)
  #   favourites.find_by_user_id(user.id).present?
  # end
  # helper_method :favourited_by?
  def authorize! 
    redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, Product)
  end
  
end
