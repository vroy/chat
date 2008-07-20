class User < Sequel::Model
  set_schema do
    primary_key :id
    text :name
    text :password
    datetime :online
  end
  
  has_many :messages
  many_to_many :rooms
  
  validates do
    uniqueness_of :name
    presence_of :name
    presence_of :password
  end
  
end

unless User.table_exists?
  User.create_table
end
