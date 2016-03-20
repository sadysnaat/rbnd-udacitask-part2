module Recurrent
  def add_recurrence(options={})
    recurrence = IceCube::Rule
    options.each do |key, value|
      recurrence = recurrence.send(key, value)
    end
    return recurrence
  end
end
