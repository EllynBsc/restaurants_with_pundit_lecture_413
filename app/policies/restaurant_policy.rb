class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope #the class scope and then the method resolve is actually the method that authorize all the instances of my clss Restaurant to be authorized
    def resolve
      scope.all #scope corresponds to the Restaurant class
    end
  end

  def index?
    true
  end

  # we want to be allow the user to create a restaurant
  def create?
    true
  end

  # def new?
  #   create?
  # end

  def show?
    true
  end

  def update?
   # current_user is able to edit the restaurant
   # if current_user.id == @restaurant.user.id
   #  true
   # else
   #  false
   # end

   # current_user.id == @restaurant.user.id ? true : false
    # current_user.id == @restaurant.user.id
    # @user.id == @record.user.id || @user.admin
    # @record is my restaurant instance
    # @user is my current_user
    is_an_owner_or_an_admin?
  end

  # def edit?
  #   update?
  # end

  def destroy?
    # @user.id == @record.user.id || @user.admin
    is_an_owner_or_an_admin?
  end

  private

  def is_an_owner_or_an_admin?
    @user.id == @record.user.id || @user.admin

  end

end
