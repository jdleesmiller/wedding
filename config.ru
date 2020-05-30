# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require_relative 'lib/rack/x_robots_tag'

use Rack::XRobotsTag
use Rack::CanonicalHost, ENV['CANONICAL_HOST'] if ENV['CANONICAL_HOST']
run Rails.application
