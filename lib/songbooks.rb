module Songbooks

  cattr_accessor :chords_directory, :chords_directory_path

  def self.root
    Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '..')))
  end

  def self.lib_dir
    self.root.join('lib')
  end

end