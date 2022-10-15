class DiaryEntry

  attr_reader :title, :contents

  def initialize(title, contents)
    @title = title
    @contents = contents
    @furthest_word_read = 0
  end

  def count_words
    words.length
  end

  def reading_time(wpm)
    raise "Reading speed must be above zero!" if wpm <= 0
    (count_words / wpm.to_f).ceil
  end

  def reading_chunk(wpm, minutes)
    raise "Reading speed must be above zero!" if wpm <= 0
    words_we_can_read = wpm * minutes
    start_from = @furthest_word_read
    end_at = @furthest_word_read + words_we_can_read
    words_list = words[start_from, end_at]
    if end_at >= count_words
      @furthest_word_read = 0
    else
      @furthest_word_read = end_at
    end
    words_list.join(" ")
  end

  private

  def words
    @word = @contents.split(" ")
  end
end
