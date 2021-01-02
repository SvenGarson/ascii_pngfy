# frozen_string_literal: true

desc('Run all tests')
task(:run_all_tests) do
  # Bundler if enforced programmatically
  system('ruby test/test_ascii_pngfy.rb')
end

desc('Run Rubocop on library')
task(:run_rubocop) do
  # need to enforce using bundle exec
  system('bundle exec rubocop')
end

desc('Generate RDoc documentation as TomDoc')
task(:generate_doc) do
  system('rdoc --markup=tomdoc ./lib')
end
