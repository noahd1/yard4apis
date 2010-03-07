require 'yard4apis/rails/route_info_extractor'

module Yard4Apis

  class Documentation

    attr_reader :service_name

    def initialize(service_name, route, method_object)
      @service_name  = service_name
      @route         = route
      @method_object = method_object
    end

    def description
      @method_object.docstring
    end

    def http_method
      @route.conditions[:method].to_s.upcase
    end

    def url
      @url ||= RouteInfoExtractor.url(@route)
    end

    def formats
      @method_object.tag(:formats).formats
    end

    def parameters
      @method_object.tags(:parameter)
    end

    def authenticated
      tag = @method_object.tag(:authenticated)
      tag.nil? ? true : tag.value
    end

    def returns
      @method_object.tag(:returns).try(:text)
    end

  end


end
