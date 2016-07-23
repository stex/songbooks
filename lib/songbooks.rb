module Songbooks
  # Gem requires
  require 'haml'
  require 'sinatra'
  require 'active_support/all'
  require 'prawn'
  require 'sinatra/prawn'
  require 'sinatra/jbuilder'
  require 'json'

  # Ruby requires
  require 'pathname'

  # Internal requires
  require 'songbooks/folder'

  def self.root
    Pathname.new(File.dirname(__dir__))
  end

  def self.font_file(name)
    root.join('app', 'fonts', "#{name}.ttf").to_s
  end

  def self.initialize_folder(directory_path)
    @folder = Songbooks::Folder.new(directory_path)
  end

  def self.folder
    @folder
  end
end
