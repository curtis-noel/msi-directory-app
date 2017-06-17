module InstitutionsHelper
  def get_state_grouping_name(type, id)
    if !id.nil?
      if type == "state_id" || type == "State ID:"
        State.find_by_id(id).name
      else
        Grouping.find_by_id(id).name
      end
    end
  end

  def get_state_list
    @state_list = options_from_collection_for_select(State.all, :id, :name)
  end

  def get_state_list_with_selected
    State.all.map {|state| [state.name, state.id]}
    #@state_list_selected = options_for_select(get_state_list, id)
  end

  def get_grouping_list
    options_from_collection_for_select(Grouping.all, :id, :name)
  end

  def get_grouping_list_with_selected
    Grouping.all.map {|grouping| [grouping.name, grouping.id]}
  end
end
