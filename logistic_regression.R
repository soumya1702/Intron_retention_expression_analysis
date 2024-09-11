library(ggplot2)
library(readxl)

# Set your working directory
setwd("~/Desktop")

# Read the data from intron.xlsx from metadata from ncbi sra run selector
intron_data <- read_excel("INTRON.xlsx", sheet = 1)

# Read the data from alcohol_data.txt and control_data.txt, and these are extracted from merged data
alcohol_data <- read.table("/N/scratch/syennapu/intron_retention/alcohol_data.txt", header = TRUE, na.strings = "N/A")
control_data <- read.table("/N/scratch/syennapu/intron_retention/control_data.txt", header = TRUE, na.strings = "N/A")

# Convert the relevant numeric columns to numeric
numeric_cols <- 3:ncol(alcohol_data)
alcohol_data[, numeric_cols] <- apply(alcohol_data[, numeric_cols], 2, as.numeric)
control_data[, numeric_cols] <- apply(control_data[, numeric_cols], 2, as.numeric)

# Calculate TPM * length for each sample
alcohol_data$TPM_length_sum <- rowSums(alcohol_data[, numeric_cols] * alcohol_data$length, na.rm = TRUE)
control_data$TPM_length_sum <- rowSums(control_data[, numeric_cols] * control_data$length, na.rm = TRUE)

all_tpm_length_sums <- c(alcohol_tpm_length, control_tpm_length)

#metadata from ncbi sra run selector
analysis = intron_data

# Create the 'TPM_length_sum' variable in analysis_data
analysis$TPM_length_sum <- all_tpm_length_sums[match(analysis$Run, names(all_tpm_length_sums))]


# Convert categorical variables to factors
analysis$GENDER <- as.factor(analysis$GENDER)
analysis$STATUS <- as.factor(analysis$STATUS)
analysis$Smoking <- as.factor(analysis$Smoking)
analysis$Batch <- as.factor(analysis$Batch)

#0r to convert to numerical data
analysis <- analysis %>%
  mutate(GENDER = recode(GENDER, "Male" = 1, "Female" = 0),
         STATUS = recode(STATUS, "control" = 0, "alcohol" = 1),
         Batch = recode(Batch, `1` = 0, `2` = 1),
         Smoking = recode(Smoking, "Never" = 0, "Ex-smoker" = 1, "current" = 2,"NA"= NA_real_))


# Perform linear regression analysis
glinear_model <- glm(TPM_length_sum ~ GENDER + STATUS + Smoking + Batch + STATUS*Smoking, family = gaussian(link = "log"), data = analysis, method = "glm.fit")

# Perform logistic regression analysis
linear_model <- lm(TPM_length_sum ~ GENDER + STATUS + Smoking + Batch, data = analysis_data)
# Display summary of the linear model
summary(glinear_model)

# --
#boxplots
ggplot(analysis_data, aes(x = predict(linear_model), y = analysis_data$TPM_length_sum)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Predicted vs. Observed Values",
       x = "Predicted TPM_length_sum",
       y = "Observed TPM_sum") +
  theme_minimal()





