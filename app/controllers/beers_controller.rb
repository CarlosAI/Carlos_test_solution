class BeersController < ApplicationController
  before_action :authenticate!
  skip_before_action :verify_authenticity_token, :only => [:save_favorite_beer]

  def index
    render json: {
        hello: @current_user.name
    }
  end

  def get_all_beers
  	pages = 13
  	output = []
  	for i in 1..pages
	  	response = HTTParty.get("https://api.punkapi.com/v2/beers?per_page=25&page=#{i}")
	  	if response.code == 200
	    	res = JSON.parse response.body
	    	res.map { |beer| 
	    				seen = Beer.beersRequested(@current_user.id, beer)
	    				beer["seen_at"] = seen[0]
	    				beer["favorite"] = seen[1]
	    				output.push( beer.slice("id", "name", "tagline", "description", "abv", "seen_at", "favorite"))
	    			}
		end
	end
	render status: 200, json: { body: output}.to_json
  end

  def get_beers_by_name
  	if params["beer_name"].present?
	  	response = HTTParty.get("https://api.punkapi.com/v2/beers?per_page=80&beer_name=#{params["beer_name"]}")
	  	output = []
	  	if response.code == 200
	  		res = JSON.parse response.body
	    	res.map { |beer| 
	    				seen = Beer.beersRequested(@current_user.id, beer)
	    				beer["seen_at"] = seen[0]
	    				beer["favorite"] = seen[1]
	    				output.push( beer.slice("id", "name", "tagline", "description", "abv", "seen_at", "favorite"))
	    			}
	    	render status: 200, json: { body: output}.to_json
	  	else
	  		render status: 404, json: { body: response.body,}.to_json
	  	end
	else
		render status: 402, json: { body: "Parameter 'beer_name' is required",}.to_json
	end
  end

  def get_beers_by_avb
  	if params["abv_gt"].present?
	  	response = HTTParty.get("https://api.punkapi.com/v2/beers?per_page=80&abv_gt=#{params["abv_gt"]}")
	  	output = []
	  	if response.code == 200
	  		res = JSON.parse response.body
	    	res.map { |beer| 
	    				seen = Beer.beersRequested(@current_user.id, beer)
	    				beer["seen_at"] = seen[0]
	    				beer["favorite"] = seen[1]
	    				output.push( beer.slice("id", "name", "tagline", "description", "abv", "seen_at", "favorite"))
	    			}
	    	render status: 200, json: { body: output}.to_json
	  	else
	  		render status: 404, json: { body: response.body,}.to_json
	  	end
	  else
	  	render status: 402, json: { body: "Parameter 'abv_gt' is required",}.to_json
	  end
  end

  def save_favorite_beer
  	if params["beer_id"].present?
  		beer = Beer.where("beer_id"=>params["beer_id"], "user_id"=>@current_user.id).take
  		if beer.present?
  			beer.favorite = true
  			beer.save
  		else
  			render status: 400, json: { body: "Beer not found",}.to_json
  		end
  	else
  		render status: 402, json: { body: "Parameter 'beer_id' is required",}.to_json
  	end
  end

  def get_favorites
  	beers = Beer.where("user_id"=>@current_user.id, "favorite"=>true)
  	render status: 200, json: { body: beers.to_json}.to_json
  end
end
