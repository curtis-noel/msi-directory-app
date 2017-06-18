class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @states = State.all
    @state_records = ["name", "abbreviation", "region_id"]
  end

  def show
    @state = State.find(params[:id])
    @state_row_data = [["Name:", @state.name], ["Abbreviation:", @state.abbreviation], ["Region ID:", @state.region_id]]
  end

  def new
    @state = State.new
    @state_fields = [[:name, "text_field", ""], [:abbreviation, "text_field", ""], [:region_id, "select", "options_for_select(get_region_list_with_selected, @selected_region_id)"]]
  end

  def create
    @state = State.new(state_params)
    @state_fields = [[:name, "text_field", ""], [:abbreviation, "text_field", ""], [:region_id, "select", "options_for_select(get_region_list_with_selected, @selected_region_id)"]]
    respond_to do |format|
      if @state.save
        format.html {redirect_to states_path, notice: 'State was successfully created.'}
        format.json {render :show, status: :created, location: @state}
      else
        format.html {render :new}
        format.json {render json: @state.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
    @selected_region_id = Region.find_by_id(@state.region_id).id
    @state_fields = [[:name, "text_field", ""], [:abbreviation, "text_field", ""], [:region_id, "select", "options_for_select(get_region_list_with_selected, @selected_region_id)"]]
  end

  def update
    respond_to do |format|
      if @state.update(state_params)
        format.html { redirect_to states_path, notice: "State was successfully updated."}
        format.json {render :show, status: :ok, location: @state}
      else
        format.html {render :edit}
        format.json {render json: @state.errors, status: :unprocessable_entity}
      end
    end

  end

  def destroy
    @state.destroy
    respond_to do |format|
      format.html {redirect_to states_url, notice: 'State was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  def set_state
    @state = State.find(params[:id])
  end

  def state_params
    params.require(:state).permit(:name, :abbreviation, :region_id)
  end
end
