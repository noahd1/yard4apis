require 'yard'
require 'yard_extensions/parameter_tag'
require 'yard_extensions/formats_tag'
require 'yard_extensions/boolean_tags'
require 'yard_extensions/text_tags'

require "yard4apis/rails/routes"
require "yard4apis/documentation"

module Yard4Apis

  class Services

    def initialize(config)
      @config = config
      if !@config[:reload].nil? && @config[:reload]
        reload
      else
        load
      end
    end

    def documentation(service_name)
      raise ServiceNotFound.new(service_name) if route(service_name).nil?
      Documentation.new(service_name, route(service_name), method_object(service_name))
    end

    def all
       routes.service_names.sort.map { |service_name| documentation(service_name) }
    end

  protected

    def route(service_name)
      routes[service_name]
    end

    def routes
      @routes ||= Routes.new(namespace, url_prefix)
    end

    def controllers_path
      if namespace
        "app/controllers/#{namespace}/*"
      else
        "app/controllers/*"
      end
    end

    def namespace
      @config[:namespace]
    end

    def url_prefix
      @config[:url_prefix]
    end

    def method_object(service_name)
      YARD::Registry[code_path(service_name)]
    end

    def code_path(service_name)
      controller = route(service_name).requirements[:controller]
      action = route(service_name).requirements[:action]
      "#{controller.classify.pluralize}Controller##{action}"
    end

    def reload
      load_yard_registry(true)
    end
    
    def load
      load_yard_registry(false)
    end
    
    def load_yard_registry(reload)
       YARD::Registry.load(Dir.glob(controllers_path).flatten, reload)
    end

  end


end