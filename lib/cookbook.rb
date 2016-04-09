require "csv"
require 'nokogiri'
require_relative "recipe"
require 'open-uri'


class Cookbook
  attr_reader :recipes, :recipe_marmiton

  def initialize(csv_file)
    # Loads recipe from CSV_file
    @recipes = []
    @csv_file = csv_file
    read_from_csv
  end

  def add_recipe(recipe)
    # Adds recipe
    @recipes << recipe
    write_to_csv
  end

  def remove_recipe(index)
    # Remove recipe
    @recipes.delete_at(index)
    write_to_csv
  end

  def all
    @recipes
  end

  def scrapping(recipe_search)
    response = open("http://www.marmiton.org/recettes/recherche.aspx?aqt=#{recipe_search}")
    doc = Nokogiri::HTML(response, nil, 'utf-8')
    recipe_marmiton = []

    doc.css('.m_contenu_resultat').each do |element|
      title = element.search('.m_titre_resultat > a').inner_text
      times = element.search('.m_detail_time').inner_text.gsub(/\W/, ' ').strip
      match_time = times.match(/^(\d+ \w+)\s*( \d+ \w+|\d+ \w+ \d+ \w+)?$/)
      description = element.search('.m_texte_resultat').inner_text[0..150]
      votes = element.search('.m_recette_nb_votes').inner_text.match(/[0-9]+/)
      recipe_marmiton << {title: title, preparation_time: match_time[1],
        cooking_time: match_time[2], description: description, votes: votes }
    end
    return recipe_marmiton
  end

   def find(index)
    @recipes[index]
  end

  private

  def write_to_csv
    CSV.open(@csv_file, 'w') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description]
      end
    end
  end

  def read_from_csv
    CSV.foreach(@csv_file) do |row|
      name = row[0]
      description = row [1]
      @recipes << Recipe.new(name, description)
    end
  end
end
