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
  system('bundle exec ruby test/test_pngfyer.rb')
end

desc('Run Rubocop on library')
task(:cop) do
  system('bundle exec rubocop')
end
