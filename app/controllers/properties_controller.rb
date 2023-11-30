class PropertiesController < ApplicationController
  before_action :authenticate_user!, only: %i[ create update destroy ]
  before_action :set_property, only: %i[ show update destroy ]

  # GET /properties
  def index
    @properties = Property.all

    render json: @properties
  end

  # GET /properties/1
  def show
    render json: @property
  end

  # POST /properties
  def create
    @property = Property.new(property_params)

    if @property.save
      render json: {status: {code: 200, message: 'created successfully'}, data: @property}, status: :created, location: @property
    else
      render json: {status: {code: 422, errors: @property.errors}}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /properties/1
  def update
    if @property.update(property_params)
      render json: {status: {code: 200, message: 'created successfully'}, data: @property}
    else
      render json: {status: {code: 422, errors: @property.errors}}, status: :unprocessable_entity
    end
  end

  # DELETE /properties/1
  def destroy
    @property.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_property
    @property = Property.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def property_params
    params
      .require(:property)
      .permit(:name, :price, :location, :city, :description, :area, :number_of_rooms, :number_of_bedrooms, :furnished, :terrace, :basement, :renting)
  end
end
