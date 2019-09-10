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
    redirect_to new_session_url unless ensure_mod
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub.id)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def ensure_mod
    redirect_to subs_url unless current_user == Sub.find(params[:id]).user
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end