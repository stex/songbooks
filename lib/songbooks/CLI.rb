require 'thor'
require 'songbooks/server'

module Songbooks
  class CLI < Thor
    desc :start, 'Starts a songbook server'
    def start(directory = '.')
      Songbooks.initialize_folder(File.expand_path(directory))
      puts Songbooks.folder.inspect
      Songbooks::Server.run!
    end
  end
end
