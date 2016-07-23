module Songbooks
  module Components
    class Metadata

      #----------------------------------------------------------------
      #                        CONSTANTS
      #----------------------------------------------------------------

      EMPTY_LINE_REGEXP = /\A\s*\r?\n/

      REGEXPS = {
          :title  => /\A@title\s*\r?\n?([^\n\r]+)/,
          :artist => /\A@artist\s*\r?\n?([^\n\r]+)/,
      }

      #----------------------------------------------------------------
      #                           Parsing
      #----------------------------------------------------------------

      #
      # Tries to parse metadata from the header of a given string.
      # It automatically deletes empty / whitespace lines and the parsed
      # content from the given string.
      #
      # Currently supported metadata/annotations
      #   @artist
      #   @title
      #
      # @param [String] text
      #   The string which possibly contains header data, usually a whole song file content
      #
      # @return [Songbooks::Components::Metadata]
      #   The parsed metadata with only the options set that could be parsed.
      #
      def self.munch_header(text)
        found   = true
        options = {}

        while found
          found = false

          if (match = text.match(EMPTY_LINE_REGEXP))
            text.slice!(0...match[0].length)
            found = true
          else
            REGEXPS.each do |name, regexp|
              if (match = text.match(regexp))
                options[name] = match[1]
                text.slice!(0...match[0].length)
                found = true
              end
            end
          end
        end

        Metadata.new(options)
      end

      def initialize(options = {})
        options.each do |k, v|
          instance_variable_set("@#{k}", v)
        end
      end

      attr_reader :artist, :title

    end
  end
end
