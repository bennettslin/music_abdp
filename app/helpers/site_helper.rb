module SiteHelper
  def true_score_from_binary_score binary_score
    true_score = 0
    exponent = 2

    for i in (exponent).downto(0)
       if binary_score >= 2 ** i # Ruby exponent!
        binary_score -= 2 ** i
        true_score += 1
       end
    end
    true_score
  end
end

