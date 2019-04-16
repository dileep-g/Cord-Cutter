class SetTopBoxesController < ApplicationController
  before_action :set_set_top_box, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :show, :edit, :update, :destroy]

  # GET /set_top_boxes
  # GET /set_top_boxes.json
  def index
    @set_top_boxes = SetTopBox.order(:name).paginate(page: params[:page], per_page: 10)
  end

  # GET /set_top_boxes/1
  # GET /set_top_boxes/1.json
  def show
  end

  # GET /set_top_boxes/new
  def new
    @set_top_box = SetTopBox.new
  end

  # GET /set_top_boxes/1/edit
  def edit
  end

  # POST /set_top_boxes
  # POST /set_top_boxes.json
  def create
    @set_top_box = SetTopBox.new(set_top_box_params)
      if @set_top_box.save
        flash[:success] = "Create success!"
        redirect_to @set_top_box
      else
        render 'new'
      end
  end

  # PATCH/PUT /set_top_boxes/1
  # PATCH/PUT /set_top_boxes/1.json
  def update
    if @set_top_box.update(set_top_box_params)
      flash[:success] = "Update success!"
      redirect_to @set_top_box
    else
      render 'edit'
    end
  end

  # DELETE /set_top_boxes/1
  # DELETE /set_top_boxes/1.json
  def destroy
    @set_top_box.destroy
    flash[:success] = "Delete success"
    redirect_to set_top_boxes_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_set_top_box
      @set_top_box = SetTopBox.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def set_top_box_params
      params.require(:set_top_box).permit(:name, :description)
    end

    def admin_user
      unless admin?
        redirect_to root_path
      end
    end
end
