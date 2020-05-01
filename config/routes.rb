Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get("/", to: "welcome#home") 
  # get("/about", to: "welcome#about") 
  # get("/contact_us", to: "welcome#contact_us") 
  # get("/billsplitter", to: "welcome#billsplitter")
  # post("/process_contact", to: "welcome#process_contact" )
  # post("/total", to: "welcome#total")
  
  # #######
  get("/admin/panel", to: "admins#panel")
  get("/admin/index", to: "admins#index")

  # get("/products/new", to: "products#new", as: :new_product) 
  # get("/products/:id/edit", to: "products#edit", as: :edit_product)
  # ######
  # post("/products", to: "products#create")
  
  # #####
  # get("/products/:id", to: "products#show", as: :product)
  # patch("/products/:id", to: "products#update")
  # delete("/products/:id", to: "products#destroy")
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  


  resources :products do 
    resources :reviews, only: [:create, :destroy]
    resources :favourites,shallow: true ,only: [:create, :destroy]
    get :favourited, on: :collection
  end
  
  resources :reviews do
    resources :likes, only: [:create, :destroy]
    get :liked, on: :collection
  end
  
end
