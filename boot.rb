require 'logger'

require 'bundler/setup'
Bundler.require

APP_ROOT = File.dirname(__FILE__)

require File.join(APP_ROOT, 'lib/data_mapper/property/serialized_php')

require 'active_support/dependencies'

ActiveSupport::Dependencies.autoload_paths << File.expand_path('../lib', __FILE__)

def setup_db!
  config = YAML.load_file(File.join(APP_ROOT, 'config/db.yml'))
  DataMapper::Logger.new(STDOUT, :debug)
  DataMapper.setup(:default, config['ipgallery'])
end

def reload!
  ActiveSupport::Dependencies.clear
  include Ipboard
  DataMapper.finalize
end

setup_db!
