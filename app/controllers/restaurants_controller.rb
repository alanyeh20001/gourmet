class RestaurantsController < ApplicationController
  before_action :authenticate_user!
	
	def new
		@map = Map.find(params[:map_id])
		@restaurant = @map.restaurants.build
	end
	
	def create
		@map = Map.find(params[:map_id])
		@restaurant = @map.restaurants.build(restaurant_params)
		@restaurant.author = current_user
		
		if @restaurant.save
			require "pismo"
			doc = Pismo::Document.new(@restaurant.website)
			@restaurant.title = doc.titles.last
			@restaurant.save
			redirect_to map_path(@map), notice: "餐廳新增成功~！"
		else
			render :new
		end
	end
	
	def edit
		@map = Map.find(params[:map_id])
		@restaurant = current_user.restaurants.find(params[:id])
	end
	
	def update
		@map = Map.find(params[:map_id])
		@restaurant = current_user.restaurants.find(params[:id])
		
		if @restaurant.update(restaurant_params)
			redirect_to map_path(@map), notice: "餐廳更新成功~！"
		else
			render :edit
		end
	end
	
	def destroy
		@map = Map.find(params[:map_id])
		@restaurant = current_user.restaurants.find(params[:id])
		
		@restaurant.destroy
	  redirect_to map_path(@map), alert: "餐廳已經刪除~"
	end
	
	private
	
	def restaurant_params
		params.require(:restaurant).permit(:website, :location, :title, :photo)
	end
end
