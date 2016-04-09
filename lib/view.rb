class View
  def list_of_recipe(recipes)
    recipes.each_with_index do |recipe, index|
      if recipe.done?
        puts "#{index + 1}. [x] #{recipe.name}"
      else
        puts "#{index + 1}. [ ] #{recipe.name}"
      end
    end
  end

  def create_a_new_recipe
    new_recipe = []
    puts "What's the name of the recipe you want to add?"
    print "> "
    name = gets.chomp
    puts "What's the description recipe?"
    print "> "
    description = gets.chomp
    new_recipe << name << description
  end

  def delete_recipe
    puts "Which recipe do you want to delete?"
    print "> "
    gets.chomp.to_i - 1
  end

  def ask_ingredient
    puts "Import recipes for which ingredient?"
    print "> "
    gets.chomp
  end

  def select_recipe
    puts "Please type a number to choose which recipe to import"
    print "> "
    gets.chomp.to_i - 1
  end

  def list_marmiton_recipe(recipes_marmiton)
    recipes_marmiton.each_with_index do |recipe_marmiton, index|
    puts "#{index + 1} - #{recipe_marmiton[:title]}"
    end
  end

  def ask_user_for_recipe_tested
    puts "Which recipe is tested?"
    print "> "
    gets.chomp.to_i - 1
  end
end
