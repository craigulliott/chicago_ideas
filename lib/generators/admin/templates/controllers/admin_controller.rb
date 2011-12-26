<% module_namespacing do -%>
class Admin::<%= controller_class_name %>Controller < Admin::AdminController

  # COLLECTION ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  def index
    @<%= plural_table_name %> = <%= model_class_name %>.search_sort_paginate(params)
  end

  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------
  
  # standard CRUD functionality exists in the base AdminController

  # the detail page for this <%= singular_table_name %>
  def show
    @section_title = 'Detail'
    @<%= singular_table_name %> = <%= model_class_name %>.find(params[:id])
  end


  # MEMBER PAGES
  # ---------------------------------------------------------------------------------------------------------

  # notes associated with this <%= singular_table_name %>
  def notes
    @<%= singular_table_name %> = <%= model_class_name %>.find(params[:id])
    @notes = @<%= singular_table_name %>.notes.includes(:author).search_sort_paginate(params, :parent => @<%= singular_table_name %>)
  end


  # MEMBER ACTIONS
  # ---------------------------------------------------------------------------------------------------------

end
<% end -%>