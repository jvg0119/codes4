class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    #false
    true # everyone has access to view
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    #false
    user.present? && user.editor? # only editor can perform create, update, & delete
  end

  def new?
    create?
  end

  def update?
    #false
    create?
  end

  def edit?
    #update?
    create?
  end

  def destroy?
    #false
    create?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
