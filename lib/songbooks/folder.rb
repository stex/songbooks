module Songbooks
  class Folder
    attr_reader :path

    def initialize(path = Songbooks.chords_directory_path)
      @path = path
    end

    def song_list
      SongList.new(chords_files)
    end

    private

    def chords_files
      Dir[@path.join('**', '*.txt')]
    end
  end
end