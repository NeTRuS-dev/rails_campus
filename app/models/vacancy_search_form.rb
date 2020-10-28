class VacancySearchForm
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :title, :key_words, :wage, :position

  def search_results
    query = nil
    if title.present?
      sub_query = Vacancy.where(['vacancies.title LIKE ?', "%#{title}%"])
      query = if query.nil?
                sub_query
              else
                query.merge(sub_query)
              end
    end

    if key_words.present?
      splitted_words = key_words.split(',').map(&:strip)
      sub_query = nil
      splitted_words.each do |word|
        tmp_query = Vacancy.where(['vacancies.description LIKE ?', "%#{word}%"])
        sub_query = if sub_query.nil?
                      tmp_query
                    else
                      sub_query.or(tmp_query)
                    end
      end
      query = if query.nil?
                sub_query
              else
                query.merge(sub_query)
              end
    end
    if wage.present?
      sub_query = Vacancy.where(['vacancies.wage < ? or vacancies.wage > ?', wage.to_i + User::WAGE_RANGE, wage.to_i - User::WAGE_RANGE])
      query = if query.nil?
                sub_query
              else
                query.merge(sub_query)
              end
    end

    if position.present?
      sub_query = Vacancy.where(['vacancies.position LIKE ?', "%#{position}%"])
      query = if query.nil?
                sub_query
              else
                query.merge(sub_query)
              end
    end

    if query.nil?
      Vacancy.all
    else
      query.all
    end
  end
end