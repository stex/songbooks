require 'songbooks/song'

module Songbooks
  class Folder
    def initialize(path)
      @path = Pathname.new(path)

      initialize_songs

      register_file_watcher
    end

    attr_reader :path

    def song(identifier)
      songs_by_identifier[identifier]
    end

    def songs
      songs_by_identifier.values
    end

    private

    def add_song(song)
      songs_by_identifier[song.identifier] = song
    end

    def remove_song(song)
      songs_by_identifier.delete(song.identifier)
    end

    def songs_by_identifier
      @songs_by_identifier ||= {}
    end

    def songs_by_filename
      @songs
    end

    def initialize_songs
      @songs = chords_files.each_with_object({}) do |file_path, h|
        song = Songbooks::Song.new(File.read(file_path))
        add_song(song)
        h[file_path] = song
      end
    end

    def chords_files
      Dir[@path.join('**', '*.txt')]
    end

    def register_file_watcher
      listener = Listen.to(path.to_s, only: /\.txt$/) do |modified, added, removed|
        (modified + added).each do |filename|
          song = Songbooks::Song.new(File.read(filename))
          songs_by_filename[filename] = song
          add_song(song)
        end

        removed.each do |filename|
          song = songs_by_filename[filename]
          remove_song(song)
          songs_by_filename.delete(filename)
        end
      end

      listener.start
    end
  end
end
