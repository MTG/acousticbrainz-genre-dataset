.ROUND_DIGITS <- 4
# Function to print usage message
usage <- function(error) {
  if(!missing(error))
    cat("Error:", error, "\n", file = stderr())
  cat("Usage: Rscript eval.R <ground-truth-file> <run-file>\n", file = stderr())
  q(status = 1, save = "no")
}

# Check command line arguments
args <- commandArgs(trailingOnly = TRUE) # c("groundtruth.sample", "run.sample")
arg.gtruth <- args[1]
arg.run <- args[2]

if(is.na(arg.gtruth) || is.na(arg.run))
  usage()
if(!file.exists(arg.gtruth))
  usage(paste0("ground truth file '", arg.gtruth, "' does not exist."))
if(!file.exists(arg.run))
  usage(paste0("run file '", arg.run, "' does not exsist."))

# header: whether file has header or not
# releaseID: whether file has releaseID column (2nd) or not
readAndSort <- function(file, header = FALSE, releaseID = FALSE) {
  lines <- readLines(file)
  if(header)
    lines <- lines[-1]
  data <- lapply(lines, function(line) {
    parts <- strsplit(line, "\t", fixed = TRUE)[[1]]
    id <- parts[1]
    if(releaseID)
      labels <- parts[-1:-2]
    else
      labels <- parts[-1]
    labels <- labels[labels != ""]

    return(list(id, labels))
  })
  ids <- sapply(data, function(d) d[[1]])
  o <- order(ids)
  return(data[o])
}
isGenre <- function(x, sep = "---")
  !isSubgenre(x, sep)
isSubgenre <- function(x, sep = "---")
  grepl(sep, x, fixed = TRUE)

# Read files and initialize
lines.gtruth <- readAndSort(arg.gtruth, header = TRUE, releaseID = TRUE)
lines.run <- readAndSort(arg.run, header = FALSE, releaseID = FALSE)

Prec.track.all <- Rec.track.all <- Prec.track.gen <- Rec.track.gen <-
  Prec.track.sub <- Rec.track.sub <- rep(NA, length(lines.gtruth))
TP.label <- new.env(hash = TRUE)
T.label <- new.env(hash = TRUE)
P.label <- new.env(hash = TRUE)
M <- new.env(hash = TRUE)
for(i in seq_along(Prec.track.gen)) {
  gtruth <- lines.gtruth[[i]]
  run <- lines.run[[i]]
  if(gtruth[[1]] != run[[1]])
     stop(paste0("IDs don't match. Expected '", gtruth[[1]],"', but found '", run[[1]],"'."))
  gtruth <- gtruth[[2]]
  run <- run[[2]]

  ## PER TRACK
  # genre indices
  gtruth.genre.i <- isGenre(gtruth)
  run.genre.i <- isGenre(run)
  # all labels
  t <- length(gtruth)
  p <- length(run)
  tp <- gtruth %in% run
  Prec.track.all[i] <- sum(tp) / p
  Rec.track.all[i] <- sum(tp) / t
  # genre labels
  t.gen <- sum(gtruth.genre.i)
  p.gen <- sum(run.genre.i)
  tp.gen <- sum(tp & gtruth.genre.i)
  if(t.gen > 0) { # there are genre labels in truth
    Prec.track.gen[i] <- tp.gen / p.gen
    if(p.gen == 0) # if no genre retrieved, set precision to 0
      Prec.track.gen[i] <- 0
    Rec.track.gen[i] <- tp.gen / t.gen
  }
  # subgenre labels
  t.sub <- t - t.gen
  p.sub <- p - p.gen
  tp.sub <- sum(tp) - tp.gen
  if(t.sub > 0) { # there are subgenre labels in truth
    Prec.track.sub[i] <- tp.sub / p.sub
    if(p.sub == 0)
      Prec.track.sub[i] <- 0 # if no subgenre retrieved, set precision to 0
    Rec.track.sub[i] <- tp.sub / t.sub
  }
  # confusion matrix, true positives
  for(l in gtruth[tp]) {
    key <- paste(collapse = "\t", c(l, l))
    count <- mget(key, M, ifnotfound = 0)[[1]]+1
    assign(key, count, envir = M)
  }
  # confustion matrix, false positives with false negatives
  fn <- gtruth[!tp]
  fp <- run[!run %in% gtruth]
  for(l in fn) {
    for(l2 in fp) {
      key <- paste(collapse = "\t", c(l, l2))
      count <- mget(key, M, ifnotfound = 0)[[1]]+1/length(fn)
      assign(key, count, envir = M)
    }
  }
  
  ## PER LABEL
  # get previous count per label, increase
  t <- unlist(mget(gtruth, envir = T.label, ifnotfound = 0)) +1
  p <- unlist(mget(run, envir = P.label, ifnotfound = 0)) +1
  tp <- unlist(mget(gtruth[tp], envir = TP.label, ifnotfound = 0)) +1
  # and store back
  for(j in seq_along(t)) T.label[[names(t)[j]]] <- t[[j]]
  for(j in seq_along(p)) P.label[[names(p)[j]]] <- p[[j]]
  for(j in seq_along(tp)) TP.label[[names(tp)[j]]] <- tp[[j]]
}
# Precision and recall per label
allLabels <- sort(ls(T.label))
Prec.label <- unlist(mget(allLabels, TP.label, ifnotfound = 0)) /
  unlist(mget(allLabels, P.label, ifnotfound = 1)) # default can be 1 to avoid 0/0 (if p=0 then tp=0)
