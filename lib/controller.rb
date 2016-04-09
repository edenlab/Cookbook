require_relative "recipe"
require_relative "view"
require_relative "cookbook"

class Controller
  def initialize(cookbook)
    @view = View.new
    @cookbook = cookbook
  end

  def list
    # Lists all recipes
    # 1 - Get recipes from cookbook
    recipes = @cookbook.all
    # 2 - Pass recipes to view
    @view.list_of_recipe(recipes)
  end

  def create
    # 1 - Ask user which recipe to add
    new_recipe = @view.create_a_new_recipe
    name = new_recipe[0]
    description = new_recipe[1]
    # 2 - Create new recipe
    recipe = Recipe.new(name, description)
    # 3 - Save recipe
    @cookbook.add_recipe(recipe)
  end

  def destroy
    # 1 - Ask user which recipe they want to delete
    index = @view.delete_recipe
    # 2 - find recipe in cookbook
    # recipe_id = @cookbook.find(index)
    # 3 - delete recipe
    @cookbook.remove_recipe(index)
  end

  def load_recipes
    # 1 - Ask user what ingredients he wants to search
    recipe_search = @view.ask_ingredient
    # 2 - Load recipe list with ingredient
    recipes = @cookbook.scrapping(recipe_search)
    @view.list_marmiton_recipe(recipes)
    # 3 - Ask which recipe, the user wants to select
    index = @view.select_recipe
    new_recipe = recipes[index]
    # 4 - Import in csv
    recipe = Recipe.new(new_recipe[:title], new_recipe[:description])
    @cookbook.add_recipe(recipe)
  end

    def mark_as_tested
    # 1 - Ask user which task is done
    index = @view.ask_user_for_recipe_tested
    # 2 - Find task in repository
    recipe = @cookbook.find(index)
    # 3 - Mark task as done
    recipe.mark_as_tested
  end
end


