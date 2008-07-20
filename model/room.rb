class Room < Sequel::Model
  set_schema do
    primary_key :id
    text :name
  end
  
  has_many :messages
  many_to_many :users
end

unless Room.table_exists?
  Room.create_table
end
