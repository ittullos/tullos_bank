Sequel.migration do
  up do
    create_table(:accounts) do
      primary_key :id
      foreign_key :customer_id, :customers
      String :type, null: false
    end
  end

  down do
    drop_tables(:accounts)
  end
end
