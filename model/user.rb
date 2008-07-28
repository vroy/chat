class User < Sequel::Model
  set_schema do
    primary_key :id
    text :name
    text :password
    datetime :online
  end
  
  has_many :messages
  many_to_many :rooms, :join_table => :joined
  
  validates do
    uniqueness_of :name
    presence_of :name
    presence_of :password
  end
  
  create_table unless table_exists?
end
