class Plan < ApplicationRecord

  def self.options
    Plan.all.map {|plan| plan.name}
  end
end
