class ApiLogEntry
  # we store these objects in mongodb
  include Mongoid::Document
  include Mongoid::Timestamps
  #
  field :action, type: String
  field :host, type: String
  field :params, type: Hash
  #
  index :created_at
  index :action
  index :host
  
end
