class SubsController < ApplicationController
  before_action :ensure_mod, only: [:edit, :update]

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub.id)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    @sub.user_id = current_user.id
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub.id)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def ensure_mod
    
    redirect_to subs_url unless current_user.id == Sub.find(params[:id]).user.id
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end