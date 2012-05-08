class BhsiApplication < ActiveRecord::Base
  
  include SearchSortPaginate

  belongs_to :user
  
  has_attached_file :pdf, :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :previous_budget, :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :press_clipping_1, :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :press_clipping_2, :path => "applications/bhsi/pdfs/:id/:filename"
  has_attached_file :press_clipping_3, :path => "applications/bhsi/pdfs/:id/:filename"
  
  

  # we have a polymorphic relationship with notes
  has_one :bhsi_longtext, :dependent => :destroy
  has_many :notes, :as => :asset
  
  accepts_nested_attributes_for :bhsi_longtext
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :address1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :country, :presence => true
  validates :phone_number, :presence => true
  validates :zipcode, :presence => true
  validates :email, :presence => true
  validates :gender, :presence => true
  validates :birthdate, :presence => true
  validates :title, :presence => true
  validates :social_venture_name, :presence => true
  validates :legal_structure, :presence => true
  validates :url, :presence => true
  validates :twitter_handle, :presence => true
  validates :video_url, :presence => true
  validates :applied_before, :presence => true
    validates :reference_1_name, :presence => true
  validates :reference_1_relationship, :presence => true
  validates :reference_1_phone, :presence => true
  validates :reference_1_email, :presence => true
  validates :reference_2_name, :presence => true
  validates :reference_2_relationship, :presence => true
  validates :reference_2_phone, :presence => true
  validates :reference_2_email, :presence => true
  validates :agreement_accepeted, :acceptance => {:accept => true}
  validates :user_id, :presence => true
  
  validates_attachment_presence :previous_budget, :presence => true
  validates_attachment_presence :press_clipping_1, :presence => true

  validates_attachment_content_type :previous_budget, :content_type => 'application/pdf'
  validates_attachment_content_type :press_clipping_1, :content_type => 'application/pdf'
  validates_attachment_content_type :press_clipping_2, :content_type => 'application/pdf'
  validates_attachment_content_type :press_clipping_3, :content_type => 'application/pdf'
  
  
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
