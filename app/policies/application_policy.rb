
# BIG POLICE STATION, it's working for any model you have in your application
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user #CURRENT_USER, the person doing an action
    @record = record #RECORD, the instance of the model we're playing with
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope #if you want to be able to perform something on the clss level, we need a scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope #Class of your model, in our case it will be the Restaurant
    end

    def resolve
      scope.all
    end
  end
end
