require_relative 'models/customer'
require_relative 'models/account'
require_relative 'models/transaction'
require_relative 'models/account_type'

class TullosBank < Sinatra::Base

  get '/' do
    "Hello World!"
  end

  get '/login/:id' do
    Customer[params[:id]].name
  end

  get '/deposit/:id/:type/:amt' do
    @customer = Customer[params[:id]]
    @account = @customer.accounts_dataset.where(type: params[:type]).first
    @account.add_transaction(amount: params[:amt])
    "Thank you for your deposit!"
    "Your new account balance is #{@account.transactions_dataset.sum(:amount)}"
  end

  get '/withdraw/:id/:type/:amt' do
    @customer = Customer[params[:id]]
    @account = @customer.accounts_dataset.where(type: params[:type]).first
    @account.add_transaction(amount: (params[:amt]).to_i.-@)


  end

end
