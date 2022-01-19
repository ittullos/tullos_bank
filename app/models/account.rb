class Account < Sequel::Model
  many_to_one :customer
  one_to_many :transactions

  def balance
    transactions_dataset.sum(:amount)
  end

  def balance_output
    "#{balance/100}.#{sprintf '%02d', balance%100}"
  end
  
end
