module ApplicationHelper

# navbar menu
  ACTIVE_RAILS = [
      "createapps",   # "create_app_comments",
      "amodels",      # "model_comments",
      "acontrollers" # "mycontroller_comments"
      ]
  def rails_active?(active_controller)
    "active" if ACTIVE_RAILS.include?(active_controller)
  end

  ACTIVE_RUBY = [
      ]
  def ruby_active?(active_controller)
    "active" if ACTIVE_RUBY.include?(active_controller)
  end

  ACTIVE_JS = [
    ]
  def js_active?(active_controller)
    "active" if ACTIVE_JS.include?(active_controller)
  end

  ACTIVE_TESTING = [
    ]
  def testing_active?(active_controller)
    "active" if ACTIVE_TESTING.include?(active_controller)
  end

    ACTIVE_FRONTEND = [
    ]
  def frontend_active?(active_controller)
    "active" if ACTIVE_FRONTEND.include?(active_controller)
  end

  ACTIVE_GEM = [
    ]
  def gem_active?(active_controller)
    "active" if ACTIVE_GEM.include?(active_controller)
  end

  ACTIVE_MISC = [
    ]
  def misc_active?(active_controller)
    "active" if ACTIVE_MISC.include?(active_controller)
  end


end
