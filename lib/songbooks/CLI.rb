require 'thor'
require 'songbooks/server'

module Songbooks
  class CLI < Thor
    desc :start, 'Starts a songbook server'
    def start(directory = '.')
      puts "Starting songbook server in #{File.expand_path(directory)}..."
      Songbooks.initialize_folder(File.expand_path(directory))
      Songbooks::Server.run!
    end
  end
end
