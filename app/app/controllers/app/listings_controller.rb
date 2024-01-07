module App
  class ListingsController < ApplicationController
    before_action :authenticate_user!

    def index
      @listings = Listings::Find.find_all({ id: params[:id], current_user: })
    end

    def show
      @listing = Listings::Find.find_one_by_id({ id: params[:id], current_user: })
      raise ActionController::RoutingError, 'Not Found' unless @listing.present?
    end

    def reviews
      @listing = Listings::Find.find_one_by_id({ id: params[:id], current_user: })
      raise ActionController::RoutingError, 'Not Found' unless @listing.present?

      render json: Listings::Reviews.call({ listing: @listing, current_user: })
    end

    def create
      listing = ::Listings::Create.call({ current_user:, url: params[:listing][:url] })

      redirect_to app_listings_show_path(id: listing.id)
    end
  end
end
