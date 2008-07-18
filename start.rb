$:.unshift "/home/vince/lib/ruby/ramaze/lib/"
$:.unshift "/home/vince/lib/ruby/sequel/lib/"

require 'rubygems'
require 'ramaze'
require 'sequel'

DB = Sequel.connect 'sqlite:/'

class Message < Sequel::Model
  set_schema do
    primary_key :id
    datetime :stamp
    text :username
    text :message
  end
  
  before_create do |record|
    record.stamp = Time.now
  end
end

unless Message.table_exists?
  Message.create_table

  #Message.create(:username => "exploid", :message => "Hello!")
  #Message.create(:username => "Pistos", :message => "Hi exploid, welcome to our chat.")
end


class MainController < Ramaze::Controller
  
  def index
    @messages = messages
  end
  
  def messages
    str = ""
    Message.all do |msg|
      str << "#{msg.username || 'Anonymous'}: #{msg.message}\n"
    end
    str
  end
  
  def message
    Message.create(:username => session[:username], :message => request[:message])
    redirect :index
  end
  
  def username
    session[:username] = request[:username] if request.post?
    redirect :index
  end
  
end

Ramaze.start :load_engines => [:Haml, :Sass]

