# Set the directory path where the intron files are located
directory_path <- "/N/scratch/syennapu/intron_retention/intronretention"

# Read the sample names from the sample.txt file
sample_names <- readLines("sample.txt")

# Initialize an empty vector to store unique IDs
unique_ids <- c()

# Loop through each sample and extract the IDs
for (sample_name in sample_names) {
  # Construct the path to the intron_candidates.txt file for the current sample
  file_path <- file.path(directory_path,sample_name, paste0(sample_name,"Aligned.sortedByCoord.out_intron_candidates.txt" ))

  # Read the file
  data <- read.table(file_path, header = TRUE, stringsAsFactors = FALSE)

  # Extract the IDs from the first column
  ids <- data[, 1]

  # Append unique IDs to the vector
  unique_ids <- union(unique_ids, ids)
}

# Write the unique IDs to a file
write.table(data.frame(id = unique_ids), "unique_ids.txt", col.names = TRUE, row.names = FALSE, quote = FALSE)
