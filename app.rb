require "sinatra"
require "sinatra/reloader"
require "http"


get("/") do

  # build the API url, including the API key in the query string
  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_KEY"]}"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)

  # get the symbols from the JSON
  @symbols = parsed_data["currencies"]

  # render a view template where I show the symbols
  erb(:homepage)
end

get("/:currency") do
  # build the API url, including the API key in the query string
  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_KEY"]}"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)

  # get the symbols from the JSON
  @symbols = parsed_data["currencies"]

  @currency = params.fetch("currency")

  erb(:currency)

end

get("/:currency/:conversion") do

  @currency = params.fetch("currency")
  @conversion = params.fetch("conversion")

  api_url = "http://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_KEY"]}&from=#{@currency}&to=#{@conversion}&amount=1"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)

  @result = parsed_data["result"]

  erb(:conversion)
end
