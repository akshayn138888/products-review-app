class AddSalesPriceToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :sales_price, :float

  end
end
