require_relative 'models/customer'
require_relative 'models/account'
require_relative 'models/transaction'
require_relative 'models/account_type'
require 'sinatra/cookies'

#enable :sessions

#set :session_secret, "My session secret"

#configure(:development) { set :session_secret, "something" }

#set :session_secret, "here be dragons"

# use Rack::Session::Cookie, :key => 'rack.session',
#                            :path => '/',
#                            :secret => 'your_secret'

#set :session, :expire_after => 2592000

#Rack::Session::Pool
class TullosBank < Sinatra::Base

enable :sessions
set :session_secret, "here be dragons"

  get '/' do
    erb :index
  end

  get '/login' do
    erb :login, { :locals => params }
  end

  post '/login' do
    @customer = Customer[params[:id]]
    session[:customer] = @customer
    redirect "/account_menu"
  end

  get '/account_menu' do
    @customer = session[:customer]
    erb :account_menu
  end

  get '/action_menu' do
    @customer = session[:customer]
    erb :action_menu
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
