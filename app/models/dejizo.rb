require 'net/http'
require 'uri'
require 'rexml/document'

class Dejizo
  attr_accessor :word, :id

  def initialize(word)
    @word = word
  end

  def request
    url = URI.parse(URI.escape("http://public.dejizo.jp/NetDicV09.asmx/SearchDicItemLite?Dic=EdictJE&Word=#{word}&Scope=HEADWORD&Match=STARTWITH&Merge=OR&Prof=XHTML&PageSize=1&PageIndex=0"))
    res = Net::HTTP.start(url.host, url.port){|http|
      http.get(url.path + "?" + url.query);
    }
    doc = REXML::Document.new(res.body)
    doc.elements.each('SearchDicItemResult/TitleList/DicItemTitle/') {|i|
      @id = i.elements['ItemID'].text
    }

    url = URI.parse(URI.escape("http://public.dejizo.jp/NetDicV09.asmx/GetDicItemLite?Dic=EdictJE&Item=#{id}&Loc=&Prof=XHTML"))
    res = Net::HTTP.start(url.host, url.port){|http|
      http.get(url.path + "?" + url.query);
    }
    doc = REXML::Document.new(res.body)
    doc.elements.each('GetDicItemResult/Head/div/') {|i|
      @pronunciation = i.elements['span'].text
    }
    doc.elements.each('GetDicItemResult/Body/div/div/') {|i|
      @meaning = i.elements['div'].text
    }
    return {pronunciation: @pronunciation, meaning: @meaning}
  end
end