print("############################################################")
print("# 1. Basic probability")
print("############################################################")

# Probability of a single event: rolling a fair die
prob_rolling_6 <- 1/6
print(paste("Probability of rolling a 6:", prob_rolling_6))

# Probability of multiple independent events
# Rolling two dice and both are 6
prob_two_6 <- (1/6) * (1/6)
print(paste("Probability of two 6s:", prob_two_6))

print("############################################################")
print("# 2. Conditional probability")
print("############################################################")

# Example: probability of drawing a red card given that it is a face card
red_face_cards <- 6   # Jack, Queen, King of Hearts & Diamonds
total_face_cards <- 12
prob_red_given_face <- red_face_cards / total_face_cards
print(paste("P(Red | Face):", prob_red_given_face))

print("############################################################")
print("# 3. Bayes' theorem")
print("############################################################")

# Example: Disease testing
# P(Disease) = 0.01, P(Positive|Disease) = 0.99, P(Positive|NoDisease) = 0.05

p_disease <- 0.01
p_pos_given_disease <- 0.99
p_pos_given_no <- 0.05

# Bayes' theorem: P(Disease | Positive)
p_positive <- p_pos_given_disease * p_disease + p_pos_given_no * (1 - p_disease)
p_disease_given_positive <- (p_pos_given_disease * p_disease) / p_positive

print(paste("Probability of disease given positive test:", round(p_disease_given_positive, 4)))
