module SessionHelper
  def alert_type(type)
    if type == 'notice'
      type = 'info'
    elsif type == 'alert'
      type = 'danger'
    end
    type
  end
end