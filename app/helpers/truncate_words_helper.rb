module TruncateWordsHelper

  def truncate_words(text, length = 250, end_string = ' ...')
    words = text.split()
    words[0..(length-1)].join(' ') + (words.length > length ? end_string : '')
  end
  
end