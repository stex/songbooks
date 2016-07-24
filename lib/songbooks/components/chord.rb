module Songbooks
  module Components
    class Chord

      #----------------------------------------------------------------
      #                          CONSTANTS
      #----------------------------------------------------------------

      NOTES = %w(C Db D Eb E F Gb G Ab A Bb B).freeze

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
      end.freeze

      CHORD_REGEXP = /[A-G](?:b|#)?(?:(?:m(?:aj)?|M|aug|dim|sus)?(?:[2-7]|9|13)?)?(?:\/[A-G](?:b|#)?)?/.freeze
      NOTE_REGEXP  = /\A[A-G](b|#)*/.freeze

      # A chord in a line has to appear either right before a space or punctuation symbol
      # or be the only thing left in a string
      CHORD_OCCURRENCE_REGEXP = /\A(#{CHORD_REGEXP})(?:\s+|[\.,\|])|\A(#{CHORD_REGEXP})\z/.freeze

      #----------------------------------------------------------------
      #                            Parsing
      #----------------------------------------------------------------

      #
      # Tries to parse the beginning of the given text as a chord
      #
      # If the text starts with a chord, this part of the string is automatically deleted.
      #
      # @return [Chord, NilClass] a chord object if the given text started with a valid chord
      #   or +nil+ otherwise.
      #
      def self.munch_chord(text)
        if (match = text.match(CHORD_OCCURRENCE_REGEXP))
          chord_name = match[1..-1].compact.first
          text[0, chord_name.length] = ''
          return Chord.new(chord_name)
        end
        nil
      end

      def self.starts_with_chord?(text)
        CHORD_OCCURRENCE_REGEXP === text
      end

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
        dup.transpose!(count)
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
