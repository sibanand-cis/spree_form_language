Spree::Core::Engine.routes.draw do


  namespace :admin do
    resources :forms do
    	member do
    		post 'fetch_yml'
    		get 'form_lang_edit'
    		post 'form_lang_update'
    	end
    end
  end



  # Add your extension routes here
end
