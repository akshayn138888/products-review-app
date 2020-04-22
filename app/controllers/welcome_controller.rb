class WelcomeController < ApplicationController
    def home
        
    end
    def about

    end

    def contact_us


    end
    def billsplitter
    end
    
    
    
    
    def process_contact
   
  
        @email = params[:email]
        @message = params[:message]
        @name = params[:name]
        render :thank_you
      
    
    end
    
    def total 
        @amount = params[:amount].to_f
        @tax = params[:tax].to_f
        @tip = params[:tip].to_f
        @people = params[:people].to_f
        @total = (params[:amount].to_f+(params[:amount].to_f*params[:tax].to_f/100)+params[:tip].to_f)/params[:people].to_f
        
        render :split_page
    end 
end
