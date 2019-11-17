class Beer < ApplicationRecord
validates :beer_id, :uniqueness => {:scope => :user_id}

before_create :set_favorite

	def set_favorite
		self.favorite = false
	end

	def self.beersRequested(user_id, beer)
		beer = Beer.where("user_id"=>user_id, "beer_id"=> beer["id"]).take
		if beer.nil?
			beer = Beer.new
			beer.beer_id = beer_id
			beer.nombre = beer["name"]
			beer.tagline = beer["tagline"]
			beer.description = beer["description"]
			beer.abv = beer["abv"]
	    	beer.seen_at = Time.now
	    	beer.user_id = user_id
	    	beer.save
	    end
    	return [beer.seen_at, beer.favorite]
	end
end
