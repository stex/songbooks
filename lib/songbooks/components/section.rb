require 'songbooks/components/chord'
require 'songbooks/components/literal'

module Songbooks
  module Components
    class Section

      #----------------------------------------------------------------
      #                           CONSTANTS
      #----------------------------------------------------------------

      REGEXP = /^##\s*(.*)$/.freeze

      #----------------------------------------------------------------
      #                            Parsing
      #----------------------------------------------------------------

      #
      # Tries to parse the given text line as a section name identifier
      #
      # @return [Hash, NilClass] the parsed information or +nil+ if the given row
      #   is not a valid section row
      #
      def self.parse_information(content)
        if content =~ REGEXP
          return {name: $1}
        end
        nil
      end

      def initialize(name, initial = false)
        @name          = name
        @content_lines = []
        @initial       = initial
      end

      #
      # Parses the given line (chords and literals) and adds it to this section
      #
      def parse_line!(_line)
        line = _line.dup.rstrip
        line_components = []

        until line.length.zero?
          component = Songbooks::Components::Chord.munch_chord(line)
          component ||= Songbooks::Components::Literal.munch_literal(line)
          line_components << component
        end

        add_line(line_components)
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

      def transpose!(amount)
        lines.flatten.each do |component|
          next unless component.is_a?(Songbooks::Components::Chord)
          component.transpose!(amount)
        end
      end
    end
  end
end
