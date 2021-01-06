# frozen_string_literal: true

desc('Run all tests')
task(:test_all) do
  # Bundler is enforced programmatically
  # Run all text files in this directory
  Dir.glob(File.join('.', 'test', '**', 'test_*.rb')).each do |test_filename|
    system("ruby #{test_filename}")
  end
end

desc('Run current test suite')
task(:test_current) do
  # Bundler is enforced programmatically
  # system('ruby test/test_color_rgba.rb')
end

desc('Run Rubocop on library')
task(:cop) do
  # need to enforce using bundle exec
  system('bundle exec rubocop')
end
