class GrammarStats

  def initialize

  end

  def check(text)
    punctuation = [".", "!", "?", ":", ";"]
    if text.empty?
      fail_message
    elsif text == text.capitalize && text.end_with?(*punctuation)
      true
    else
      false
    end
  end

  # def percentage_good
    
  # end


  private

  def fail_message
    fail "No text given!"
  end
end