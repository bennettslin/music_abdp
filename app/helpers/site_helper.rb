module SiteHelper

  def score_array_from_binary_score binary_score
    score_array = [0, 0, 0]
    exponent = 2

    for i in (exponent).downto(0)
       if binary_score >= 2 ** i # Ruby exponent!
        binary_score -= 2 ** i
        score_array[i] += 1
       end
    end

    score_array
  end

  def add_percentages_to_genre_hashes genre_hashes

    (0...genre_hashes.count).each do |i| # i is number of genres
      genre_hash = genre_hashes[i]

      total_quizzes = genre_hash[:total_quizzes]
      percentages_array = [0, 0, 0]
      (0... genre_hash[:total_scores_array].count).each do |j| # j is number of questions

        # do not divide by zero
        if total_quizzes > 0
          percentages_array[j] = 100 * genre_hash[:total_scores_array][j].to_f / total_quizzes.to_f
        end
      end
      genre_hash[:percentages_array] = percentages_array
    end
  end
end

