class GymsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_membership_invalid_response

    def index
        gyms = Gym.all
        render json: gyms
    end

    def show
        gym = find_gym
        render json: gym
    end

    def create
        if params[:gym_id]
            membership = Membership.create!(membership_params)
            return render json: membership, include: :gyms
        else
            gym = Gym.create!(gym_params)
        end
        render json: gym
    end

    def destroy
        gym = find_gym
        gym.destroy
        head :no_content
    end

private

    def find_gym
        Gym.find_by!(id: params[:id])
    end

    def gym_params
        params.permit(:name, :address)
    end

    def membership_params
        params.permit(:client_id, :charge)
    end

    def render_not_found_response
        render json: { errors: "Gym not found" }, status: :unprocessable_entity
    end

    def render_membership_invalid_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }
    end

end
