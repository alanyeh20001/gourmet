class Admin::RestaurantsController < ApplicationController
  
  def index
    @restaurants_has_liked_id = Like.select("restaurant_id").where("user_id = ?", params[:user_id]).map{|x| x[:restaurant_id]}
    @restaurants_has_liked = Restaurant.where(id: @restaurants_has_liked_id)
  end
end
