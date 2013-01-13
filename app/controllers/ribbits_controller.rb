class RibbitsController < ApplicationController

	def create 
		@ribbit = Ribbit.new(params[:ribbit])
		@ribbit.user_id = current_user.id
		if @ribbit.save 
			redirect_to current_user 
		else 
			flash[:error] = "Problem! Your Ribbit Must No Longer than 140 Characters"
			redirect_to current_user
		end
	end

end
