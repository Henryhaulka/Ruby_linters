require_relative 'file'
class Checker
    attr_reader :check
    def initialize(file)
        @check = FileRead.new(file)
    end
end