module Songbooks
  module ViewHelper
    def self.javascripts
      Dir[Songbooks.public_dir.join('javascripts', 'components', '**', '*.js').to_s].map do |filename|
        filename.sub(Songbooks.public_dir.join('javascripts/').to_s, '')
      end
    end
  end
end
