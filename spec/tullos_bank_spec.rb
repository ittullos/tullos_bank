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
        expect(last_response.body).to match(/Tullos Bank/)
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

  describe "using routes" do

    before do
      Customer.insert(name: "Julie")
      @customer = Customer.last
      @customer.add_account(type: 'savings')
      @account = @customer.accounts.first
      @account.add_transaction(amount: 9611)
    end

    context "for login" do
      it "returns the first customer's name" do
        get '/login/1'
        expect(last_response.body).to match(/Julie/)
        expect(last_response.status).to eq(200)
      end
    end

    context "for deposit" do
      it "returns deposit message" do
        balance = @account.transactions_dataset.sum(:amount)
        get '/deposit/1/savings/389'
        expect(@account.transactions_dataset.sum(:amount)).to eq (balance + 389)
        expect(last_response.status).to eq(200)

      end
    end

    context "for withdrawal" do
      it "returns withdrawal message" do
        balance = @account.transactions_dataset.sum(:amount)
        get '/withdraw/1/savings/388'
        expect(@account.transactions_dataset.sum(:amount)).to eq(balance - 388)
        expect(last_response.status).to eq(200)
      end
    end

    context "for checking balance" do
      it "returns the balance for the given account" do
        get '/balance/1/savings'
        expect(last_response.body).to include("#{@account.balance_output}")
        expect(last_response.status).to eq(200)
      end
    end
    context "to logout" do
      it "logs out the customer" do
        get '/logout'
        expect(last_response.body).to include("great day")
        expect(last_response.status).to eq(200)
      end
    end
  end
end
