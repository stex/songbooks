module Views
  class Main

    def initialize(app = Configuration.app)
      @app = app
    end

    def generate_view
      @app.flow :margin => 8 do
        @chords_folder = @app.caption Configuration.chords_folder
        @app.button('Choose Chords Folder').click { set_chords_folder }
      end
      @song_list    = @app.stack :margin => 10, :height => '90%', :width => '20%'
      @main_content = @app.stack :margin => 10, :height => '90%', :width => '60%' do
        @app.caption 'blubb'
      end
    end

    private

    def set_chords_folder
      Configuration.chords_folder = @app.ask_open_folder
      @chords_folder.replace Configuration.chords_folder
      load_song_list
    end

    def load_song_list
      @song_list.clear
      @song_list.append do
        @app.caption @app.strong 'Available Songs:'
      end

      Folder.new(Configuration.chords_folder).song_list.songs.each do |song|
        @song_list.append do
          @app.caption("#{song.title} (#{song.artist})").click do
            show_song(song)
          end
        end
      end
    end

    def show_song(song)
      @main_content.clear
      @main_content.append do
        @app.caption song.text
      end
    end

  end
end