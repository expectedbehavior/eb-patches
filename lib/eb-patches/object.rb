module Eb::Patches::Object
  module In
    def self.included(*)
      # Directly taken from ActiveSupport ~3.1
      Object.class_eval <<-END, __FILE__, __LINE__
        def in?(*args)
          if args.length > 1
            args.include? self
          else
            another_object = args.first
            if another_object.respond_to? :include?
              another_object.include? self
            else
              raise ArgumentError.new("The single parameter passed to #in? must respond to #include?")
            end
          end
        end
END
    end
  end
end
