# Install and load packages rDEA
#install.packages("rDEA")
library(rDEA)
library(readxl)
library(ggplot2)


# Load data
inputs <- read_xlsx(file.choose()) #Choose file Final Input
outputs <- read_xlsx(file.choose()) #Choose file Final Ouput

# Output-oriented DEA with variable returns to scale
dea_result <- dea(X = inputs, Y = outputs, XREF = inputs, YREF = outputs, 
                  model = "output", RTS = "vrs")

# View efficiency scores
efficiency_scores <- dea_result$thetaOpt
print(efficiency_scores)

length(efficiency_scores)

# Identify DEA-efficient units
dea_efficient_units <- which(efficiency_scores == 1)
cat("DEA-efficient DMUs (rows):", dea_efficient_units, "\n")

# Step 5: Compute weighted sum for Pareto 
# Define weights used in MOLB game
w_social <- 0.25
w_economic <- 0.5
w_environmental <- 0.25

# Weighted sum for Pareto ranking
weighted_sum <- w_social * outputs$Social + 
  w_economic * outputs$Economic + 
  w_environmental * outputs$Environmental

# Store in output_data for reference
outputs$Weighted_Sum <- weighted_sum

# Step 6: Identify Pareto-efficient solutions (lowest weighted sum)
# (assuming minimisation)
pareto_cutoff <- sort(weighted_sum)[5]  # top 5 efficient
pareto_efficient_units <- which(weighted_sum <= pareto_cutoff)

cat("Pareto-efficient DMUs (rows):", pareto_efficient_units, "\n")

# Step 7: Compare DEA and Pareto
comparison <- data.frame(
  DMU = 1:nrow(outputs),
  DEA_Efficient = efficiency_scores == 1,
  Pareto_Efficient = 1:nrow(outputs) %in% pareto_efficient_units,
  Weighted_Sum = weighted_sum
)

print("Comparison of DEA and Pareto-efficient DMUs:")
print(comparison)

# Create a comparison table
comparison <- data.frame(
    DMU = 1:nrow(inputs),
    DEA_Efficient = dea_result$thetaOpt == 1,
    Pareto_Efficient = 1:nrow(inputs) %in% pareto_efficient_units,
    Weighted_Sum = weighted_sum
     )

# View top rows
print(head(comparison, 10))

write.csv(comparison, "DEA_vs_Pareto_Comparison.csv", row.names = FALSE)

#Visualisation

comparison$Label <- paste0("DMU ", comparison$DMU)
ggplot(comparison, aes(x = Label, y = Weighted_Sum, fill = DEA_Efficient)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_point(aes(shape = Pareto_Efficient), size = 3, colour = "red") +
  theme_minimal() +
  labs(title = "DEA vs Pareto Comparison",
       y = "Weighted Sum Score",
       fill = "DEA Efficient",
       shape = "Pareto Efficient") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
