require Songbooks.lib_dir.join('songbooks', 'folder')

enable :sessions

set :views, Songbooks.root.join('app', 'views')
set :public_folder, Songbooks.root.join('public')

set :prawn, { :page_layout => :portrait, :page_size => 'A4' }

Songbooks.chords_directory_path = Pathname.new(File.expand_path(ARGV.first || Dir.pwd))
Songbooks.chords_directory      = Songbooks::Folder.new