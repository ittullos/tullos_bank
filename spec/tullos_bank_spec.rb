require 'spec_helper'

RSpec.describe TullosBank do
  include Rack::Test::Methods

  def app
    TullosBank
  end

  describe 'database' do
    context "canary in the coal mine" do
      it "loads the homepage" do
        get '/'
        expect(last_response.status).to eq(200)
      end

      it "says hello" do
        get '/'
        expect(last_response.body).to match(/Hello/)
      end
    end

    context "with tables" do
      before do
        Customer.insert(name: "Julie")
        @customer = Customer.last
        @customer.add_account(type: 'savings')
        @account = @customer.accounts.first

      end

      it "gets the name of the first customer" do
        #get '/customer'
        expect(Customer.first.name).to eq("Julie")
      end

      it "assigns the correct customer id" do
        expect(Customer.first[:id]).to eq 1
      end

      it "creates a new account" do
        expect(@account[:type]).to match(/savings/)
      end

      it "makes sure the account type is valid" do
        expect(AccountType.map{|x| x.type}).to include(@account[:type])
      end

      it "makes it's first deposit" do
        @account.add_transaction(amount: 9611)
        expect(@account.transactions.first[:amount]).to eq 9611
      end

      it "calculates account balance" do
        @account.add_transaction(amount: 9611)
        @account.add_transaction(amount: -4322)
        @account.add_transaction(amount: 18366)
        @account.add_transaction(amount: -1232)
        expect(@account.transactions_dataset.sum(:amount)).to eq 22423
      end
    end

  end
end
