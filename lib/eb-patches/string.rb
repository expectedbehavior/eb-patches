module Eb::Patches::String
  module DownUnder
    def down_under
      Eb.down_under(self)
    end
  end

  module Methodize
    def methodize
      Eb.down_under(self)
    end
  end

  module FilenameSanitize
    def filename_sanitize
      strip.tap do |name|
        # NOTE: File.basename doesn't work right with Windows paths on Unix
        # get only the filename, not the whole path
        name.gsub! /^.*(\\|\/)/, ''

        # Finally, replace all non alphanumeric, underscore or periods with underscore
        name.gsub! /[^\w\.\-]/, '_'
      end
    end
  end
end
