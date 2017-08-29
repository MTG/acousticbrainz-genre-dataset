# Run from /results directory or change path below
readScores <- function(dir = "./summaries/") {
  files <- list.files(path = dir, full.names = FALSE)
  n <- length(files)

  s <- data.frame(team = rep("", n), task = "", dataset = "", run = "",
                     Ftrackall = 0, Ptrackall = 0, Rtrackall = 0,
                     Ftrackgen = 0, Ptrackgen = 0, Rtrackgen = 0,
                     Ftracksub = 0, Ptracksub = 0, Rtracksub = 0,
                     Flabelall = 0, Plabelall = 0, Rlabelall = 0,
                     Flabelgen = 0, Plabelgen = 0, Rlabelgen = 0,
                     Flabelsub = 0, Plabelsub = 0, Rlabelsub = 0,
                     stringsAsFactors = FALSE)

  for(i in seq_along(files)) {
    file <- files[i]
    parts <- strsplit(file, "(_|\\.)", fixed = FALSE)[[1]]
    team <- parts[1]
    task <- parts[2]
    dataset <- parts[3]
    run <- parts[4]

    lines <- readLines(file.path(dir, file))
    lines <- lines[grepl("mean", lines)]
    scores <- as.numeric(gsub("^.+mean = ([^ ]+).+$", "\\1", lines))

    s[i, 1:4] <- c(team, task, dataset, run)
    s[i, -1:-4] <- scores
  }
  s$team <- as.factor(s$team)
  s$task <- as.factor(s$task)
  s$dataset <- as.factor(s$dataset)
  s$run <- as.factor(s$run)

  s
}
s2 <- readScores()
#write.csv(file = "allscores.csv", row.names = FALSE, s2)

w <- 320
h <- 240
for(dset in c("allmusic", "discogs", "lastfm", "tagtraum")) {
  for(x in c("Rtrackall", "Rtrackgen", "Rtracksub", "Rlabelall", "Rlabelgen", "Rlabelsub")) {
    s <- s2[s2$dataset == dset,]

    y <- gsub("^R", "P", x)
    lim <- ifelse(grepl("track",x), 1, .75)
    main = paste0(dset, " - ",
                  ifelse(grepl("track", x), "per track", "per label"), ", ",
                  ifelse(grepl("all$", x), "all labels",
                         ifelse(grepl("gen$", x), "genre labels", "subgenre labels")))

    #pdf(file = paste0(dset,"_",x,".pdf"), width = 6, height = 6)
    png(filename = paste0(w,"x",h,"_", dset,"_",x,".png"), width = w, height = h)
    par(mar=c(3.1,2.9,2,1), mgp=c(1.9,.7,0))
    plot(NA, xlim=c(0,lim), ylim=c(0,lim), xaxs = "i", yaxs = "i",
         xlab = "Recall", ylab = "Precision", main = main)
    abline(v = s[s$team=="baseline" & s$run == "run1", x],
           h = s[s$team=="baseline" & s$run == "run1", y], col = "darkgrey")
    abline(v = s[s$team=="baseline" & s$run == "run2", x],
           h = s[s$team=="baseline" & s$run == "run2", y], col = "darkgrey", lty=2)
    points(s[,x], s[,y], col = s$team, pch = gsub("task", "", s$task))
    # points(s[,x], s[,y], col = s$team, pch = 19)
    # text(x=s[,x], y=s[,y], pos=4, labels = gsub("(ask|un)", "", paste0(s$task, "-", s$run)),
    #      col = as.integer(s$team))
    legend("topright", col = seq(levels(s$team)), legend = levels(s$team), pch = 19)
    dev.off()
  }
}

