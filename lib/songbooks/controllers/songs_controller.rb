module Songbooks
  module Controllers
    class SongsController < Controller

      def initialize(params = {}, session = {})
        @params = params
        @session = session
      end

      def index
        @songs    = Songbooks.chords_directory.song_list.songs
        @template = 'songs/index'
      end

      def show
        @template = 'songs/show'

        @song = Songbooks.chords_directory.song_list.songs.select {|s| s.identifier == @params['identifier']}.first
      end

      def generate
        @songs = Songbooks.chords_directory.song_list.songs.select { |s| @session['songbook'].include?(s.identifier) }
        @songs.sort_by! {|s| @session['songbook'].index(s.identifier)}
      end

    end
  end
end

