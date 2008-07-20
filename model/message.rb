class Message < Sequel::Model
  set_schema do
    primary_key :id
    datetime :stamp
    text :message
    integer :room_id
    integer :user_id
  end
  
  belongs_to :room
  belongs_to :user
  
  before_create do |record|
    record.stamp = Time.now
  end
end

unless Message.table_exists?
  Message.create_table
end

