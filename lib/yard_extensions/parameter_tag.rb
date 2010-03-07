module YARD
  module Tags
    class ParameterTag < Tag
      attr_accessor :parameter, :required

      def initialize(tag_name, parameter_name, required, description = nil)
        super(tag_name, description)
        @parameter = parameter_name
        @required = required
      end
      
      def description
        text
      end
      
    end
  end
end

module YARD
  module Tags
    class DefaultFactory
      def parse_tag_with_raw_text_for_parameter_tag(tag_name, text, raw_text)
        Regexp.new(/([^\s]+) (?:\((optional|required)\) )?(.*)/).match(raw_text)
        required = $2 == "required"
        ParameterTag.new(tag_name, $1, required, $3)
      end
    end
  end
end

YARD::Tags::Library.define_tag("Request Parameter", :parameter, :with_raw_text_for_parameter_tag)