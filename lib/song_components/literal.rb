module SongComponents
  class Literal
    def initialize(string)
      @string = string
    end

    def to_s
      @string
    end

    def to_str
      @string
    end

    def html_string
      @string
    end
  end
end