# Set the directory path where the intron files are located
directory_path <- "/N/scratch/syennapu/intron_retention/intronretention/"

# Read the sample names from the sample.txt file
sample_names <- readLines("sample.txt")

# Initialize an empty vector to store unique IDs
unique_ids <- c()

# Loop through each sample and extract the IDs
for (sample_name in sample_names) {
  # Construct the path to the intron_candidates.txt file for the current sample
  file_path <- file.path(directory_path, sample_name, paste0(sample_name, "Aligned.sortedByCoord.out_intron_candidates.txt"))

  # Read the file
  data <- read.table(file_path, header = TRUE, stringsAsFactors = FALSE)

  # Extract the IDs from the first column
  ids <- data[, 1]

  # Append unique IDs to the vector
  unique_ids <- union(unique_ids, ids)
}

# Calculate lengths for each unique gene ID
calculate_length <- function(gene_id) {
  # Extract the start and end positions from the gene ID
  start_end <- strsplit(gene_id, ":")[[1]][2]
  start_end <- strsplit(start_end, "-")[[1]]
  start <- as.numeric(start_end[1])
  end <- as.numeric(start_end[2])

  # Calculate the length
  length <- end - start + 1
  return(length)
}

# Calculate lengths for each unique gene ID
gene_lengths <- sapply(unique_ids, calculate_length)

# Combine gene IDs and lengths into a data frame
gene_info <- data.frame(id = unique_ids, length = gene_lengths)
# Format the gene ID column with proper alignment
gene_info$id <- sprintf("%-40s", gene_info$id)
# Write the gene IDs and lengths to a file
write.table(gene_info, "gene_lengths.txt", col.names = TRUE, row.names = FALSE, quote = FALSE,sep="\t")
