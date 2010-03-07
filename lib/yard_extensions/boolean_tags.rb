module YARD
  module Tags
    class BooleanTag < Tag
      attr_accessor :value

      def initialize(tag_name, value)
        super(tag_name, nil)
        @value = ['true', '1'].include?(value.strip.downcase)
      end
    end
  end
end

module YARD
  module Tags
    class DefaultFactory
      def parse_tag_for_bool(tag_name, text, raw_text)
        BooleanTag.new(tag_name, text)
      end
    end
  end
end

YARD::Tags::Library.define_tag("Authenticated", :authenticated, :for_bool)
