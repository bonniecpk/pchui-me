require "sinatra/base"
require "haml"

class PChui < Sinatra::Base
  get "/" do
    haml :index
  end
end
