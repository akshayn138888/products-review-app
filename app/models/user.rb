class User < ApplicationRecord
    
    has_secure_password
    has_many :products
    has_many :likes
    has_many :liked_reviews, through: :likes, source: :review
    
    has_many :favourites
    has_many :favourited_products, through: :favourites, source: :product
    # u = User.find(15)
    # u.questions -> because of the has_many relationship will return all the questions that belong to user
    has_many :reviews
      
    scope(:search, -> (query){ where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "#{query}", "#{query}", "#{query}") })
    validates(:first_name, presence: true, uniqueness: true)
    
    before_validation(:no_Apple)
    def no_Apple
        if first_name&.downcase == "apple" || first_name&.downcase == "microsoft" || first_name&.downcase == "sony"
            self.errors.add(:first_name, "Must not have apple,microsoft,sony")
        end
    end


end
