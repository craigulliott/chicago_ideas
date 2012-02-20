# generic
[Time, Date].map do |klass|
  klass::DATE_FORMATS[:ago] = lambda { |date| time_ago_in_words(date)+' ago' }
  klass::DATE_FORMATS[:wordy] = lambda { |date| date.strftime("%a %b %e, %Y") }
  klass::DATE_FORMATS[:long] = lambda { |date| date.strftime("%B %e, %Y %H:%M:%S") }
  klass::DATE_FORMATS[:time] = lambda { |date| date.strftime("%I:%M %p").downcase }
  
end
