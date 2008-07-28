class Room < Sequel::Model
  set_schema do
    primary_key :id
    text :name
  end
  
  has_many :messages
  many_to_many :users, :join_table => :joined
  
  create_table unless table_exists?
end
