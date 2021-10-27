require 'colorize'

class FileRead
  attr_reader :file, :file_line_counter, :error_message, :file_read

  def initialize(file)
    @file = file
    @error_message = ''
    begin
      @file_read = File.readlines(file)
      @file_line_counter = file_read.length
    rescue StandardError => e
      @error_message = "Ensure typed the right path or extension\n".colorize(:yellow) +
                       e.to_s.colorize(:red)
    end
  end
end
