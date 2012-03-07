class BhsiApplication < ActiveRecord::Base
  
  include SearchSortPaginate

  belongs_to :user
  
  has_attached_file :pdf, :path => "applications/bhsi/pdfs/:id/:filename"
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :address1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :country, :presence => true
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
  validates :about_yourself, :presence => true
  validates :social_venture_description, :presence => true
  validates :venture_launched, :presence => true
  validates :number_people_affected, :presence => true
  validates :explain_number, :presence => true
  validates :three_standout_statistics, :presence => true
  validates :organizational_development, :presence => true
  validates :makes_social_innovation, :presence => true
  validates :inspiration, :presence => true
  validates :sustainability_model, :presence => true
  validates :improvements, :presence => true
  validates :distinguish_yourself, :presence => true
  validates :strong_midwest_connections_explained, :presence => true
  validates :reference_1_name, :presence => true
  validates :reference_1_relationship, :presence => true
  validates :reference_1_phone, :presence => true
  validates :reference_1_email, :presence => true
  validates :reference_2_name, :presence => true
  validates :reference_2_relationship, :presence => true
  validates :reference_2_phone, :presence => true
  validates :reference_2_email, :presence => true
  validates :press_clipping_1, :presence => true
  validates :press_clipping_2, :presence => true
  validates :press_clipping_3, :presence => true
  validates :agreement_accepeted, :presence => true
  validates :user_id, :presence => true
  
  
  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    case parent_model.class.name.underscore
    when 'foo'
    else
      [
        { :name => :search, :as => :string, :fields => [:first_name], :wildcard => :both },
        { :name => :created_at, :as => :datetimerange }, 
      ]
    end
  end
  
end
