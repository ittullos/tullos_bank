class Customer < Sequel::Model
  one_to_many :accounts

  def account_of_type(type)
    accounts_dataset.where(type: type).first
  end
end
