require 'yard'
require 'yard_extensions/parameter_tag'
require 'yard_extensions/formats_tag'
require 'yard_extensions/boolean_tags'
require 'yard_extensions/text_tags'

class ApiDocumentation

  API_BASE = "/api/v1/"

  def self.all_services
    ApiRoutes.instance.service_names.sort.map{ |service_name| self.new(service_name) }
  end
  
  def self.regenerate_yardoc
    YARD::Registry.load(Dir.glob('app/controllers/api/*').flatten, true)
  end

  attr_reader :service_name

  def initialize(service_name)
    @service_name = service_name
    raise WeplayErrors::ServiceNotFound.new(service_name) if route.nil?
  end

  def description
    yard_method_object.docstring
  end

  def http_method
    route.conditions[:method].to_s.upcase
  end
  
  def url
    Settings.web_root + API_BASE + service_name
  end
  
  def formats
    yard_method_object.tag(:formats).formats
  end

  def parameters
    yard_method_object.tags(:parameter)
  end

  def authenticated
    tag = yard_method_object.tag(:authenticated)
    tag.nil? ? true : tag.value
  end

  def returns
    yard_method_object.tag(:returns).try(:text)
  end

protected

  def route
    @route ||= ApiRoutes.instance[service_name]
  end

  def yard_method_object
    @yard_method_object ||= yard_registry.all(:method).find { |obj| obj.path == code_path }
  end

  def code_path
    controller = route.requirements[:controller]
    action = route.requirements[:action]
    "#{controller.classify.pluralize}Controller##{action}"
  end

  def yard_registry
    @yard_registry ||= begin
      YARD::Registry.load(Dir.glob('app/controllers/api/*').flatten, false)
      YARD::Registry
    end
  end
  
  class ApiRoutes
    require 'singleton'
    
    include Singleton

    def [](service_name)
      api_routes_map[service_name]
    end

    def service_names
      api_routes_map.keys
    end

    def api_routes_map
      @api_routes_map ||= begin
        all_routes = ActionController::Routing::Routes.routes
        api_routes = all_routes.select{ |r| r.segments[1].is_a?(ActionController::Routing::StaticSegment) && r.segments[1].value == 'api' }
        names_with_routes = api_routes.map{|r| [ServiceNameExtractor.extract(r), r]}.flatten
        Hash[*names_with_routes]
      end
    end

  end

  class ServiceNameExtractor
    def self.extract(route)
      match_result = /^(?:GET|POST)\s+#{API_BASE}(\S+)\(\.\:format\)\?\s+\{.*\}$/.match(route.to_s)
      match_result[1]
    end
  end
end
