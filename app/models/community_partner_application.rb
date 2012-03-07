class CommunityPartnerApplication < ActiveRecord::Base

  # my bone dry solution to search, sort and paginate
  include SearchSortPaginate

  belongs_to :user
  
  # we have a polymorphic relationship with notes
  has_many :notes, :as => :asset
  
  has_attached_file :pdf
  
  validates :name, :presence => true
  validates :address1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :country, :presence => true
  validates :user_id, :presence => true
  validates :contact_email, :presence => true
  validates :contact_name, :presence => true
  validates :contact_phone, :presence => true
  validates :why_partner, :presence => true
  validates :will_promote_ciw, :acceptance => {:accept => true}
  validates :encourage_promote_ciw, :acceptance => {:accept => true}
  validates :provide_insight_guidance, :acceptance => {:accept => true}
  
  # the hash representing this model that is returned by the api
  def api_attributes
    {
      :id => id.to_s,
      :type => self.class.name.downcase,
      :name => name,
      :description => description,
      :address1 => address1,
      :address2 => address2,
      :city => city,
      :state => state,
      :country => country,
      :how_align => how_align,
      :art_theme => art_theme,
      :education_theme => education_theme,
      :finance_theme => finance_theme,
      :health_theme => health_theme,
      :public_policy_theme => public_policy_theme,
      :social_theme => social_theme,
      :technology_theme => technology_theme,
      :other_theme => other_theme,
      :public_mailing_list => public_mailing_list,
      :user => user.api_attributes,
    }
  end

  # a DRY approach to searching lists of these models
  def self.search_fields parent_model=nil
    case parent_model.class.name.underscore
    when 'foo'
    else
      [
        { :name => :search, :as => :string, :fields => [:name], :wildcard => :both },
        { :name => :created_at, :as => :datetimerange }, 
      ]
    end
  end
  
end
