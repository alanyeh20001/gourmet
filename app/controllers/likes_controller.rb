class LikesController < ApplicationController
  
  def create
	  @like_restaurant = Like.create(like_params)
	  
	  if @like_restaurant.save
	    redirect_to maps_path
	  else
	    render json: {status: "fail"}
	  end
	end
	
	
	private
	
	def like_params
	  params.require(:like).permit(:restaurant_id, :user_id)
	end
	
end
