class EdisonTalksApplication < ActiveRecord::Base
  
  include SearchSortPaginate
  
  has_attached_file :pdf, :path => "applications/edison_talks/pdfs/:id/:filename"
  

  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :name, :presence => true
  validates :organization, :presence => true
  validates :email, :presence => true
  validates :phone, :presence => true
      
  validates :inspiration_1, :presence => true
  validates :inspiration_2, :presence => true
  validates :inspiration_3, :presence => true
  
  
  validates :passions, :presence => true, :length => {
    :maximum   => 200,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :why_come, :presence => true, :length => {
    :maximum   => 200,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :recommendation, :presence => true, :length => {
    :maximum   => 200,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :invention, :presence => true, :length => {
    :maximum   => 200,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }


  def self.csv_columns   # class method
    ['Name', 'Organization', 'Title', 'Email', 'Phone', 'What are you passionate about?', 'Why do you want to come to the Edison Talks?', 'Recommended Speaker', 'Coolest/Most Innovative Invention', 'Inspiration 1', 'Inspiration 2', 'Inspiration 3', 'Final Thoughts']
  end
  
  def csv_attributes
    [name, organization, title, email, phone, passions, why_come, recommendation, invention, inspiration_1, inspiration_2, inspiration_3, comments]
  end
  
  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    case parent_model.class.name.underscore
    when 'foo'
    else
      [
        { :name => :search, :as => :string, :fields => [:first_name], :wildcard => :both },
        { :name => :created_at, :as => :datetimerange }
      ]
    end
  end
  
end
