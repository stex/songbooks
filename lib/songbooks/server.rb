require 'sinatra/base'
require 'songbooks/controllers/songs_controller'
require 'songbooks/view_helper'

module Songbooks
  class Server < Sinatra::Base
    include Sinatra::Prawn::Helpers

    configure do
      enable :sessions

      set :views, Songbooks.root.join('app', 'views').to_s
      set :public_folder, Songbooks.root.join('public').to_s

      set :prawn, { :page_layout => :portrait, :page_size => 'A4' }
    end

    get '/' do
      haml :application
    end

    get '/songs.json' do
      controller = Songbooks::Controllers::SongsController.new(params)
      controller.index

      controller.resulting_instance_variables.each do |var_name|
        instance_variable_set(var_name, controller.instance_variable_get(var_name))
      end

      jbuilder controller.template
    end

    get '/songs/:identifier.json' do
      controller = Songbooks::Controllers::SongsController.new(params)
      controller.show

      controller.resulting_instance_variables.each do |var_name|
        instance_variable_set(var_name, controller.instance_variable_get(var_name))
      end

      jbuilder controller.template
    end

    post '/songbook' do
      @params = JSON.parse(request.body.read)
      session[:songbook] = params['songs']
    end

    get '/songbook.pdf' do
      controller = Songbooks::Controllers::SongsController.new(params, session)
      controller.generate

      controller.resulting_instance_variables.each do |var_name|
        instance_variable_set(var_name, controller.instance_variable_get(var_name))
      end

      content_type 'application/pdf'
      prawn :songbook
    end

    get '/static/*' do
      haml params['splat'].first.to_sym
    end
  end
end
