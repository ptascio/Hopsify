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

   def self.get_bud_light
     #Bud Light dimtrs
     #Bud Light Lime Mang-O-Rita VwOYAS
     #Bud Light Lime MzoCPz
     choices = ["Bud Light Lime Mang-O-Rita", "Bud Light Lime", "Bud Light Chelada"]
     uri = URI.parse('http://api.brewerydb.com/v2/beers?')
     params = URI.decode_www_form(uri.query)
     params << ['key', ENV["brewery_key"]]
     params << ['ids', 'MzoCPz, VwOYAS, dimtrs']
     uri.query = URI.encode_www_form(params)
     selected_beer = RestClient::Request.execute(
      method: :get,
      url: "#{uri}",
     )

     return JSON.parse(selected_beer.body)
   end

   def self.get_by_description(type)
     id = ""
     if type == "us-classic"
       id = ["93", "98"].sample
     elsif type == "diet"
       id = "94"
     elsif type == "super-diet"
       id = "95"
     elsif type == "ice"
       id = "99"
     elsif type == "pilsener"
       id = ["75", "80", "73", "106"].sample
     elsif type == "adventure"
       id = ["130", "119", "122"].sample
     elsif type == "coffee"
       id = ["123", "162"].sample
     end
     get_beer_by_style(id)
   end



end
