BNIP2P::Application.routes.draw do

  devise_for :users, path: 'users', :path_names => {
    sign_in: 'login', 
    sign_out: 'logout',
    sign_up: 'register'
  }

  root :to => "pages#home";
  
  match "page/:action", :controller => "pages", :as => :page;

  # match ':controller(/:action(/:id))(.:format)'
end
