class ChangePriceToFloat < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :price, :float
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
