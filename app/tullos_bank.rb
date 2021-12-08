require_relative 'models/customer'
require_relative 'models/account'
require_relative 'models/transaction'
require_relative 'models/account_type'

class TullosBank < Sinatra::Base

  get '/' do
    "Hello World!"
  end

  get '/customers' do
    Customer.first[:name]
  end

end
