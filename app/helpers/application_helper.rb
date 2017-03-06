module ApplicationHelper


  def cmp_editable_text(m, attr)
    return raw '<a href="#" id="'+attr+'" class="editable" data-url="/'+m.model_name.name.downcase.pluralize+'/'+m['id'].to_s+'" data-type="text" data-pk="'+m['id'].to_s+'">'+m[attr].to_s+'</a>'
  end

  def cmp_editable_tag(main_model, sub_model, select_field)
    '<a href="#" id="legal_company_id" class="tags" data-type="select" data-pk="<%= user.id %>" data-url="/users/<%= user.id %>" data-value="<%= user.legal_company_id %>" data-source="/companies"></a>'

  end


  def cmp_select(main_model, sub_model, select_field,options={})

    return select_tag "#{main_model.model_name.name.downcase}[#{sub_model.model_name.name.downcase}_id]",
                      options_from_collection_for_select(sub_model, "id",
                                                         raw(select_field)), class: "selectpicker", "data-live-search" => "true"

  end
end
