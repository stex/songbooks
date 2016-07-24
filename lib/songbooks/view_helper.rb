module Songbooks
  module ViewHelper
    def self.javascripts
      Dir[Songbooks.root.join('public', 'javascripts', 'components', '**', '*.js').to_s].map do |filename|
        filename.sub(Songbooks.root.join('public', 'javascripts/').to_s, '')
      end
    end
  end
end
