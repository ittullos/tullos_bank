class Customer < Sequel::Model
  one_to_many :accounts
end
