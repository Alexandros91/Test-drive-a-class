require 'grammar_stats'

RSpec.describe GrammarStats do
  describe '#check' do
    context 'when there is no text' do
      it 'fails' do
        grammar_stats = GrammarStats.new
        expect { grammar_stats.check("") }.to raise_error "No text given!"
      end
    end
    context 'when text begins with a capital and ends with a punctuation mark' do
      it 'returns true' do
        grammar_stats = GrammarStats.new
        expect(grammar_stats.check("Hello!")).to eq true
      end
    end
    context 'when text begins with a capital but does not end with a punctuation mark' do
      it 'returns false' do
        grammar_stats = GrammarStats.new
        expect(grammar_stats.check("Hello")).to eq false
      end
    end
    context 'when text does not begin with a capital and ends with a punctuation mark' do
      it 'returns false' do
        grammar_stats = GrammarStats.new
        expect(grammar_stats.check("hello.")).to eq false
      end
    end
    context 'when text does not begin with a capital and does not end with a punctuation mark' do
      it 'returns false' do
        grammar_stats = GrammarStats.new
        expect(grammar_stats.check("hello")).to eq false
      end
    end
  end
  # describe '#percentage_good' do
  #   it 'returns as an integer the percentage of passing tests' do
  #     grammar_stats = GrammarStats.new
  #     expect(grammar_stats.check("I am a man.")).to eq true
  #     expect(grammar_stats.check("Hi there!")).to eq true
  #     expect(grammar_stats.check("Nice to meet you")).to eq false
  #     expect(grammar_stats.check("here you are...")).to eq false
  #     expect(grammar_stats.check("What's the score?")).to eq true
  #     expect(grammar_stats.check("he said the following:")).to eq false
  #     expect(grammar_stats.percentage_good).to eq 60
  #   end
  # end
end