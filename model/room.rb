class Room < Sequel::Model
  set_schema do
    primary_key :id
    text :name
  end
  
  has_many :messages
  has_many :users
end

unless Room.table_exists?
  Room.create_table
end

Room.create :name => "Test"
