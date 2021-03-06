# frozen_string_literal: true

module TShield
  # Control version of gem
  class Version
    MAJOR = 0
    MINOR = 11
    PATCH = 20
    PRE = 0

    class << self
      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end
    end
  end
end
