class ThinkChicagoApplication < ActiveRecord::Base
  
  include SearchSortPaginate
  
  has_attached_file :pdf, :path => "applications/think_chicago/pdfs/:id/:filename"
  has_attached_file :current_resume, :path => "applications/think_chicago/pdfs/:id/:filename"
  

  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :address1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip, :presence => true
  validates :phone, :presence => true
  validates :email, :presence => true
  validates :how_learn, :presence => true
  validates :institutions, :presence => true
  validates :field_major, :presence => true
  validates :dates_attended, :presence => true
  validates :gpa, :presence => true
  validates :degree_type, :presence => true
  validates :expected_graduation_date, :presence => true
  validates :employment_interests, :presence => true

  validates_attachment_presence :current_resume, :presence => true
  validates_format_of :current_resume_file_name, :with => %r{\.pdf$}i, :message => "file must be in .pdf format"
  validates_attachment_size :current_resume, :less_than => 4.megabytes
  
  validates :companies, :presence => true, :length => {
    :maximum   => 500,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  
  validates :honors_experience_activities, :presence => true, :length => {
    :maximum   => 500,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :qualities_attributes, :presence => true, :length => {
    :maximum   => 500,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  validates :hope_to_gain, :presence => true, :length => {
    :maximum   => 500,
    :tokenizer => lambda { |str| str.scan(/\b\S+\b/) },
    :too_long  => "must be less than %{count} words"
  }
  
  validate :validate_how_learn_extra
  validate :validate_employment_interests
  validate :validate_employment_interests_extra
  
  def validate_how_learn_extra
    if self.how_learn == 'Individual' && self.how_learn_extra.blank?
      self.errors.add('how_learn_extra', 'can\'t be blank')
    end
  end
  
  def validate_employment_interests
    self.employment_interests.reject! { |et| et.empty? }  # need to remove empty string
    if self.employment_interests.length < 2
      self.errors.add('employment_interests', 'please select at least two')
    end
  end
  
  def validate_employment_interests_extra
    if self.employment_interests.include?('Other') && self.employment_interests_extra.blank?
      self.errors.add('employment_interests_extra', 'can\'t be blank')
    end
  end
  
  before_create {|record|
    record.employment_interests = record.employment_interests.join(', ') # convert array to a string for saving
  }

  
  def self.csv_columns   # class method
    ['First Name', 'Middle Name', 'Last Name', 'Address 1', 'Address 2', 'City', 'State', 'Zip Code', 'Phone', 'Email', 'How did you learn about this program?', 'Please Specify', 'Institution(s)', 'Field or Major', 'Minor', 'Dates Attended', 'GPA', 'Type of Degree', 'Expected Graduation Date', 'Employment Interests', 'Please Specify', 'Chicago Companies', 'Academic Honors, Leadership Experience, etc', 'Qualities/Attributes', 'Hope to Gain from ThinkChicago', 'Resume']
  end
  
  def csv_attributes
    [first_name, middle_name, last_name, address1, address2, city, state, zip, phone, email, how_learn, how_learn_extra, institutions, field_major, minor, dates_attended, gpa, degree_type, expected_graduation_date, employment_interests, employment_interests_extra, companies, honors_experience_activities, qualities_attributes, hope_to_gain, current_resume.url]
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
