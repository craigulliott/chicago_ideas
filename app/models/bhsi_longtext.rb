class BhsiLongtext < ActiveRecord::Base
  
  include SearchSortPaginate

  belongs_to :BhsiApplication
  
  has_attached_file :pdf, :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :previous_budget, :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :press_clipping_1, :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :press_clipping_2, :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :press_clipping_3, :path => "applications/bhsi/pdfs/:id/:filename"
  
  validates :about_yourself, :presence => true, :length => {
    :maximum   => 1000,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :social_venture_description, :presence => true, :length => {
    :maximum   => 200,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :venture_launched, :presence => true
  validates :number_people_affected, :presence => true
  validates :explain_number, :presence => true, :length => {
    :maximum   => 300,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :three_standout_statistics, :presence => true, :length => {
    :maximum   => 200,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
    validates :strong_midwest_connections_explained, :presence => true, :length => {
    :maximum   => 200,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :organizational_development, :presence => true, :length => {
    :maximum   => 600,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :makes_social_innovation, :presence => true, :length => {
    :maximum   => 150,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :inspiration, :presence => true, :length => {
    :maximum   => 1000,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :sustainability_model, :presence => true, :length => {
    :maximum   => 1000,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :improvements, :presence => true, :length => {
    :maximum   => 1000,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :distinguish_yourself, :presence => true, :length => {
    :maximum   => 1000,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }

  
end