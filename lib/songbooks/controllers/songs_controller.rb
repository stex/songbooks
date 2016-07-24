require 'songbooks/controllers/controller'

module Songbooks
  module Controllers
    class SongsController < Controller

      def initialize(params = {}, session = {})
        @params = params
        @session = session
      end

      attr_reader :session, :params

      def index
        @songs    = Songbooks.folder.songs
        @template = 'songs/index'
      end

      def show
        @song = Songbooks.folder.song(params['identifier'])
        @template = 'songs/show'
      end

      def generate
        @songs = @session['songbook'].map { |id| Songbooks.folder.song(id) }
      end
    end
  end
end

