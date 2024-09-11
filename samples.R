#name all the samples for the downstream analysis
sample_names <- c(
  "SRR6834781", "SRR6834782", "SRR6834783"
)

# Write the sample names to a file
write.table(sample_names, "sample.txt", col.names = FALSE, row.names = FALSE, quote = FALSE)
