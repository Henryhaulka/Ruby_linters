require_relative '../lib/checker'
# rubocop:disable Layout/LineLength
RSpec.describe Checker do
  # rubocop:enable Layout/LineLength
  subject { Checker.new('./lib/test.rb') }
  describe '#trailing_space' do
    it '#checks for trailing spaces' do
      subject.trailing_space
      expect(subject.lint_error[0]).to eql('line 2:17 Error: Trailing whitespace detected')
    end
  end

  context '#line_error' do
    it 'checks for Empty lines' do
      subject.line_error
      expect(subject.lint_error[0]).to eql('line 8: Extra empty line detected')
    end
  end

  context '#tag_error' do
    it 'checks excess or missing tag errors' do
      subject.tag_error
      # rubocop:disable Layout/LineLength
      expect(subject.lint_error[0]).to eql('line 3 Syntax Error: Unexpected ], or Missing corresponding [ Square Bracket')
    end
  end
  # rubocop:enable Layout/LineLength

  context '#end_keyword_error' do
    it "checks excess or missing 'end'" do
      subject.end_keyword_error
      expect(subject.lint_error[0]).to eql('Syntax Error: unexpected/excess end')
    end
  end

  context '#correct_indentation' do
    it 'checks excess or missing indentations' do
      subject.correct_indentation
      expect(subject.lint_error[0]).to eql('line:16 IndentationWidth: Use 2 spaces for indentation')
    end
  end
end
