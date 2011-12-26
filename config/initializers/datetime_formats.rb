# generic
[Time, Date].map do |klass|
  klass::DATE_FORMATS[:ago] = lambda { |date| time_ago_in_words(date)+' ago' }
  klass::DATE_FORMATS[:wordy] = lambda { |date| date.strftime("%A %B %e, %Y") }
  klass::DATE_FORMATS[:long] = lambda { |date| date.strftime("%B %e, %Y %H:%M:%S") }
end
