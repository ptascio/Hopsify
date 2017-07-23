class Beer
   include ActiveModel::Model
   require 'rest-client'
   require 'base64'
   require 'uri'

   def self.get_beer_info
     uri = URI.parse('http://api.brewerydb.com/v2/beers?')
     params = URI.decode_www_form(uri.query)
     params << ['key', ENV["brewery_key"]]
     params << ['name', "Budweiser"]
     uri.query = URI.encode_www_form(params)
     selected_beer = RestClient::Request.execute(
      method: :get,
      url: "#{uri}",
     )
     return JSON.parse(selected_beer.body)
   end

   def self.get_beer_by_style(id)
     uri = URI.parse('http://api.brewerydb.com/v2/beers?')
     params = URI.decode_www_form(uri.query)
     params << ['key', ENV["brewery_key"]]
     params << ['styleId', "#{id}"]
     params << ['order', 'random']
     params << ['randomCount', "3"]
     uri.query = URI.encode_www_form(params)
     selected_beer = RestClient::Request.execute(
      method: :get,
      url: "#{uri}",
     )

     return JSON.parse(selected_beer.body)
   end

  

end
