class Recipe
  attr_reader :description, :name

  def initialize(name, description)
    @name = name
    @description = description
    @tested = false
  end

  def mark_as_tested
    @tested = true
  end

  def tested?
    @tested
  end
end
