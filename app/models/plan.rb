class Plan < ApplicationRecord

  def self.options
    Plan.all.collect {|plan| [plan.name, plan.id]}
  end
end
