require Songbooks.lib_dir.join('songbooks', 'folder')

enable :sessions

set :views, Songbooks.root.join('app', 'views')
set :public_folder, Songbooks.root.join('public')

Songbooks.chords_directory_path = Pathname.new(File.expand_path(ARGV.first || Dir.pwd))
Songbooks.chords_directory      = Songbooks::Folder.new