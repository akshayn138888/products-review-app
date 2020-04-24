class Product < ApplicationRecord
    has_many(:reviews, dependent: :destroy)
    
    validates(:title, presence: true)
    validates(
        :description,
        presence: { message: "must exist" }
    )
    validates(
        :price,
        numericality: { greater_than_or_equal_to: 0 }
    )
    validates(
        :sales_price,
        numericality: { greater_than: 0 }
    )
   
    validate :default_price
    before_validation(:capitalize_title)
    before_validation(:set_default_sales_price)

    #Ex:- :default =>''
    private 
    def default_price
        self.price||=1
    end
    
    def capitalize_title
       self.title.capitalize!       
    end
    
    def set_default_sales_price
        if self.sales_price == nil
            self.sales_price= self.price
        end
        if self.sales_price > self.price
            self.sales_price = 0
        end
    end
    
    
    
    
    
    scope(:search, -> (query){ where("title ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%") })
end
