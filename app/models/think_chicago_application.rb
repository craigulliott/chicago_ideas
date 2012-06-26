class ThinkChicagoApplication < ActiveRecord::Base
  
  include SearchSortPaginate
  
  has_attached_file :pdf, :path => "applications/think_chicago/pdfs/:id/:filename"
  has_attached_file :current_resume, :path => "applications/think_chicago/pdfs/:id/:filename"
  has_attached_file :unofficial_transcript, :path => "applications/think_chicago/pdfs/:id/:filename"
  has_attached_file :faculty_endorsement, :path => "applications/think_chicago/pdfs/:id/:filename"
  

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
  validates :undergraduate_institutions, :presence => true
  validates :field_major, :presence => true
  validates :dates_attended, :presence => true
  validates :gpa, :presence => true
  validates :degree_type, :presence => true
  validates :expected_graduation_date, :presence => true
  validates :employment_interests, :presence => true

  validates_attachment_presence :current_resume, :presence => true
  #validates_attachment_presence :unofficial_transcript, :presence => true
  #validates_attachment_presence :faculty_endorsement, :presence => true

  validates_format_of :current_resume_file_name, :with => %r{\.pdf$}i, :message => "file must be in .pdf format"
  validates_format_of :unofficial_transcript_file_name, :with => %r{\.pdf$}i, :message => "file must be in .pdf format"
  validates_format_of :faculty_endorsement_file_name, :with => %r{\.pdf$}i, :message => "file must be in .pdf format"
  
  validates_attachment_size :current_resume, :less_than => 4.megabytes
  validates_attachment_size :unofficial_transcript, :less_than => 4.megabytes
  validates_attachment_size :faculty_endorsement, :less_than => 4.megabytes
  
  
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
    else
      self.employment_interests = self.employment_interests.join(', ') # convert array to a string for saving
    end
  end
  
  def validate_employment_interests_extra
    if self.employment_interests.include?('Other') && self.employment_interests_extra.blank?
      self.errors.add('employment_interests_extra', 'can\'t be blank')
    end
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
