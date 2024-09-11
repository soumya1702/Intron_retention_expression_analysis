# Set the directory path where the intron files are located
directory_path <- "/N/scratch/syennapu/intron_retention/intronretention/"

# Read the sample names from the sample.txt file
sample_names <- readLines("sample.txt")

# Load the unique gene IDs from unique_ids.txt file
unique_ids <- read.table("unique_ids.txt", header = TRUE, stringsAsFactors = FALSE)$id

# Initialize an empty data frame to store the TPM values
tpm_values <- data.frame(matrix(NA, nrow = length(unique_ids), ncol = length(sample_names)))
row.names(tpm_values) <- unique_ids
colnames(tpm_values) <- sample_names

# Loop through each sample and extract the TPM values
for (i in seq_along(sample_names)) {
  sample_name <- sample_names[i]

  # Construct the path to the intron_candidates.txt file for the current sample
  file_path <- file.path(directory_path, sample_name, paste0(sample_name, "Aligned.sortedByCoord.out_intron_candidates.txt"))

  # Read the file
  data <- read.table(file_path, header = TRUE, stringsAsFactors = FALSE)

  # Extract the IDs and TPM values
  ids <- data[, 1]
  tpms <- data[, "tpm"]

  # Update tpm_values with TPM values for the corresponding sample and gene ID
  tpm_values[ids, sample_name] <- tpms
}

# Write the TPM values to a file with proper spacing and alignment
write.table(tpm_values, "retention.txt", col.names = TRUE, row.names = TRUE, quote = FALSE, sep = "\t", na = "NA")
