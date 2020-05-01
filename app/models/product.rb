class Product < ApplicationRecord
    has_many :tokenizings, dependent: :destroy 
    has_many :tokens, through: :tokenizings
    
    # if you don't use either depandent options, you can end up
    # with answers in your db referencing question_ids
    # that no longer exist, likely leading to errors. 
    # Always set a dependent option to help maintain
    # referential integrity.
    has_many :favourites
    has_many :favouriters, through: :favourites, source: :user
    #, source: :tag
    # If the name of the association (i.e. tags) is the same as the
    # source singularized (i.e. tag), then the 'source:' named
    # argument can be omitted
    
    belongs_to :user
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

   
  
    
    
    
    
    
    scope(:search, -> (query){ where("title ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%") })
    
    def token_names 
        self.tokens.map(&:name).join(", ")
        # The & symbol is used to tell Ruby that the following argument
        # should be treated as a block givent to the method. So the line:
        # self.tags.map(&:name).join(", ")
        # is equivalent to:
        # self.tags.map { |x| x.name }.join(", ")
        # So the above will iterate over the collection self.tags
        # and build an array with the result of the name method 
        # called on every item. (We then join the array into a comma
        # separated string)
    end
    
    # Appending = at the end of a method name, allows us to implement
    # a 'setter'. A setter is a method that is assignable.
    # Example: 
    # q.tag_names = "stuff, yo"

    # The code in the example above would call the method we wrote 
    # below where the value on the right-hand side of the '=' would 
    # become the argument to the method 

    # This is similar to implementing an 'attr_writer'
    def token_names=(rhs)
        self.tokens = rhs.strip.split(/\s*,\s*/).map do |token_name| 
            # Finds the first record with the given attributes, or
            # initializes a record (Tag.new) with the attributes
            # if one is not found 
            Token.find_or_initialize_by(name: token_name)
            # If a tag with name tag_name is not found,
            # it will call Tag.new(name: tag_name)
        end
    end

    
    
    
    
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
    
    
    
    
end
