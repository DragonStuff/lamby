require 'lamby/logger'
require 'rack'
require 'base64'
require 'lamby/version'
require 'lamby/config'
require 'lamby/rack'
require 'lamby/rack_alb'
require 'lamby/rack_rest'
require 'lamby/rack_http'
require 'lamby/debug'
require 'lamby/runner'
require 'lamby/handler'

if defined?(Rails)
  require 'rails/railtie'
  require 'lamby/railtie'
end

module Lamby

  extend self

  def cmd(event:, context:)
    handler(config.rack_app, event, context)
  ensure
    config.handled_proc.call(event, context)
  end

  def handler(app, event, context, options = {})
    Handler.call(app, event, context, options)
  end

  def config
    Lamby::Config.config
  end

  autoload :SsmParameterStore, 'lamby/ssm_parameter_store'

end
