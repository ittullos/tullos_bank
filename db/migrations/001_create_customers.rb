Sequel.migration do
  up do
    create_table(:customers) do
      primary_key :id
      String :name, null: false
    end
  end

  down do
    drop_tables(:customers)
  end
end
