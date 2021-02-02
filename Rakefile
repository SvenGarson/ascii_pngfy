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
  file_to_test = 'test/test_glyphs.rb'

  if file_to_test.empty?
    puts 'Nothing to test!'
  else
    puts "\n=== Testing single file: #{file_to_test} ==="
    system("bundle exec ruby #{file_to_test}")
  end
end

desc('Run Rubocop on library')
task(:cop) do
  system('bundle exec rubocop')
end

desc('Run all tests and rubocop before next TDD cycle')
task(exam: %I[test_all cop]) do
  puts "\nRunning all test and running rubocop."
end
