# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

ENV['GEM_PATH']="#{ENV['GEM_HOME']}:/usr/local/lib/ruby/gems/2.7.0"
require 'rubygems'
Gem.clear_paths

run Rails.application
