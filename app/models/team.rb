class Team < ApplicationRecord
  has_many :players

  def full_name
    "#{location} #{team_name}"
  end
end
