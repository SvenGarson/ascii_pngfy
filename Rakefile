# frozen_string_literal: true

desc('Run all tests')
task(:test_all) do
  Dir['test/**/test_*.rb'].each do |test_filename|
    system("bundle exec ruby -Itest #{test_filename}")
  end
end

desc('Run Rubocop on library and tests')
task(:cop) do
  system('bundle exec rubocop')
end

desc('Run all tests and then Rubocop')
task(exam: %I[test_all cop]) do
  puts "\nRunning all test and running rubocop."
end
