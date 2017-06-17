class RegionsController < ApplicationController
  before_action :set_regions, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @regions = Region.all
    @region_records = ['name']
  end

  def show
    @region = Region.find(params[:id])
    @region_row_data = ["Name:", @region.name]
  end

  def new
    @region = Region.new
  end

  def create
    @region = Region.new(regions_params)
    respond_to do |format|
      if @region.save
        format.html {redirect_to regions_path, notice: 'Region was successfully created.'}
        format.json {render :show, status: :created, location: @region }
      else
        format.html {render :new}
        format.json {render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @region.update(regions_params)
        format.html {redirect_to regions_path, notice: 'Region was successfully updated.'}
        format.json {render :show, status: :ok, location: @region }
      else
        format.html {render :edit}
        format.json {render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @region.destroy
    respond_to do |format|
      format.html {redirect_to regions_url, notice: 'Region was successfully destroyed.' }
      format.json {head :no_content }
    end
  end

  private

  def set_regions
    @region = Region.find(params[:id])
  end

  def regions_params
    params.require(:region).permit(:name)
  end
end
