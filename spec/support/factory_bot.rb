require "factory_bot"
require_relative "time_slots"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end

FactoryBot::SyntaxRunner.include Support::TimeSlots
