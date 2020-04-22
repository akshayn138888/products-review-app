class User < ApplicationRecord
    
    
    scope(:search, -> (query){ where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "#{query}", "#{query}", "#{query}") })
    validates(:first_name, presence: true, uniqueness: true)
    
    before_validation(:no_Apple)
    def no_Apple
        if first_name&.downcase == "apple" || first_name&.downcase == "microsoft" || first_name&.downcase == "sony"
            self.errors.add(:first_name, "Must not have apple,microsoft,sony")
        end
    end
    

end
