Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do 
      resources  :listings, only: [:index, :show], constraints: {format: 'json'}
    end
  end  
end
