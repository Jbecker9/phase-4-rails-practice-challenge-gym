class Gym < ApplicationRecord
    has_many :memberships, dependent: :destroy
    has_many :clients, through: :memberships

    validates :name, presence: true
    validates :client_id, uniqueness: true
end
