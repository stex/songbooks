class Song

  META_MATCH         = /@title\s*\n?(.*)\n*@artist\s*\n?(.*)/
  CHORDS_MATCH       = '[A-G](b|#)?((m(aj)?|M|aug|dim|sus)?([2-7]|9|13)?)?(\/[A-G](b|#)?)?'
  CHORDS_LINE_MATCH  = "^\s*((#{CHORDS_MATCH}\s+)+|(#{CHORDS_MATCH}\s+)+#{CHORDS_MATCH}|#{CHORDS_MATCH}\s*)$"

  CHORDS_REGEXP      = Regexp.new(CHORDS_MATCH)
  CHORDS_LINE_REGEXP = Regexp.new(CHORDS_LINE_MATCH)

  attr_reader :artist, :title, :text, :chords

  def initialize(file)
    @file = file
    parse_file
  end

  def identifier
    @identifier ||= [artist, title].join('-').gsub(/[^a-zA-Z\-_0-9]/, '_')
  end

  private

  def parse_file
    @content = File.read(@file)
    match = @content.match(META_MATCH)
    @title, @artist = match.to_a[1..2]
    @text   = match.post_match
    @lines  = parse_text(@text)
  end

  def parse_text(text)
    text.lines.map do |row|
      if row =~ Song::CHORDS_LINE_REGEXP
        parse_chords_row(row)
      else
        [SongComponents::Literal.new(row)]
      end
    end
  end

  def parse_chords_row(row)
    result = []
    match = row.match Regexp.new("\s+|#{CHORDS_MATCH}")
    while match
      if match[0] =~ CHORDS_REGEXP
        result << SongComponents::Chord.new(match[0])
      else
        result << SongComponents::Literal.new(match[0])
      end
      match = match.post_match.match Regexp.new("\s+|#{CHORDS_MATCH}")
    end
    result
  end
end