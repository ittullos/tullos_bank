require_relative 'models/customer'
require_relative 'models/account'
require_relative 'models/transaction'
require_relative 'models/account_type'

class TullosBank < Sinatra::Base

  get '/' do
    "Welcome to Tullos Bank!"
  end

  get '/login/:id' do
    "Hello, #{Customer[params[:id]].name}"
  end

  get '/deposit/:id/:type/:amt' do
    @customer = Customer[params[:id]]
    @account = @customer.account_of_type(params[:type])
    @account.add_transaction(amount: params[:amt])
    "Thank you for your deposit! Your new #{@account.type} account balance is $#{@account.balance_output}"
  end

  get '/withdraw/:id/:type/:amt' do
    @customer = Customer[params[:id]]
    @account = @customer.account_of_type(params[:type])
    @account.add_transaction(amount: (params[:amt]).to_i.-@)

    "Thank you for using Tullos Bank! Your new #{@account.type} account balance is $#{@account.balance_output}"
  end

  get '/balance/:id/:type' do
    @customer = Customer[params[:id]]
    @account = @customer.account_of_type(params[:type])
    "Your #{@account.type} account balance is $#{@account.balance_output}"
  end

  get '/logout' do
    "Thank you for using Tullos Bank! Have a great day"
  end

end
