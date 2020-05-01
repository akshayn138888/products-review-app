class Tokenizing < ApplicationRecord
  belongs_to :product
  belongs_to :token
   
  
  # Each tag can only be applied to a question once
  validates :token_id, uniqueness: { scope: :product_id}
  
end
