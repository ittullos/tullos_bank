class Account < Sequel::Model
  many_to_one :customer
  one_to_many :transactions

  def balance
    "$#{transactions_dataset.sum(:amount)/100}.#{transactions_dataset.sum(:amount)%100}"
  end
end
