class Create<%= controller_class_name %> < ActiveRecord::Migration
  def change
    create_table :<%= plural_table_name %> do |t|
<% attributes.each do |attribute| -%>
<% if attribute.type == :file %>
      # allow a sponsor to have a logo
      t.string :logo_file_name, :null => true
      t.string :logo_content_type, :null => true
      t.integer :logo_file_size, :null => true
      t.datetime :logo_updated_at, :null => true
      
<% else -%>
      t.<%= attribute.type %> :<%= attribute.name %>, :null => true
<% end -%>
<% end -%>

      t.timestamps
    end
<% attributes.each do |attribute| -%><% next unless attribute.name[-3,3] == '_id' %>
    add_index :<%= plural_table_name %>, :<%=  attribute.name %>
    add_foreign_key :<%= plural_table_name %>, :<%=  attribute.name[0..-4].pluralize %>
<% end -%>

  end
end
