class Account < Sequel::Model
  many_to_one :customer
  one_to_many :transactions
end
