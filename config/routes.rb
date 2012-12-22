BNIP2P::Application.routes.draw do

  root :to => "pages#home";
  
  match "page/:action", :controller => "pages", :as => :page;

  # match ':controller(/:action(/:id))(.:format)'
end
