class ProductsController < ApplicationController
    def index
        @products = Product.all.order("updated_at DESC") 
    end
   
  def new
    @product = Product.new # we need an instance of our resource to be used with `form_with`
  end
  
  def create
    # params.require(:product).permit(:title, :body) => tells rails to allow an object on the params that is called question. And on that question object allow the keys :title and :body
    @product = Product.new(params.require(:product).permit(:title, :description, :price,:sales_price))
    #tell active record to goahead and run the INSERT SQL query against our db. Returns true if it saves, returns false if it doesn't save
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end
  def show
    id = params[:id]
    @product = Product.find(id)
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
    if @product.update(params.require(:product).permit(:title, :description,:price, :sales_price))
      redirect_to product_path(@product)
    else
      render :edit
    end
  end
  
end
