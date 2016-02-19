class MapsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
	
	def index
		@maps = Map.all
	end
	
	def show
		@map = Map.find(params[:id])
		@restaurant = @map.restaurants.order(created_at: :desc)
    
    # filter those restaurants without addresses
    @restaurant_with_location = []
    @restaurant.each do |restaurant|
      if restaurant.latitude != nil
        @restaurant_with_location.push(restaurant)
      end
    end
    
		@hash = Gmaps4rails.build_markers(@restaurant_with_location) do |restaurant, marker|
		  marker.lat restaurant.latitude
		  marker.lng restaurant.longitude
		  marker.infowindow restaurant.title
		end
	end
	
	def new
		@map = Map.new
	end
	
	def create
		@map = current_user.maps.new(map_params)
		
		if @map.save
			redirect_to maps_path, notice: "耶~美食景點新增成功~"
		else
			render :new
		end
	end
	
	def edit
		@map = current_user.maps.find(params[:id])
	end
	
	def update
		@map = current_user.maps.find(params[:id])
		
		if @map.update(map_params)
			redirect_to maps_path, notice: "改的不錯！"
		else
			render :edit
		end
	end
	
	def destroy
		@map = current_user.maps.find(params[:id])
		@map.destroy
		redirect_to maps_path	, alert: "哇哇~少了一個美食景點QQ"
	end


	private
	
	def map_params
		params.require(:map).permit(:title)
	end
end
