class SongList

  attr_reader :songs

  def initialize(files)
    @songs = files.map { |f| Song.new(f) }
  end

  def to_latex
    layout = File.read(File.join(File.dirname(__FILE__), '..', 'tex', 'songbook.tex'))
    template = ERB.new(layout, 0, '>')
    template.result(binding)
  end

  def generate_pdf
    document = ::RTeX::Document.new(to_latex, :preprocess => true)
    begin
      File.write('songbook.pdf', document.to_pdf)
    end
    true
  end

end