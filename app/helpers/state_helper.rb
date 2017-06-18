module StateHelper
  def institution_count(state_id)
    State.find_by_id("#{state_id}").institutions.count
  end

  def get_region_name(region_id)
    Region.find_by_id("#{region_id}").name
  end

  def get_region_list
    @region_list = options_from_collection_for_select(Region.all, :id, :name)
  end

  def get_region_list_with_selected
    Region.all.map {|region| [region.name, region.id]}
  end
end
