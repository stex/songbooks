module Songbooks
  module Controllers
    class SongsController < Controller

      def initialize(params = {})
        @params = params
      end

      def index
        @template = 'songs/index'
      end

      def show
        @template = 'songs/show'

        @song = Songbooks.chords_directory.song_list.songs.select {|s| s.identifier == @params['identifier']}.first
      end

    end
  end
end

