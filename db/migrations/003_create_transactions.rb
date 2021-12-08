Sequel.migration do
  up do
    create_table(:transactions) do
      primary_key :id
      foreign_key :account_id, :accounts
      Integer :amount, null: false
    end
  end

  down do
    drop_tables(:transactions)
  end
end
