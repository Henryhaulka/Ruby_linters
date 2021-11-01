require_relative 'file'
class Checker
  attr_reader :check, :lint_error, :keywords, :word

  def initialize(file)
    @check = FileRead.new(file)
    @lint_error = []
    @keywords = %w[begin case class do if module unless while until def when else elsif]
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

  def end_keyword_error
        open_keyword = []
        end_keyword = []
      check.file_read.each do |line|
        open_keyword << line.strip.split(" ")[0] if keywords.include?(line.strip.split(" ")[0])
        end_keyword << 'end' if  line.split(" ")[0] == 'end'
     end
     checker = open_keyword.size <=> end_keyword.size
      lint_error << "Syntax Error: unexpected/excess end" if checker == -1
        lint_error << "Syntax Error: Missing end" if checker == 1
  end
  def correct_indentation
    current_indentation = 0
    check.file_read.each_with_index do |line, index|
       expected_indentation  =  current_indentation
       next unless !line.strip.empty?
       current_indentation += 2 if keywords.include?(line.strip.split(' ')[0])
       current_indentation -= 2 if line.strip.split(' ')[0] == 'end'
       empty_space = line.match(/\s*/)
       def expectation(expected_indentation)
           if expected_indentation.zero?
               0
           else
              expected_indentation - 2
           end 
       end
       valid_indent = empty_space[0].size == expectation(expected_indentation)
       if line.strip.split(' ')[0] == 'end'
           lint_error << "line:#{index + 1} IndentationWidth: Use 2 spaces for indentation" if !valid_indent
         elsif empty_space[0].size != (expected_indentation)
           lint_error << "line:#{index + 1} IndentationWidth: Use 2 spaces for indentation"
      end
    end















  
#     msg = 'IndentationWidth: Use 2 spaces for indentation.'
#     cur_val = 0
    

#     @check.file_read.each_with_index do |str_val, indx|
#       strip_line = str_val.strip.split(' ')
#       exp_val = cur_val 
      
#       res_word = %w[class def if elsif until module unless begin case]

#       next unless !str_val.strip.empty?

#        cur_val += 2 if res_word.include?(strip_line.first) || strip_line.include?('do')
#        cur_val -= 2 if str_val.strip == 'end'

#       # next if str_val.strip.empty?

#       cur_val 
  

  
#     strip_line = str_val.strip.split(' ')
#     emp = str_val.match(/\s*/)
#     # end_chk = emp[0].size.eql?(exp_val.zero? ? 0 : exp_val - 2)
#     def doings(exp_val)
#     if exp_val.zero?
#          0
#     else
#        exp_val - 2
#     end
#     end 
#     # puts exp_val
#     end_chk = emp[0].size == doings(exp_val)
#     if str_val.strip.eql?('end') || strip_line.first == 'elsif' || strip_line.first == 'when'
#       lint_error << "line:#{indx + 1} #{msg}" if !end_chk
#     elsif !emp[0].size.eql?(exp_val)
#       lint_error << "line:#{indx + 1} #{msg}"
#     end
#   end
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
