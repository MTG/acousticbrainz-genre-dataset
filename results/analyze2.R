a <- read.csv("allscores.csv")
b <- read.csv("allscores2.csv")

w <- 320
h <- 240
for(x in c("Ftrackall", "Ftrackgen", "Ptrackall", "Ptrackgen", "Rtrackall", "Rtrackgen",
           "Flabelall", "Flabelgen", "Plabelall", "Plabelgen", "Rlabelall", "Rlabelgen")) {

  main = paste0(substr(x, 1, 1), " - ",
                ifelse(grepl("track", x), "per track", "per label"), ", ",
                ifelse(grepl("all$", x), "all labels",
                       ifelse(grepl("gen$", x), "genre labels", "subgenre labels")))

  png(filename = paste0(w,"x",h,"_", x, ".png"), width = w, height = h)
  par(mar=c(3.1,2.9,2,6), mgp=c(1.9,.7,0), xpd = FALSE)
  plot(NA, xlim=0:1, ylim=0:1, xlab = "Without expansion", ylab = "With expansion", main = main)
  abline(0:1)
  points(a[,x], b[,x], col = a$team, pch = gsub("task", "", a$task))
  par(xpd = TRUE)
  legend(1+30/w, 1, col = seq(levels(a$team)), legend = levels(a$team), pch = 19, bty = "n")
  dev.off()
}
