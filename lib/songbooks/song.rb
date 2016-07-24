require 'songbooks/components/section'
require 'songbooks/components/metadata'

module Songbooks
  class Song
    attr_reader :artist, :title, :identifier

    def initialize(content)
      parse_content(content)
    end

    def identifier
      @identifier ||= [artist, title].join('-').gsub(/[^a-zA-Z\-_0-9]/, '_')
    end

    def sections
      @sections ||= []
    end

    def longest_section_caption
      sections.map(&:name).sort_by(&:length).last
    end

    private

    def parse_content(content)
      current_section = Songbooks::Components::Section.new('Initial', true)

      meta            = Songbooks::Components::Metadata.munch_header(content)
      @artist, @title = meta.artist, meta.title

      content.lines.each do |line|
        if (information = Songbooks::Components::Section.parse_information(line))
          self.sections << current_section
          current_section = Songbooks::Components::Section.new(information[:name])
        else
          current_section.parse_line!(line)
        end
      end

      self.sections << current_section
    end

    def transpose!(count)
      return if count == 0
      sections.each { |section| section.transpose!(count) }
    end

    def transpose(count)
      dup.transpose!(count)
    end
  end
end
