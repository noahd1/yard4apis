ActionController::Routing::Routes.draw do |map|
  map.namespace :api do |api|
    api.connect 'v1/statuses/update.:format',   :controller => 'statuses',
                                                :action => 'update',
                                                :conditions => {:method => :post}

    api.connect 'v1/friendships/check.:format', :controller => 'friendships', :action => 'check',
                                                :conditions  => {:method => :get}
  end
end
