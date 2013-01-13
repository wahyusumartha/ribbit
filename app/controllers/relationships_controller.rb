class RelationshipsController < ApplicationController

	def create 
		@relationship = Relationship.new 
		@relationship.followed_id = params[:followed_id]
		@relationship.follower_id = current_user.id 

		if @relationship.save 
			redirect_to User.find(params[:followed_id])
		else 
			flash[:error] = "Could not follow for some reason"
			redirect_to current_user
		end
	end

	def destroy
		@relationship = Relationship.find_by_followed_id(params[:id])
		@relationship.destroy
		redirect_to user_path params[:id]
	end
end
