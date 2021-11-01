require_relative '../lib/checker'
# 'Checker' class takes the preloaded file,
test = Checker.new(ARGV[0])
puts 'Welcome to Ruby linters, Designed by Henryhaulka'.colorize(:light_green)
puts test.check.error_message if StandardError
test.trailing_space
test.line_error
test.tag_error
test.end_keyword_error
test.correct_indentation

if test.lint_error.empty?
  puts "File inspected #{ARGV.size}: #{(ARGV[0]).colorize(:blue)} :#{'No offense'.colorize(:green)} detected"
else
  # puts "#{test.check.file.colorize(:light_blue)}: #{test.lint_error.join.colorize(:red)}"
  test.lint_error.uniq.each do |error|
    puts "#{test.check.file.colorize(:light_blue)}: #{error.colorize(:red)}"
  end
end
p test.check.file_line_counter
