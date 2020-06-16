    # current_user #helper method that is the same as doing
    # User.find(user_id: user_currenthly_logged_in)
class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  def index
    # policy_scope
    @restaurants = policy_scope(Restaurant)
    # @restaurants = Restaurant.all
  end

  # GET /restaurants/1
  def show
    # .show?(@restaurant)
    # @restaurant = Restaurant.find(params[:id])
    authorize(@restaurant)
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
    # call the new policy method .new? from my restaurant policy
    # calling the .new? from the restaurant policy to check if able to perform this action
    # new?(@restaurant)
    authorize(@restaurant)
    # authorize is calling the new? and passing the restaurant instance we want to authorize
  end

  # GET /restaurants/1/edit
  def edit
    # @restaurant = Restaurant.find(params[:id])
    authorize(@restaurant)
    # this is calling the edit? of the restaurant policy
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id
    authorize(@restaurant) #this will call the create? inside of the restaurant policy and chck if you're allowed to create a restaurant
    if @restaurant.save
      redirect_to restaurant_path(@restaurant), notice: 'Restaurant was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /restaurants/1
  def update
    # @restaurant = Restaurant.find(params[:id])
    authorize(@restaurant)
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: 'Restaurant was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /restaurants/1
  def destroy
    # @restaurant = Restaurant.find(params[:id])
    authorize(@restaurant)
    @restaurant.destroy
    redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def restaurant_params
      params.require(:restaurant).permit(:name)
    end
end
