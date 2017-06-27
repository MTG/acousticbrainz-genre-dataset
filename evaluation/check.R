# Function to print usage message
usage <- function(error) {
  if(!missing(error))
    cat("Error:", error, "\n", file = stderr())
  cat("Usage: Rscript check.R <source-name> <run-file>",
      paste0("  where <source-name> is one of: '",
             paste0(collapse= "', '", names(.vocabularies)), "'."),
      sep = "\n", file = stderr())
  q(status = 1, save = "no")
}

# Check path to check.data and read
args <- commandArgs(trailingOnly = FALSE)
data.path <- args[grep("^--file=", args, perl = TRUE)]
data.path <- file.path(dirname(gsub("--file=", "", data.path)), "check.data")
if(!file.exists(data.path))
  stop("data file can't be found. Make sure 'check.data' is in the same path as 'check.R'")
suppressWarnings(tryCatch(load(data.path, verbose = FALSE), error = function(e)
  stop("data file 'check.data' is corrupted. Try downloading again.")))
.vocabularies <- data[[1]]
.mbids <- data[[2]]

# Check command line arguments
args <- commandArgs(trailingOnly = TRUE)
arg.source <- args[1]
arg.run <- args[2]

if(is.na(arg.source) || is.na(arg.run))
  usage()
if(!arg.source %in% names(.vocabularies))
  usage(paste0("source name '", arg.source, "' is not valid."))
if(!file.exists(arg.run))
  usage(paste0("run file '", arg.run, "' does not exsist."))

# Read and check run file, line by line
lines <- readLines(arg.run)
mbids <- character(length(lines))
for(i in seq_along(lines)) {
  if(i %% 1000 == 1) {
    cat(".");
    flush.console()
  }
  parts <- strsplit(lines[i], "\t", fixed = TRUE)[[1]]
  if(length(parts) < 2)
    stop(paste0("malformed line ", i, " '", lines[i], "'"))

  mbids[i] <- parts[1]
  labels <- parts[-1]
  labels <- labels[labels != ""]

  # check no labels
  if(length(labels) == 0)
    stop(paste0("no labels in line ", i, " '", parts[1], "'"))
  # check duplicate labels
  if(length(labels) != length(unique(labels)))
    stop(paste0("duplicate labels in line ", i, " '", parts[1], "'"))
  # check labels are correct
  notInVoc <- which(!labels %in% .vocabularies[[arg.source]])
  if(length(notInVoc) > 0)
    stop(paste0("unknown labels in line ", i, ": '",
                paste(labels[notInVoc], collapse = "', '")
                ,"'. Perhaps wrong source?"))
}

# check duplicate mbids
mbids.t <- table(mbids)
i <- which(mbids.t>1)
if(length(i) != 0)
  stop(paste0("duplicate RecordID '", names(mbids.t)[i[1]], "'"))

# check mbids are correct
mbids <- names(mbids.t)
i <- which(!mbids %in% .mbids[[arg.source]])
if(length(i) > 0)
  stop(paste0("unknown RecordID '",
              paste(mbids[seq(min(10, length(i)))], collapse = "', '"),
              "'"))
i <- which(!.mbids[[arg.source]] %in% mbids)
if(length(i) > 0)
  stop(paste0("missing RecordID '",
              paste(.mbids[[arg.source]][seq(min(10, length(i)))], collapse = "', '"),
              "'"))

# if(length(mbids) != length(.mbids[[arg.source]]))
#   stop(paste0("incorrect number of instances. Expected: ",
#               length(.mbids[[arg.source]]), ". Provided: ", length(mbids), ""))
# i <- which(mbids != .mbids[[arg.source]])
# if(length(i) != 0)
#   stop(paste0("unexpected RecordID '", mbids[i[1]], "'"))

cat("OK\n")
