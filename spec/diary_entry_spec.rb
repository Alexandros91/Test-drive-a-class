require 'diary_entry'

RSpec.describe DiaryEntry do
  describe '#title' do
    it 'returns the title of this instance of the class' do
      diary_entry = DiaryEntry.new("Nick's Diary", "Hello, Kate")
      expect(diary_entry.title).to eq "Nick's Diary"
    end
  end

  describe '#contents' do
    it 'returns the contents of this instance of the class' do
      diary_entry = DiaryEntry.new("Nick's Diary", "Hello, Kate")
      expect(diary_entry.contents).to eq "Hello, Kate"
    end
  end

  describe '#count_words' do
    context 'when we provide no contents' do
      it 'returns 0' do
        diary_entry = DiaryEntry.new("Nick's Diary", "")
        expect(diary_entry.count_words).to eq 0
      end
    end
    context 'when we provide some contents' do
      it 'returns the number of words in the contents' do
        diary_entry = DiaryEntry.new("Nick's Diary", "Hello Kate")
        expect(diary_entry.count_words).to eq 2
      end
    end
  end

  describe '#reading_time' do
    context 'when we provide no contents' do
      it 'returns 0' do
        diary_entry = DiaryEntry.new("Maria's Diary", "")
        expect(diary_entry.reading_time(150)).to eq 0
      end
    end
    context 'when we provide some contents' do
      it 'calculates the estimated reading time' do
        diary_entry = DiaryEntry.new("Maria's Diary", "one " * 600)
        expect(diary_entry.reading_time(180)).to eq 4
      end
    end
    context 'when the wpm is 0' do
      it 'fails' do
        diary_entry = DiaryEntry.new("Maria's Diary", "one " * 500)
        expect { diary_entry.reading_time(0) }.to raise_error "Reading speed must be above zero!"
      end
    end
  end

  describe '#reading_chunk' do
    context 'with a text readable within the given time' do
      it 'returns the full contents' do
        diary_entry = DiaryEntry.new("Nick's Diary", "one two three")
        chunk = diary_entry.reading_chunk(2, 2)
        expect(chunk).to eq "one two three"
      end
    end
    context 'when the wpm is 0' do
      it 'fails' do
        diary_entry = DiaryEntry.new("Maria's Diary", "one " * 500)
        expect { diary_entry.reading_chunk(0, 5) }.to raise_error "Reading speed must be above zero!"
      end
    end
    context 'with some contents readbale within the time' do
      it 'returns a readable chunk' do
        diary_entry = DiaryEntry.new("Nick's Diary", "one two three")
        chunk = diary_entry.reading_chunk(1, 2)
        expect(chunk).to eq "one two"
      end
      it 'returns the next chunk, next time we are asked' do
        diary_entry = DiaryEntry.new("Nick's Diary", "one two three")
        diary_entry.reading_chunk(1, 2)
        chunk = diary_entry.reading_chunk(1, 2)
        expect(chunk).to eq "three"
      end
      it 'restarts after reading the whole contents' do
        diary_entry = DiaryEntry.new("Nick's Diary", "one two three")
        diary_entry.reading_chunk(1, 2)
        diary_entry.reading_chunk(1, 2)
        chunk = diary_entry.reading_chunk(2, 1)
        expect(chunk).to eq "one two"
      end
      it 'restarts if it finishes exactly on the end' do
        diary_entry = DiaryEntry.new("Nick's Diary", "one two three")
        diary_entry.reading_chunk(1, 2)
        diary_entry.reading_chunk(1, 1)
        chunk = diary_entry.reading_chunk(2, 1)
        expect(chunk).to eq "one two"
      end
    end
  end
end