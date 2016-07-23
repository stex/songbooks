require 'songbooks/song'

module Songbooks
  class Folder
    def initialize(path)
      @path = Pathname.new(path)
    end

    attr_reader :path

    def song(identifier)
      songs_by_identifier[identifier]
    end

    def songs
      songs_by_identifier.values
    end

    private

    def songs_by_identifier
      @songs ||= chords_files.each_with_object({}) do |file_path, h|
        song = Songbooks::Song.new(File.read(file_path))
        h[song.identifier] = song
      end
    end

    def chords_files
      Dir[@path.join('**', '*.txt')]
    end
  end
end
