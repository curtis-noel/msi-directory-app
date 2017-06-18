# Grouping of records
class GroupingsController < ApplicationController
  before_action :set_grouping, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @groupings = Grouping.all
    @grouping_records = ["name"]
  end

  def show
    @grouping = Grouping.find(params[:id])
    @grouping_row_data = ["Name:", @grouping.name]
  end

  def new
    @grouping = Grouping.new
  end

  def create
    @grouping = Grouping.new(grouping_params)
    respond_to do |format|
      if @grouping.save
        format.html {redirect_to groupings_path, notice: 'Grouping was successfully created.'}
        format.json {render :show, status: :created, location: @grouping}
      else
        format.html {render :new}
        format.json {render json: @grouping.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @grouping.update(grouping_params)
        format.html { redirect_to groupings_path, notice: "Grouping was successfully updated."}
        format.json { render :show, status: :ok, location: @grouping }
      else
        format.html {render :edit}
        format.json {render json: @grouping.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @grouping.destroy
    respond_to do |format|
      format.html {redirect_to groupings_path, notice: 'Grouping was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  def set_grouping
    @grouping = Grouping.find(params[:id])
  end
  def grouping_params
    params.require(:grouping).permit(:name)
  end
end
