module SongComponents
  class Section
    def initialize(name, initial = false)
      @name    = name
      @content_lines = []
      @initial = initial
    end

    def add_line(line)
      @content_lines << line
    end

    def name
      @name == 'Initial' ? '' : @name
    end

    def lines
      @content_lines
    end
  end
end