module SiteHelper

  def empty_genre_hashes
    Genre.all.map do |genre|
      {
        genre_name: genre.name,
        total_scores_array: [0, 0, 0],
        total_quizzes: 0
      }
    end
  end

  def user_hash_from_user_hashes user_hashes, user
    user_hash = nil
    (0...user_hashes.count).each do |i|
      if user_hashes[i][:user_id] == user.id
         user_hash = user_hashes[i]
        break
      end
    end
    user_hash
  end

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

  def add_ratings_to_genre_hashes genre_hashes

    (0...genre_hashes.count).each do |i| # i is number of genres
      genre_hash = genre_hashes[i]

      total_quizzes = genre_hash[:total_quizzes]
      ratings_array = [0, 0, 0]
      (0... genre_hash[:total_scores_array].count).each do |j| # j is number of questions
        total_score = genre_hash[:total_scores_array][j]

        # rating is 3 point for each correct answer, minus 1 point for each incorrect answer
        ratings_array[j] = 3 * total_score - (total_quizzes - total_score)
      end
      genre_hash[:ratings_array] = ratings_array
    end
  end

end

