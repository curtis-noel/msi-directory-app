class InstitutionsController < ApplicationController
  before_action :set_institution, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @institutions = Institution.all
    @institution_records = ["name", "contact_info", "email", "state_id", "grouping_id", "uscis"]
  end

  def show
    @institution = Institution.find(params[:id])
    @institution_row_data = [["Name:", @institution.name], ["Contact Info:", @institution.contact_info], ["Email:", @institution.email], ["State ID:", @institution.state_id], ["Grouping ID:", @institution.grouping_id], ["USCIS:", @institution.uscis]]
  end

  def new
    @institution = Institution.new
    @institution_fields = [[:name, "text_field", ""], [:contact_info, "text_area", ""], [:email, "text_field", ""], [:state_id, "select", "options_for_select(get_state_list_with_selected, @selected_state_id)"], [:grouping_id, "select", "options_for_select(get_grouping_list_with_selected, @selected_grouping_id)"], [:uscis, "check_box", ""]]
  end

  def create
    @institution = Institution.new(insitutions_params)
    @institution_fields = [[:name, "text_field", ""], [:contact_info, "text_area", ""], [:email, "text_field", ""], [:state_id, "select", "options_for_select(get_state_list_with_selected, @selected_state_id)"], [:grouping_id, "select", "options_for_select(get_grouping_list_with_selected, @selected_grouping_id)"], [:uscis, "check_box", ""]]
    respond_to do |format|
      if @institution.save
        format.html { redirect_to institutions_path, notice: 'Institution was successfully created.' }
        format.json { render :show, status: :created, location: @institution }
      else
        format.html { render :new }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @selected_state_id = State.find_by_id(@institution.state_id).id
    @selected_grouping_id = Grouping.find_by_id(@institution.grouping_id).id
    @institution_fields = [[:name, "text_field", ""], [:contact_info, "text_area", ""], [:email, "text_field", ""], [:state_id, "select", "options_for_select(get_state_list_with_selected, @selected_state_id)"], [:grouping_id, "select", "options_for_select(get_grouping_list_with_selected, @selected_grouping_id)"], [:uscis, "check_box", ""]]
  end

  def update
    respond_to do |format|
      if @institution.update(insitutions_params)
        format.html { redirect_to institutions_path, notice: "Institution was successfully updated." }
        format.json { render :show, status: :ok, location: @institution }
      else
        format.html { render :edit }
        format.json { render json: @institution.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @institution.destroy
    respond_to do |format|
      format.html { redirect_to institutions_url, notice: 'Institution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_institution
      @institution = Institution.find(params[:id])
    end

    def insitutions_params
      params.require(:institution).permit(:contact_info, :email, :state_id, :grouping_id, :uscis)
    end
end
