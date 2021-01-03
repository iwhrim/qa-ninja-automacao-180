require_relative 'routes/signup'
require_relative 'routes/sessions'
require_relative 'routes/equipos'
require_relative 'libs/mongo'
require_relative 'helpers'
require "digest/md5"

def to_md5(password)
  Digest::MD5.hexdigest(password)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    users = [
      { name: "QA Ninja", email: "qaninja@gmail.com", password: to_md5("qaninja") },
      { name: "Another Ninja", email: "another_ninja@gmail.com", password: to_md5("P4s$W0rD") },
    ]

    MongoDB.new.drop_database
    MongoDB.new.insert_users(users)
  end
end

