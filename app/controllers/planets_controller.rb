class PlanetsController < ApplicationController

  def index
    render json: Planet.all
  end
  
  def show
    planet = find_planet
    render json: planet, serializer: ScientistPlanetSerializer
  end

  def create
    planet = Planet.create!(planet_params)
    render json: planet, status: :created
  end

  private
  
    def planet_params
      params.permit(:name, :age)
    end
    
    def find_planet
      Planet.find(params[:id])
    end
  
    def render_not_found_response
      render json: { error: "Planet not found" }, status: :not_found
    end
  
    def render_unprocessable_entity_response(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

end
