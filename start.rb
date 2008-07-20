$:.unshift "/home/vince/lib/ruby/ramaze/lib/"
$:.unshift "/home/vince/lib/ruby/sequel/lib/"

require 'rubygems'
require 'ramaze'
require 'sequel'
require 'json'

DB = Sequel.connect 'sqlite:/'

require 'model/message'
require 'model/room'
require 'model/user'
require 'model/room_user'
require 'controller/main'
require 'controller/user'

#Create dummy data
User.create :name => "asdf", :password => "asdf"
User.create :name => "remy", :password => "remy"
User.create :name => "bob", :password => "bob"
Room.create :name => "Test"

Ramaze.start :load_engines => [:Haml, :Sass], :port => 27015

