class NoticesController < ApplicationController
  before_action :set_notice, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @notices = Notice.all
    @notices_records = ["content"]
  end

  def show
    @notices = Notice.find(params[:id])
    @notices_row_data = ["Content:", @notices.content]
  end

  def new
      @notice = Notice.new
  end

  def create
    @notice = Notice.new(notice_params)
    respond_to do |format|
      if @notice.save
        format.html {redirect_to notices_path, notice: 'Notice was successfully created.'}
        format.json {render :show, status: :created, location: @notice }
      else
        format.html {render :new}
        format.json {render json: @notice.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @notice.update(notice_params)
        format.html { redirect_to notices_path, notice: "Notice was successfully updated."}
        format.json {render :show, status: :ok, location: @notice}
      else
        format.html {render :edit}
        format.json {render json: @notice.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @notice.destroy
    respond_to do |format|
      format.html {redirect_to notices_url, notice: 'Notice was successfully destroyed'}
      format.json {head :no_content}
    end
  end

  private
    def set_notice
      @notice = Notice.find(params[:id])
    end

    def notice_params
      params.require(:notice).permit(:content)
    end
end
