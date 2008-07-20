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
require 'controller/main'
require 'controller/user'

Ramaze.start :load_engines => [:Haml, :Sass], :port => 27015

