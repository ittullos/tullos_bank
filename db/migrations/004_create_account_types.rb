Sequel.migration do
  up do
    create_table(:account_types) do
      primary_key :id
      String :type, null: false
    end
  end

  down do
    drop_tables(:account_types)
  end
end
