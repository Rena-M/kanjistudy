 class Scraping

  def self.letter_urls
    # next_url = 0
    next_url = 25
    while true
      break if next_url > 2136
      get_letters("http://tangorin.com/dict.php?dict=kanji&s=joyo&offset=#{next_url}")
      # if next_url == 0
      #   next_url += 25
      # else
      #   next_url += 50
      # end
      next_url += 50
    end
  end

  def self.get_letters(link)
    agent = Mechanize.new
    page = agent.get(link)

    entries = page.search('.entry')
    entries.each do |entry|
      num = 0
      letter = Letter.where(letter: entry.at('.k-dt h2').inner_text).first_or_initialize
      letter.save
      words = entry.search('.k-meaning .k-lng-en b')
      words.each do |word|
        meaning = Meaning.create(meaning: word.inner_text, letter_id: letter.id)
      end
      en = entry.search('.k-readings .kana ruby rt')
      ja = entry.search('.k-readings .romaji ruby rt')
      ja.each do |ja|
        pronunciation = Pronunciation.create(ja: ja.inner_text, en: en[num].inner_text, letter_id: letter.id)
        num += 1
      end
    end
  end

end