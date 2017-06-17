class PagesController < ApplicationController
  # Pull in helper functions that are avail to all methods within this Controller
  include PageSharedFunctions

  def home
    get_filter_options
    @notice = Notice.order("updated_at DESC").limit(1)
  end

  def list
    get_filter_options

    @region_id = params[:region_id].to_i || 0
    @state_id = params[:state_id].to_i || 0
    @grouping_id = params[:grouping_id].to_i || 0
    @inst_id = params[:inst_id].to_i || 0
    @state_abbrev = params[:state_abbrev] || ''

    # Show Region
    if @region_id > 0

      @region = Region.where("id = ?", @region_id).limit(1)

      # @insts = Institution.includes(:grouping).joins(:state).where("region_id = ?", @region_id).order("uscis, name").all
      @insts = Institution.find_by_sql ["
        SELECT a.*, b.name AS state_name, c.name AS group_name, d.name AS region_name
        FROM institutions a
          INNER JOIN states b ON a.state_id = b.id
          INNER JOIN regions d ON b.region_id = d.id AND
            d.id = ?
          LEFT OUTER JOIN groupings c ON a.grouping_id = c.id
        ORDER BY a.uscis, c.name, b.name, a.name
      ", @region_id]

    # Show State
    elsif @state_id > 0 || @state_abbrev.strip.length > 0

      if @state_id > 0
        @state = State.where("id = ?", @state_id).limit(1)

        # @insts = Institution.includes(:grouping).joins(:state).where("state_id = ?", @state_id).order("uscis, name").all
        @insts = Institution.find_by_sql ["
          SELECT a.*, b.name AS state_name, c.name AS group_name, d.name AS region_name
          FROM institutions a
            INNER JOIN states b ON a.state_id = b.id AND
              b.id = ?
            LEFT OUTER JOIN regions d ON b.region_id = d.id
            LEFT OUTER JOIN groupings c ON a.grouping_id = c.id
          ORDER BY a.uscis, c.name, a.name
        ", @state_id]

      else
        @state = State.where("abbreviation = ?", @state_abbrev).limit(1)

        # @insts = Institution.includes(:grouping).joins(:state).where("abbreviation = ?", @state_abbrev).order("uscis, name").all
        @insts = Institution.find_by_sql ["
          SELECT a.*, b.name AS state_name, c.name AS group_name, d.name AS region_name
          FROM institutions a
            INNER JOIN states b ON a.state_id = b.id AND
              b.abbreviation = ?
            LEFT OUTER JOIN regions d ON b.region_id = d.id
            LEFT OUTER JOIN groupings c ON a.grouping_id = c.id
          ORDER BY a.uscis, c.name, a.name
        ", @state_abbrev]
      end

    # Show Grouping
    elsif @grouping_id > 0

      @grouping = Grouping.where("id = ?", @grouping_id).limit(1)

      # @insts = Institution.includes(:state).joins(:grouping).where("grouping_id = ?", @grouping_id).order("uscis, name").all
      @insts = Institution.find_by_sql ["
        SELECT a.*, b.name AS state_name, c.name AS group_name, d.name AS region_name
        FROM institutions a
          INNER JOIN states b ON a.state_id = b.id
          INNER JOIN regions d ON b.region_id = d.id
          INNER JOIN groupings c ON a.grouping_id = c.id AND
            c.id = ?
        ORDER BY a.uscis, d.name, b.name, a.name
      ", @grouping_id]

    # Show Institution
    elsif @inst_id > 0
      # @insts = Institution.includes(:state, :grouping).where("id = ?", @inst_id).order("uscis, name").all
      @insts = Institution.find_by_sql ["
        SELECT a.*, b.name AS state_name, c.name AS group_name, d.name AS region_name
        FROM institutions a
          INNER JOIN states b ON a.state_id = b.id
          INNER JOIN regions d ON b.region_id = d.id
          LEFT OUTER JOIN groupings c ON a.grouping_id = c.id
        WHERE a.id = ?
        LIMIT 1
      ", @inst_id]

    else
      redirect_to root_path
    end

    @uscis_title_shown = false
    @group_title = ""
    @region_title = ""
    @state_title = ""
  end

  private
    def get_filter_options
      @groupings = Grouping.find_by_sql "SELECT COUNT(b.id) AS total, a.* FROM groupings a INNER JOIN institutions b ON a.id = b.grouping_id GROUP BY a.id ORDER BY a.name"
      @regions = Region.find_by_sql "SELECT COUNT(c.id) AS total, a.* FROM regions a INNER JOIN states b ON a.id = b.region_id INNER JOIN institutions c ON b.id = c.state_id GROUP BY a.id ORDER BY a.name"
      #@states = State.find_by_sql "SELECT COUNT(b.id) AS total, a.* FROM states a INNER JOIN institutions b ON a.id = b.state_id GROUP BY a.id ORDER BY a.name"
      @states = State.find_by_sql "SELECT a.* FROM states a GROUP BY a.id ORDER BY a.name"
      @institutions = Institution.includes(:state).order("name").all
    end

end
