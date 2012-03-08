require 'sinatra'
require 'albino'
require 'nokogiri'

require 'epp_client'

class App < Sinatra::Application
  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
    
    def colorize(text, lang)
      doc = Nokogiri::XML(text, &:noblanks)
      Albino.colorize(doc, lang.to_sym)
    end
  end
  
  get '/' do
    client = EppClient::Registrobr::Client.new("beta.registro.br", 700)
    @check = client.check(params[:dominio])
    
    erb :index
  end
end
