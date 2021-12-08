require 'sequel'
ENV['RACK_ENV'] = "test"

require './config/environment'
DB = Sequel::Model.db
require 'rack/test'
require 'rspec/sequel'

RSpec.configure do |c|
  c.around(:each) do |example|
    DB.transaction(:rollback=>:always, :auto_savepoint=>true){example.run}
  end
end
