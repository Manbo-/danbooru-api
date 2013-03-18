module Danbooru
  class API
    DEFAULT_FORMAT = :json

    class << self
      def get(site)
        yield new(site)
      end
    end

    def initialize(site)
      @site = site
    end

    attr_accessor :site

    def method_missing(name, *args)
      command, options = args
      raise ArgumentError unless command
      options = { } unless options
      format = options.delete(:format) || DEFAULT_FORMAT
      api_uri = [@site, "#{name}/", "#{command}.#{format}",
                 options_to_params(options)].inject(""){ |s, i| URI.join(s, i) }
      response = open(api_uri).read
      parse(response, format)
    end

    private

    def options_to_params(options)
      options.map{ |key, value| "#{key}=#{URI.escape(value.to_s)}" }.join("&").prepend("?")
    end

    def parse(response, format)
      case format
      when :xml
        REXML::Document.new(response)            
      else
        JSON.parse(response)
      end
    end
  end
end
