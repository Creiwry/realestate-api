class UserPropertiesController < ApplicationController
  before_action :set_user_property, only: %i[ show update destroy ]

  # GET /user_properties
  def index
    @user_properties = UserProperty.all

    render json: @user_properties
  end

  # GET /user_properties/1
  def show
    render json: @user_property
  end

  # POST /user_properties
  def create
    @user_property = UserProperty.new(user_property_params)

    if @user_property.save
      render json: @user_property, status: :created, location: @user_property
    else
      render json: @user_property.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_properties/1
  def update
    if @user_property.update(user_property_params)
      render json: @user_property
    else
      render json: @user_property.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_properties/1
  def destroy
    @user_property.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_property
    @user_property = UserProperty.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_property_params
    params.require(:user_property).permit(:user_id, :property_id)
  end
end
