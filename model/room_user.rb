class RoomUser < Sequel::Model(:rooms_users)
  set_schema do
    primary_key :id
    integer :room_id
    integer :user_id
    datetime :stamp
  end
  
  before_save do |record|
    record.stamp = Time.now
  end
end

RoomUser.create_table unless RoomUser.table_exists?
