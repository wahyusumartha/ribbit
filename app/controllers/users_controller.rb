class UsersController < ApplicationController

	def index 
		@users = User.all
	end

	def new 
		if current_user 
			redirect_to user_path current_user
		else 
			@user = User.new
		end
	end

	def create 
		@user = User.new(params[:user])
		if @user.save 
			session[:user_id] = @user.id
			redirect_to @user, notice: "Thank you for signing up for Ribbit" 
		else 
			render 'new'
		end 
	end

	def show 
		@ribbit = Ribbit.new
		@user = User.find(params[:id])
		@relationship = Relationship.where(
				follower_id: current_user.id, 
				followed_id: @user.id
			).first_or_initialize if current_user

		if params[:id].to_f === current_user.id
			# Get Followed Id
			buddies_ids = current_user.followeds.map(&:id).push(current_user.id)
			@ribbits = Ribbit.find_all_by_user_id buddies_ids
		else 
			@ribbits = Ribbit.find_all_by_user_id params[:id]
		end
	end

end
