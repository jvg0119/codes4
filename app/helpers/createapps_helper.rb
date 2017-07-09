module CreateappsHelper

  def createapp_active?(active_controller)
    "active" if ["createapps"].include?(active_controller)
  end

  def amodel_active?(active_controller)
    "active" if [""].include?(active_controller)
  end

  def acontroller_active?(active_controller)
    "active" if [""].include?(active_controller)
  end

end
