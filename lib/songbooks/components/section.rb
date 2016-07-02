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

    def transpose!(count)
      lines.flatten.each do |component|
        next unless component.is_a?(SongComponents::Chord)
        component.transpose!(count)
      end
    end
  end
end
