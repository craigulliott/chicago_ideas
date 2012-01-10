module NestedFormHelper

  def link_to_remove_fields(name, form)
    form.hidden_field(:_destroy) + link_to_function(name, "if (confirm('Are you sure?')) Forms.remove_fields(this)", :class => "remove")
  end
  
  def link_to_add_fields(name, form, association, options = {})
    new_object = form.object.class.reflect_on_association(association).klass.new
    fields = form.semantic_fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render( options[:template] || association.to_s + "/fields.html.haml", :f => builder)
    end
    link_to_function(name, "Forms.add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => "add")
  end

end