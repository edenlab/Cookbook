require 'nokogiri'

DOC = Nokogiri::HTML(File.open('marmiton.html'), nil, 'utf-8')

def scrapping
  DOC.css('.m_contenu_resultat').each do |element|
    title = element.search('.m_titre_resultat > a').inner_text
    times = element.search('.m_detail_time').inner_text.gsub(/\W/, ' ').strip
    match_time = times.match(/^(\d+ \w+)\s*( \d+ \w+)?$/)
    description = element.search('.m_texte_resultat').inner_text[0..150]
    votes = element.search('.m_recette_nb_votes').inner_text.match(/[0-9]+/)
    p hash = {title: title, preparation_time: match_time[1], cooking_time: match_time[2], description: description, votes: votes }
  end
end

# def title_search
#   DOC.css('.m_contenu_resultat').each do |element|
#     puts element.search('.m_titre_resultat > a').inner_text
#   end
# end

# def timing
#   DOC.css('.m_contenu_resultat').each do |element|
#     times = element.search('.m_detail_time').inner_text.gsub(/\W/, ' ').strip
#     match_time = times.match(/^(\d+ \w+)\s*( \d+ \w+)?$/)
#   end
# end

# def summary
#   DOC.css('.m_contenu_resultat').each do |element|
#     puts element.search('.m_texte_resultat').inner_text[0..150]
#   end
# end

# def number_of_votes
#   DOC.css('.m_contenu_resultat').each do |element|
#     element.search('.m_recette_nb_votes').inner_text.match(/[0-9]+/)
#   end
# end


