require 'sequel'

ENV['RACK_ENV'] ||= "dev"
DB_FILE = "db/tullos_bank_#{ENV['RACK_ENV']}.sqlite3"
Sequel::Model.db = Sequel.sqlite DB_FILE

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

require 'rubygems'
require 'sinatra'
require 'pry-byebug'
require './app/tullos_bank'
