require 'rails/generators/resource_helpers'
require 'rails/generators/active_record' 
require 'rails/generators/migration'

module Rails
  module Generators
    class AdminGenerator < NamedBase
      source_root File.expand_path('../templates', __FILE__)

      include ResourceHelpers

      argument :attributes, :type => :array, :default => [], :banner => "field[:type] field[:type]"

      def generate_controller
        template "controllers/admin_controller.rb", "app/controllers/admin/#{controller_file_name}_controller.rb"
      end

      def generate_migration
        template "migrations/create_model_migration.rb", "db/migrate/#{next_migration_number}_create_#{controller_file_name}.rb"
      end

      def generate_model
        template "models/model.rb", "app/models/#{file_name}.rb"
      end

      def generate_views
        template "views/index.html.haml", "app/views/admin/#{controller_file_name}/index.html.haml"
        template "views/show.html.haml", "app/views/admin/#{controller_file_name}/show.html.haml"
        template "views/notes.html.haml", "app/views/admin/#{controller_file_name}/notes.html.haml"
        
        template "views/_collection_controls.html.haml", "app/views/admin/#{controller_file_name}/_collection_controls.html.haml"
        template "views/_member_controls.html.haml", "app/views/admin/#{controller_file_name}/_member_controls.html.haml"
        
        template "views/_table.html.haml", "app/views/admin/#{controller_file_name}/_table.html.haml"
        template "views/_model.html.haml", "app/views/admin/#{controller_file_name}/_#{file_name}.html.haml"
        template "views/_fields.html.haml", "app/views/admin/#{controller_file_name}/_fields.html.haml"
      end

      def add_route
        inject_into_file "config/routes.rb", new_route, :after => "root :to => 'admin#index'\n"
      end

      def add_breadcrumb
        append_file "app/views/shared/_breadcrumbs_item.html.haml", new_breadcrumb
      end
      
      private 
      
        def new_route
          str = "\n"
          str += "    resources :#{plural_table_name} do\n"
          str += "      member do\n"
          str += "        # pages\n"
          str += "        get :notes\n"
          str += "        # methods\n" if has_deleted_at_attribute?
          str += "        get :undelete\n" if has_deleted_at_attribute?
          str += "        get :delete\n" if has_deleted_at_attribute?
          str += "      end\n"
          str += "      resources :notes, :only => [:new, :create]\n"
          str += "    end\n"
          str
        end
      
        def new_breadcrumb
          str = "\n"
          str += "- elsif base_model.kind_of? #{model_class_name}\n"
          str += "  .crumb\n"
          str += "    = link_to '#{controller_class_name}', admin_#{controller_file_name}_path\n"
          str += "  .crumb\n"
          str += "    = link_to base_model.name, admin_#{file_name}_path(base_model)\n" if has_name_attribute?
          str += "    = link_to '#{model_class_name}', admin_#{file_name}_path(base_model)\n" unless has_name_attribute?
          str
        end

        def model_class_name
          file_name.camelize
        end
        
        def has_name_attribute?
          attribute_exits? :name
        end
        
        def has_deleted_at_attribute?
          attribute_exits? :deleted_at
        end
        
        # are any of the attributes for a file?
        def has_a_file_attribute?
          attributes.each do |attribute|
            return true if attribute.type == :file
          end
          return false
        end
        
        # does this new model have a specific attribute?
        def attribute_exits? attribute_name
          attributes.each do |attribute|
            return true if attribute.name.to_sym == attribute_name
          end
          return false
        end
        
        def next_migration_number
          ActiveRecord::Generators::Base.next_migration_number('db/migrate')
        end
        
    end
  end
end
