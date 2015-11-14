class Song

  META_MATCH        = /@title\s*\n?(.*)\n*@artist\s*\n?(.*)/
  CHORDS_MATCH      = '[A-G](b|#)?((m(aj)?|M|aug|dim|sus)?([2-7]|9|13)?)?(\/[A-G](b|#)?)?'
  CHORDS_LINE_MATCH = "^\s*((#{CHORDS_MATCH}\s+)+|(#{CHORDS_MATCH}\s+)+#{CHORDS_MATCH}|#{CHORDS_MATCH}\s*)$"

  CHORDS_REGEXP      = Regexp.new(CHORDS_MATCH)
  CHORDS_LINE_REGEXP = Regexp.new(CHORDS_LINE_MATCH)

  SECTION_REGEXP = /^##\s*(.*)$/

  attr_reader :artist, :title, :text, :sections

  def initialize(file)
    @file = file
    parse_file
  end

  def identifier
    @identifier ||= [artist, title].join('-').gsub(/[^a-zA-Z\-_0-9]/, '_')
  end

  def processed_text
    result = ''
    lines.each do |tokens|
      tokens.each do |token|
        case token
          when SongComponents::Literal
            result << token.html_string
          when SongComponents::Chord
            result << token
        end
      end
      result << "\n"
    end
    result
  end

  private

  def parse_file
    @content        = File.read(@file)
    match           = @content.match(META_MATCH)
    @title, @artist = match.to_a[1..2]
    @text           = match.post_match
    @sections       = parse_text(@text)
  end

  def parse_text(text)
    sections        = []
    current_section = SongComponents::Section.new('Initial', true)

    text.lines.each do |row|
      if row =~Song::SECTION_REGEXP
        sections << current_section
        section_name    = row.match(Song::SECTION_REGEXP)[1]
        current_section = SongComponents::Section.new(section_name)
      elsif row =~Song::CHORDS_LINE_REGEXP
        current_section.add_line parse_chords_row(row)
      else
        current_section.add_line [SongComponents::Literal.new(row.rstrip)]
      end

      # case row
      #   when Song::SECTION_REGEXP
      #     sections << current_section
      #     section_name    = row.match(Song::SECTION_REGEXP)[1]
      #     current_section = SongComponents::Section.new(section_name)
      #   when Song::CHORDS_LINE_REGEXP
      #     current_section.add_line parse_chords_row(row)
      #   else
      #     current_section.add_line [SongComponents::Literal.new(row.rstrip)]
      # end
    end

    sections << current_section
  end

  def parse_chords_row(row)
    result = []
    match  = row.match Regexp.new("\s+|#{CHORDS_MATCH}")
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