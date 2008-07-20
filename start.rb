$:.unshift "/home/vince/lib/ruby/ramaze/lib/"
$:.unshift "/home/vince/lib/ruby/sequel/lib/"

require 'rubygems'
require 'ramaze'
require 'sequel'
require 'json'

DB = Sequel.connect 'sqlite:/'

class Message < Sequel::Model
  set_schema do
    primary_key :id
    datetime :stamp
    text :username
    text :message
  end
  
  many_to_one :room
  
  before_create do |record|
    record.stamp = Time.now
  end
end
unless Message.table_exists?
  Message.create_table
end

class Room < Sequel::Model
  set_schema do
    primary_key :id
    text :title
  end
  
  one_to_many :message
end

unless Room.table_exists?
  Room.create_table
  
  Room.create :title => "NSS"
end

class MainController < Ramaze::Controller
  
  def index
  end
  
  def chat(name=nil)
    redirect :/ if name.nil?
  end
  
  def messages
    message unless request[:message].nil? or request[:message] == ""
    msgs = ""
    
    last = request[:last] || 0
    
    Message.filter(:id > last).order(:id).each do |msg|
      msgs << "<p>#{msg.username || 'Anonymous'}: #{msg.message}</p>"
      last = msg[:id]
    end
    
    {:last => last, :msgs => msgs}.to_json
  end
  
  def message
    Message.create(:username => session[:username], :message => request[:message])
  end
  
  def username
    session[:username] = request[:username] if request.post?
    redirect_referer
  end
  
end

Ramaze.start :load_engines => [:Haml, :Sass], :port => 27015

