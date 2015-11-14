module SongComponents
  class Chord
    def initialize(chord_name)
      @chord_name    = chord_name
      @transposed_by = 0
    end

    def transposed_by
      @transposed_by
    end

    def name
      @chord_name
    end

    def ==(other_chord)
      name == other_chord.name
    end

    def to_s
      name
    end

    def to_str
      name
    end
  end
end