Rec.label <- unlist(mget(allLabels, TP.label, ifnotfound = 0)) /
  unlist(mget(allLabels, T.label))

# Compute F-scores
F.track.all <- 2 * Prec.track.all * Rec.track.all / (Prec.track.all + Rec.track.all)
F.track.all[is.nan(F.track.all)] <- 0 # both precision and recall = 0
F.track.gen <- 2 * Prec.track.gen * Rec.track.gen / (Prec.track.gen + Rec.track.gen)
F.track.gen[is.nan(F.track.gen)] <- 0 # both precision and recall = 0
F.track.sub <- 2 * Prec.track.sub * Rec.track.sub / (Prec.track.sub + Rec.track.sub)
F.track.sub[is.nan(F.track.sub)] <- 0 # both precision and recall = 0

F.label <- 2 * Prec.label * Rec.label / (Prec.label + Rec.label)
F.label[is.nan(F.label)] <- 0 # both precision and recall = 0

cat("computing matrix...");flush.console()
# Compute full confusion matrix
M2 <- matrix(NA, ncol = length(allLabels), nrow = length(allLabels), dimnames = list(allLabels, allLabels))
for(i in seq_along(allLabels)) {
  for(i2 in seq_along(allLabels)) {
    key <- paste(collapse = "\t", allLabels[c(i,i2)])
    count <- mget(key, M, ifnotfound = 0)[[1]]
    M2[i,i2] <- round(count, .ROUND_DIGITS)
  }
}
cat("done\n"); flush.console()
# Output
write.table(M2, file = paste0(arg.run, ".results_confusion"), 
            sep = "\t", quote = FALSE, col.names = TRUE, row.names = TRUE, dec = ".")

data.track <- data.frame(recordingmbid = sapply(lines.gtruth, function(l) l[[1]]),
                         P.all = Prec.track.all, R.all = Rec.track.all, F.all = F.track.all,
                         P.gen = Prec.track.gen, R.gen = Rec.track.gen, F.gen = F.track.gen,
                         P.sub = Prec.track.sub, R.sub = Rec.track.sub, F.sub = F.track.sub)
data.track[,-1] <- round(data.track[,-1], .ROUND_DIGITS)
write.table(data.track, file = paste0(arg.run, ".results_track"),
            sep = "\t", quote = FALSE, col.names = TRUE, row.names = FALSE, dec = ".", na = "NA")

data.label <- data.frame(label = allLabels,
                         P = Prec.label, R = Rec.label, F = F.label)
data.label[,-1] <- round(data.label[,-1], .ROUND_DIGITS)
write.table(data.label, file = paste0(arg.run, ".results_label"),
            sep = "\t", quote = FALSE, col.names = TRUE, row.names = FALSE, dec = ".", na = "NA")

meanAndSd <- function(x) # to simplify printing of mean and sd
  paste0("mean = ", round(mean(x, na.rm = TRUE), .ROUND_DIGITS),
         " sd = ", round(sd(x, na.rm = TRUE), .ROUND_DIGITS))

conn <- file(paste0(arg.run, ".results_summary"), open = "wt")
genre.i <- isGenre(data.label$label)
cat(c(paste0("# summary per track (all labels, n = ", nrow(data.track) ,")"),
      paste0("Precision: ", meanAndSd(data.track$P.all)),
      paste0("   Recall: ", meanAndSd(data.track$R.all)),
      paste0("  F-score: ", meanAndSd(data.track$F.all)),
      "",      
      paste0("# summary per track (genre labels, n = ", sum(!is.na(data.track$F.gen)) ,")"),
      paste0("Precision: ", meanAndSd(data.track$P.gen)),
      paste0("   Recall: ", meanAndSd(data.track$R.gen)),
      paste0("  F-score: ", meanAndSd(data.track$F.gen)),
      "",      
      paste0("# summary per track (subgenre labels, n = ", sum(!is.na(data.track$F.sub)) ,")"),
      paste0("Precision: ", meanAndSd(data.track$P.sub)),
      paste0("   Recall: ", meanAndSd(data.track$R.sub)),
      paste0("  F-score: ", meanAndSd(data.track$F.sub)),
      "",      
      paste0("# summary per label (all labels, n = ", sum(!is.na(data.label$F)) ,")"),
      paste0("Precision: ", meanAndSd(data.label$P)),
      paste0("   Recall: ", meanAndSd(data.label$R)),
      paste0("  F-score: ", meanAndSd(data.label$F)),
      "",      
      paste0("# summary per label (genre labels, n = ", sum(genre.i) ,")"),
      paste0("Precision: ", meanAndSd(data.label$P[genre.i])),
      paste0("   Recall: ", meanAndSd(data.label$R[genre.i])),
      paste0("  F-score: ", meanAndSd(data.label$F[genre.i])),
      "",
      paste0("# summary per label (subgenre labels, n = ", sum(!genre.i) ,")"),
      paste0("Precision: ", meanAndSd(data.label$P[!genre.i])),
      paste0("   Recall: ", meanAndSd(data.label$R[!genre.i])),
      paste0("  F-score: ", meanAndSd(data.label$F[!genre.i]))),
    sep = "\n", file = conn)
close.connection(conn)

writeLines(readLines(paste0(arg.run, ".results_summary"))) # output summary to console as well
