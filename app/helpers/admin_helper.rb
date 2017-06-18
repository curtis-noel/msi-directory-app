module AdminHelper
  def get_region_name(region_id)
    region_name = Region.find_by_id(region_id)
  end

  def create_page_title(grouping, state, region, institutions, inst_id)
    if grouping && !grouping.nil?
      grouping.each do |g|
        return title = g.name
      end
    elsif state && !state.nil?
      state.each do |s|
        return title = s.name
      end
    elsif region && !region.nil?
      region.each do |r|
        return title = r.name
      end
    elsif institutions && !institutions.nil?
      institutions.each do |i|
        if inst_id == i.id
          return title = i.name
        end
      end
    end
  end
end
