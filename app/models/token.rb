class Token < ApplicationRecord
    has_many :tokenizings, dependent: :destroy 
    has_many :products, through: :tokenzings
    
    before_save :downcase_name #saves it before. 
    
    validates :name, presence: true, uniqueness: {
        case_sensitive: false 
        # The case_sensitive option will
        # make uniqueness validation
        # ignore case. For example, two 
        # records with names "SCIENCES" and 
        # "Sciences" can't co-exist
    }
    
    
    private 

    def downcase_name 
        self.name&.downcase!
    end
    
    
end
