require_relative '../yaml_converter'

module FixturesFilesHelpers
  def fixture_file(dir = 'fixtures', basename)
    File.join(__dir__, dir, basename)
  end
end

RSpec.configure do |config|
  include FixturesFilesHelpers

  config.formatter = :documentation
end
