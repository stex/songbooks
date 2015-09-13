module SongComponents
  class Chord
    def initialize(chord_name)
      @chord_name = chord_name
    end

    def name
      @chord_name
    end

    def ==(other_chord)
      name == other_chord.name
    end
  end
end