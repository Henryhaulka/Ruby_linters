require_relative 'file'
class Checker
  attr_reader :check, :lint_error, :keywords, :word

  def initialize(file)
    @check = FileRead.new(file)
    @lint_error = []
    @keywords = %w[begin case class do if module unless while until]
  end

  def trailing_space
    # remember that a line break is also a character
    @check.file_read.each_with_index do |line, index|
      if line[-2] == ' ' && line[-1].match(/\n/)
        # since index starts from 0
        lint_error << "line #{index + 1}:#{line[0..-2].size} Error: Trailing whitespace detected"
      end
    end
  end

  def line_error
    check.file_read.each_with_index do |line, index|
      error_def_space(line, index)
      error_in_def(line, index)
      error_in_class(line, index)
      error_end(line, index)
      excess_lines(line, index)
    end
  end

  def tag_error
        tag_error_check(/\[/,/\]/,'[',']', 'Square Bracket')
        tag_error_check(/\(/, /\)/, '(', ')', 'Parenthesis')
        tag_error_check(/\{/, /\}/, '{', '}', 'Curly Brackets')
  end
  
  private
  
  def tag_error_check(*params)
    check.file_read.each_with_index do |line, index|
    open_tag = []
    close_tag = []
    open_tag <<  params[0]  if line.match?(params[0])
    close_tag << params[1]  if line.match?(params[1])
    tag = open_tag <=> close_tag
    lint_error << "line #{index+1} Syntax Error: Unexpected #{ params[2]}, or Missing corresponding #{ params[3]} #{ params[-1]}" if tag == 1
    lint_error << "line #{index+1} Syntax Error: Unexpected #{ params[3]}, or Missing corresponding #{ params[2]} #{ params[-1]}" if tag == -1
  end
   end
  
  
  def error_in_def(line, index)
   return unless line.strip.split[0] == 'def' && check.file_read[index + 1].strip.empty?
      lint_error << "line #{index + 2}: Extra empty line detected"
  end

  def error_in_class(line, index)
    if line.strip.split[0] == 'class' && check.file_read[index + 1].strip.empty?
      lint_error << "line #{index + 2}: Extra empty line detected"
    end
  end

  def error_def_space(line, index)
    return unless line.strip.split[0] == 'def' &&  @check.file_read[index - 1].strip.split[0] == 'end'
      lint_error << "line:#{index + 1} An empty line is required between methods"
  end

  def error_end(line, index)
    return unless line.strip.split[0] == 'end' && check.file_read[index - 1].strip.empty?
    lint_error << "line #{index}: Extra empty line detected" 
  end

  def excess_lines(line, index)
    return unless line.strip.empty? &&  check.file_read[index - 1].strip.empty?
    lint_error << "line #{index + 1}: Extra empty line detected"
  end
end
