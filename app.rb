require "sinatra/base"
require "haml"
require 'sprockets'
require 'sprockets-helpers'

class PChui < Sinatra::Base
  set :sprockets,     Sprockets::Environment.new(root)
  set :precompile,    [ /\w+\.(js|css).+$/ ]
  set :assets_prefix, "/assets"
  set :digest_assets, false
  set(:assets_path)   { assets_prefix }
  
  configure do
    # Setup Sprockets
    sprockets.append_path File.join(root, 'assets', 'styles')
    sprockets.append_path File.join(root, 'assets', 'js')
    sprockets.append_path File.join(root, 'assets', 'images')
    sprockets.append_path File.join(root, 'assets', 'fonts')

    # Configure Sprockets::Helpers (if necessary)
    Sprockets::Helpers.configure do |config|
      config.environment = sprockets
      config.prefix      = assets_prefix
      config.digest      = digest_assets
      config.public_path = public_folder

      # Force to debug mode in development mode
      # Debug mode automatically sets
      # expand = true, digest = false, manifest = false
      config.debug       = true if development?
    end
  end
 
  helpers do
    include Sprockets::Helpers
  end

  get "/" do
    haml :index
  end
end
