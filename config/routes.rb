Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get("/", to: "welcome#home") 
  get("/about", to: "welcome#about") 
  get("/contact_us", to: "welcome#contact_us") 
  get("/billsplitter", to: "welcome#billsplitter")
  post("/process_contact", to: "welcome#process_contact" )
  post("/total", to: "welcome#total")
end
