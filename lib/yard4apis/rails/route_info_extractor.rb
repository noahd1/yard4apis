module Yard4Apis

  class RouteInfoExtractor

    def self.url(route)
      url = route.to_s.split(/\s+/)[1]
      if format = url.index('(')
        url = url[0..(format - 1)]
      end
      url.gsub(/\/$/, '')
    end

  end

end