require_relative '../lib/checker'
# 'Checker' class takes the preloaded file,
test = Checker.new(ARGV[0])
puts test.check.error_message if StandardError
