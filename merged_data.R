# Read the retention information from retention.txt
retention_data <- read.table("retention.txt", header = TRUE, stringsAsFactors = FALSE)

# Read the gene IDs and lengths from the other file
gene_info <- read.table("gene_lengths.txt", header = TRUE, stringsAsFactors = FALSE)
# Format the columns with fixed widths
formatted_gene_ids <- sprintf("%-40s", gene_info$id)
formatted_lengths <- sprintf("%-10d", gene_info$length)

# Create a data frame with the formatted columns
formatted_gene_info <- data.frame(id = formatted_gene_ids, length = formatted_lengths)

# Merge the data frames horizontally
merged_data <- cbind(formatted_gene_info, retention_data)


# Write the merged data to a file
write.table(merged_data, "merged_data.txt", col.names = TRUE, row.names = FALSE, quote = FALSE, sep = "\t")
