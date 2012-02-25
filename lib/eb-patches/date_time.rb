module Eb::Patches::DateTime
  module Before
    def before?(timeable)
      Eb.timeable_before?(self, timeable)
    end

    def self.included(base)
      Eb.require_date_calculations
    end
  end

  module After
    def after?(timeable)
      Eb.timeable_after?(self, timeable)
    end

    def self.included(base)
      Eb.require_date_calculations
    end
  end
end
