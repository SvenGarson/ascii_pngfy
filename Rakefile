# frozen_string_literal: true

desc('Run all tests')
task(:test_all) do
  # Run all text files in this directory
  Dir.glob(File.join('.', 'test', '**', 'test_*.rb')).each do |test_filename|
    system("bundle exec ruby #{test_filename}")
  end
end

desc('Run current test suite')
task(:test_current) do
  file_to_test = 'test/test_settings.rb'
  puts "\n=== Testing single file: #{file_to_test} ==="
  system("bundle exec ruby #{file_to_test}")
end

desc('Run Rubocop on library')
task(:cop) do
  system('bundle exec rubocop')
end
