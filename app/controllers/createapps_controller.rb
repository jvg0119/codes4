class CreateappsController < ApplicationController
  layout "arail"
  before_action :set_createapp, only: [:show, :edit, :update, :destroy]

  def index
    @createapps = Arail::Createapp.all
    authorize @createapps
  end

  def show
    #@createapp = Arail::Createapp.find(params[:id])
    @comments = @createapp.arail_comments
    @images = @createapp.arail_images
  end

  def edit
    authorize @createapp
  end

  def update
    authorize @createapp
    #if @createapp.update_attributes(createapp_params) # OK also
    if @createapp.update(createapp_params)
      flash[:success] = "Your 'createapp' note was updated successfully!"
      redirect_to(createapp_path(@createapp))
    else
      flash[:error] = "There was an error updating your 'createapp' note. Please try again."
      render :edit
    end
  end

  def new
    @createapp = Arail::Createapp.new
    #@comment = Arail::Comment.new
    #@image = Arail::Image.new
    authorize @createapp
  end

  def create
    @createapp = Arail::Createapp.new(createapp_params)
    authorize @createapp
    if @createapp.save
      flash[:success] = "Your 'createapp' note was created successfully!"
      #redirect_to(createapp_path(@createapp)) # shortcut did not work @createapp
      redirect_to createapp_path(@createapp)
    else
      flash[:error] = "There was an error saving your 'createapp' note. Please try again."
      render :new
    end
  end

  def destroy
    authorize @createapp
    @createapp.destroy
    flash[:notice] = "Your 'createapp' note was deleted."
    redirect_to(createapps_url)
  end

  private
  def set_createapp
    @createapp = Arail::Createapp.find(params[:id])
  end
  
  def createapp_params
    params.require(:arail_createapp).permit(:title, :body,
      arail_comments_attributes: [:id, :body, :_destroy],
      arail_images_attributes: [:id, :title, :size, :content, :_destroy])
  end

end
