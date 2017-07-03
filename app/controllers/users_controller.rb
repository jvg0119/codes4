class UsersController < ApplicationController

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = "Your name was updated successfully!"
      redirect_back(fallback_location: root_path)
      #redirect_to :back
    end
  end

  private
  def user_params
    params.require(:user).permit(:name)
  end
end
