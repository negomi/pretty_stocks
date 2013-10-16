require 'sinatra'
require 'sinatra/reloader'
require 'yahoofinance'
require 'pry'

get '/' do
  erb :form
end

post '/your-stock-price' do
  # Convert input to CAPS
  @input = params[:symbol].upcase
  # Check for blank input
  if @input == ""
    erb :error
  else
    # Fetch data from YF
    @quote = YahooFinance::get_standard_quotes(@input)
    @name = @quote[@input].name
    # Error handling
    if @quote[@input].valid?
      @buy = @quote[@input].bid
      @sell = @quote[@input].ask
      erb :stock_price
    else
      erb :error
    end
  end
end
