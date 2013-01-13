module RibbitsHelper

	def time_ago(ribbit)
		time_ago_in_words(ribbit.created_at)
	end

end
