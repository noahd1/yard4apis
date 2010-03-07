require 'yard4apis/rails/route_info_extractor'

module Yard4Apis

  class Routes

    def initialize(namespace, url_prefix)
      @namespace  = namespace
      @url_prefix = url_prefix
    end

    def [](service_name)
      api_routes_map[service_name]
    end

    def service_names
      api_routes_map.keys
    end

  protected

    def api_routes_map
      @api_routes_map ||= begin
        all_routes = ActionController::Routing::Routes.routes
        if @namespace
          api_routes = all_routes.select{ |r| r.segments[1].is_a?(ActionController::Routing::StaticSegment) && r.segments[1].value == @namespace }
        else
          api_routes = all_routes
        end
        names_with_routes = api_routes.map{|r| [extract_name(r), r]}.flatten
        Hash[*names_with_routes]
      end
    end

    def extract_name(route)
      url = RouteInfoExtractor.url(route)
      url = url.gsub(/^\/?#{@url_prefix}/, '')
      url = url[1..-1] if url.start_with?('/')
      url
    end

  end

end
