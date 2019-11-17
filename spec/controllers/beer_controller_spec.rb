require 'rails_helper'

RSpec.describe BeersController, type: :controller do
	describe "testing" do
		it "get_beers" do
			#Success
	    	get :get_all_beers
	    	expect(response).to be_successful
	    end


	    it "get_favorite_beers" do
	    	get :get_favorites
	    	#Success
	    	expect(response).to be_successful
	    end
	end
end
