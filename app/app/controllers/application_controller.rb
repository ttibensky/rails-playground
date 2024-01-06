class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    app_listings_path
  end
end
