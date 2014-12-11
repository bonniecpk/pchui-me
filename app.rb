require "sinatra/base"
require "haml"
require "sass"
require "compass"
require 'sprockets'
require 'sprockets-helpers'
require 'sprockets-sass'

class PChui < Sinatra::Base
  set :sprockets,     Sprockets::Environment.new(root)
  #set :precompile,    [ /\w+\.(js|css).+$/ ]
  set :assets_prefix, "/assets"
  #set :digest_assets, false
  set :assets_path,   assets_prefix
  
  configure do
    # Setup Sprockets
    sprockets.append_path File.join(root, 'assets', 'stylesheets')
    sprockets.append_path File.join(root, 'assets', 'js')
    sprockets.append_path File.join(root, 'assets', 'images')
    sprockets.append_path File.join(root, 'assets', 'fonts')

    # Configure Sprockets::Helpers (if necessary)
    Sprockets::Helpers.configure do |config|
      config.environment = sprockets
      #config.prefix      = assets_prefix
      #config.digest      = digest_assets
      #config.public_path = public_folder

      # Force to debug mode in development mode
      # Debug mode automatically sets
      # expand = true, digest = false, manifest = false
      config.debug       = true if development?
    end

    Compass.configuration do |config|
      config.project_path = File.dirname(__FILE__)
      config.sass_dir     = '/assets/stylesheets'

      set :haml, { format: :html5 }
      set :sass, Compass.sass_engine_options
    end
  end
 
  helpers do
    include Sprockets::Helpers
  end

  get "/" do
    haml :index
  end

  get "/samples/full_height" do
    haml "/samples/full_height/index".to_sym
  end

  get "/samples/web_kit" do
    haml "/samples/web_kit/index".to_sym
  end

  get "/samples/web_kit/styleguide" do
    haml "/samples/web_kit/styleguide".to_sym
  end
end
