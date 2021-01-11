class Plan < ApplicationRecord
  validates :name, :price, presence: true

  scope :available_plan, ->(plan) { where.not(id: plan) }
  def self.options
    Plan.all.collect {|plan| [plan.name, plan.id]}
  end
end
