require 'capybara/cucumber'
require 'rspec/expectations'
require 'byebug'
require 'awesome_print'
require 'selenium-webdriver'

Capybara.register_driver :selenium do |app|
  capabilities = Selenium::WebDriver::Remote::W3C::Capabilities.firefox(accept_insecure_certs: true)
  Capybara::Selenium::Driver.new(app, browser: :firefox, marionette: true, desired_capabilities: capabilities)
end

Capybara.default_driver = :selenium

# Set portal environment specific variables
module PortalEnv
  path = File.join(File.dirname(__FILE__), 'portal_env.yml')
  environment = YAML.safe_load(File.read(path))
  @portal = environment.fetch(ENV.fetch('TEST_ENV').downcase)

  def self.url
    @portal['url']
  end

  def self.cwa_provider_user
    @portal['cwa_provider_user']
  end

  def self.cwa_provider_user_password
    @portal['cwa_provider_user_password']
  end
end

module CWAProvider
  path = File.join(File.dirname(__FILE__), 'cwa_env.yml')
  environment = YAML.safe_load(File.read(path))
  @cwa = environment.fetch(ENV.fetch('TEST_ENV').downcase)

  def self.firmname
    @cwa['firmname']
  end

  def self.account_number
    @cwa['account_number']
  end

  def self.submission_period
    @cwa['submission_period']
  end

  def self.area_of_law
    @cwa['area_of_law']
  end

  def self.submission_ref
    @cwa['submission_ref']
  end
end

World(PortalEnv, CWAProvider)
