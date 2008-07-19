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
  
  many_to_one :group
  
  before_create do |record|
    record.stamp = Time.now
  end
end
unless Message.table_exists?
  Message.create_table
end


class MainController < Ramaze::Controller
  
  def index
    %(
    
    )
  end
  
  def chat
  end
  
  def messages
    str = ""
    
    last = request[:last] || 0
    
    Message.filter(:id > last).order(:id).each do |msg|
      str << "<p>#{msg.username || 'Anonymous'}: #{msg.message}</p>"
      last = msg[:id]
    end
    
    {:last => last, :str => str}.to_json
  end
  
  def message
    Message.create(:username => session[:username], :message => request[:message])
    redirect :/
  end
  
  def username
    session[:username] = request[:username] if request.post?
    redirect :/
  end
  
end

Ramaze.start :load_engines => [:Haml, :Sass], :port => 27015

