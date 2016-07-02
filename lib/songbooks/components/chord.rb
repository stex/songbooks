module Songbooks
  module Components
    class Chord

      #----------------------------------------------------------------
      #                          CONSTANTS
      #----------------------------------------------------------------

      NOTES = %w(C Db D Eb E F Gb G Ab A Bb B)

      NOTE_MAPPING = [
          %w(C# Db),
          %w(D# Eb),
          %w(E# F),
          %w(Fb, E),
          %w(F# Gb),
          %w(G# Ab),
          %w(A# Bb),
          %w(B#, C)
      ].each_with_object({}) do |(n1, n2), h|
        h[n1] = n2
        h[n2] = n1
      end

      CHORD_REGEXP = /[A-G](b|#)?((m(aj)?|M|aug|dim|sus)?([2-7]|9|13)?)?(\/[A-G](b|#)?)?/
      NOTE_REGEXP  = /^[A-G](b|#)*/

      def initialize(chord_name, transposed_by: 0)
        @chord_name    = chord_name
        @transposed_by = transposed_by
      end

      attr_reader :transposed_by

      def name
        @chord_name
      end

      def base_note
        name.match(NOTE_REGEXP)[0]
      end

      def transpose!(count)
        note            = base_note
        note            = NOTE_MAPPING[base_note] unless NOTES.include?(base_note)
        index           = NOTES.index(note)
        transposed_note = NOTES[(index + number) % NOTES.size]
        @transposed_by  = count
        @chord_name.sub!(note, transposed_note)
      end

      def transpose(count)
        dup.transpose!
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
end
