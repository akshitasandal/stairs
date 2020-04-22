require 'support/helpers/session_helpers'
require 'support/helpers/application_helpers'
RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
    config.include Features::ApplicationHelpers, type: :feature

end
