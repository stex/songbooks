require_relative 'chord'

module Songbooks
  module Components
    class Literal

      #----------------------------------------------------------------
      #                           Parsing
      #----------------------------------------------------------------

      #
      # Tries to munch a literal from the given string.
      # If the string starts with a valid literal, it is automatically
      # removed from the string
      #
      # @return [Songbooks::Components::Literal, NilClass] a Literal containing the munched
      #   text or +nil+ if the string didn't start with a literal
      #
      def self.munch_literal(text)
        result = ''

        until text.length.zero?
          # Munch leading whitespace
          if text =~ /^(\s+)/
            result << text.slice!(0...$1.length)
          end

          # If we reached a chord, we may not munch any further
          break if Chord.starts_with_chord?(text)

          # Munch non-chord, non whitespace characters
          if text =~/^([^\s+])/
            result << text.slice!(0...$1.length)
          end
        end

        result == '' ? nil : Literal.new(result)
      end

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
end
