class LogEntry
  # we store these objects in mongodb
  include Mongoid::Document
  include Mongoid::Timestamps
  #
  field :action, type: String
  field :host, type: String
  field :user_agent, type: String
  field :referrer, type: String
  field :user_id, type: Integer
  field :params, type: Hash
  #
  index :created_at
  index :user_id
  index :action
  index :host
  
  def user
    User.find(user_id)
  end

  # return just the primary user agent part of the user agent string
  # i.e. for the user agent:
  # Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_4 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8K2 Safari/6533.18.5
  # only Mozilla/5.0 will be returned
  def user_agent_main
    user_agent.split(' ').first
  end
  
end
