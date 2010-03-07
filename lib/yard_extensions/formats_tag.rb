module YARD
  module Tags
    class FormatsTag < Tag
      attr_accessor :formats

      def initialize(tag_name, formats)
        super(tag_name, nil)
        @formats = formats
      end
      
      def formats
        @formats
      end
      
    end
  end
end

module YARD
  module Tags
    class DefaultFactory
      def parse_tag_with_raw_text_for_formats_tag(tag_name, text, raw_text)
        FormatsTag.new(tag_name, raw_text.split(/,\s*/))
      end
    end
  end
end

YARD::Tags::Library.define_tag("Formats", :formats, :with_raw_text_for_formats_tag)