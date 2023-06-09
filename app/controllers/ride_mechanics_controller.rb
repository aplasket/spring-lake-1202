class RideMechanicsController < ApplicationController
  def create
    ride_mechanic = RideMechanic.create!(ride_id: params[:ride_id], mechanic_id: params[:id])
    mechanic = Mechanic.find_by(id: params[:id])
    redirect_to "/mechanics/#{mechanic.id}"

    ## alternative:
    #mechanic = Mechanic.find(params[:id])

    #another alternative:
    # ride_mechanic = RideMechanic.create!(ride_id: params[:ride_id], mechanic_id: params[:id])
    # redirect_to "/mechanics/#{params[:id]}"

    #or to be safe, even:
    # mechanic = Mechanic.find(params[:id])
    # ride_mechanic = RideMechanic.create!(ride_id: params[:ride_id], mechanic_id: mechanic.id)
    # redirect_to "/mechanics/#{mechanic.id}"
  end
end