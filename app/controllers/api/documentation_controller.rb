class Api::DocumentationController < Api::ApiController
  
  # render the documentation
  def documentation
    @api_documentation = YAML.load_file(Rails.root.to_s+"/config/api_documentation.yml")
    @api_errors = YAML.load_file(Rails.root.to_s+"/config/locales/en.yml")['en']['api']['errors']
  end
    
end
