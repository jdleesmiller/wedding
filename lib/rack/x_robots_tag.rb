# frozen_string_literal: true

module Rack
  #
  # Set X-Robots-Tag header to ask search engines not to index us.
  #
  class XRobotsTag
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      headers['X-Robots-Tag'] = 'none'
      [status, headers, response]
    end
  end
end
