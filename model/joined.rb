class Joined < Sequel::Model(:joined)
  set_schema do
    primary_key :id
    integer :room_id
    integer :user_id
    datetime :stamp
  end
  
  before_save do |record|
    record.stamp = Time.now
  end
  
  create_table unless table_exists?
end
