RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.include Devise::Test::IntegrationHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :controller
end
