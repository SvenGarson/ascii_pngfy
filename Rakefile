# frozen_string_literal: true

desc('Run all tests')
task(:test) do
  # Bundler if enforced programmatically
  # Run all text files in this directory
  Dir.glob(File.join('.', 'test', 'test_*.rb')).each do |test_filename|
    system("ruby #{test_filename}")
  end
end

desc('Run Rubocop on library')
task(:cop) do
  # need to enforce using bundle exec
  system('bundle exec rubocop')
end
