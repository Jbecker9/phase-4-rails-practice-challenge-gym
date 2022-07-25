class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_membership_invalid_response

    def index
        memberships = Membership.all
        render json: memberships
    end

    def create
        membership = Membership.create!(membership_params)
        render json: membership, include: :gym
    end

private 

    def membership_params
        params.permit(:client_id, :charge, :gym_id)
    end

    def render_membership_invalid_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }
    end

end
