## Baseline Performance

We implemented a random baseline that reproduces the joint distribution of labels as found in the train set.
The results below show the performance of this baseline for each train set separately, as computed by the official evaluation script.

### Allmusic set

    # summary per track (all labels, n = 1353213)
    Precision: mean = 0.1451 sd = 0.2738
       Recall: mean = 0.1454 sd = 0.274
      F-score: mean = 0.1107 sd = 0.1904
    
    # summary per track (genre labels, n = 1353213)
    Precision: mean = 0.2922 sd = 0.425
       Recall: mean = 0.2923 sd = 0.425
      F-score: mean = 0.2754 sd = 0.3958
    
    # summary per track (subgenre labels, n = 1057442)
    Precision: mean = 0.0321 sd = 0.1274
       Recall: mean = 0.0321 sd = 0.1273
      F-score: mean = 0.0282 sd = 0.1062
    
    # summary per label (all labels, n = 766)
    Precision: mean = 0.0059 sd = 0.0237
       Recall: mean = 0.0059 sd = 0.0237
      F-score: mean = 0.0059 sd = 0.0237
    
    # summary per label (genre labels, n = 21)
    Precision: mean = 0.0632 sd = 0.1169
       Recall: mean = 0.0632 sd = 0.1168
      F-score: mean = 0.0632 sd = 0.1168
    
    # summary per label (subgenre labels, n = 745)
    Precision: mean = 0.0043 sd = 0.0107
       Recall: mean = 0.0043 sd = 0.0107
      F-score: mean = 0.0043 sd = 0.0107

### Discogs set
 
    # summary per track (all labels, n = 904944)
    Precision: mean = 0.1445 sd = 0.2332
       Recall: mean = 0.1447 sd = 0.2333
      F-score: mean = 0.1308 sd = 0.1986
    
    # summary per track (genre labels, n = 904944)
    Precision: mean = 0.2848 sd = 0.4168
       Recall: mean = 0.285 sd = 0.417
      F-score: mean = 0.2664 sd = 0.3839
    
    # summary per track (subgenre labels, n = 796962)
    Precision: mean = 0.0221 sd = 0.1248
       Recall: mean = 0.022 sd = 0.1243
      F-score: mean = 0.0196 sd = 0.1069
    
    # summary per label (all labels, n = 315)
    Precision: mean = 0.0097 sd = 0.0344
       Recall: mean = 0.0097 sd = 0.0344
      F-score: mean = 0.0097 sd = 0.0344
    
    # summary per label (genre labels, n = 15)
    Precision: mean = 0.0916 sd = 0.1308
       Recall: mean = 0.0916 sd = 0.1307
      F-score: mean = 0.0916 sd = 0.1307
    
    # summary per label (subgenre labels, n = 300)
    Precision: mean = 0.0056 sd = 0.0095
       Recall: mean = 0.0056 sd = 0.0094
      F-score: mean = 0.0056 sd = 0.0094
 
### Lastfm set
 
    # summary per track (all labels, n = 566710)
    Precision: mean = 0.0757 sd = 0.1955
       Recall: mean = 0.0757 sd = 0.1957
      F-score: mean = 0.0698 sd = 0.1728
    
    # summary per track (genre labels, n = 566710)
    Precision: mean = 0.1457 sd = 0.3417
       Recall: mean = 0.1456 sd = 0.3416
      F-score: mean = 0.1406 sd = 0.3282
    
    # summary per track (subgenre labels, n = 439709)
    Precision: mean = 0.0168 sd = 0.109
       Recall: mean = 0.0169 sd = 0.1097
      F-score: mean = 0.0158 sd = 0.0996
    
    # summary per label (all labels, n = 327)
    Precision: mean = 0.0073 sd = 0.0226
       Recall: mean = 0.0073 sd = 0.0227
      F-score: mean = 0.0073 sd = 0.0227
    
    # summary per label (genre labels, n = 30)
    Precision: mean = 0.0378 sd = 0.0642
       Recall: mean = 0.0378 sd = 0.0642
      F-score: mean = 0.0378 sd = 0.0642
    
    # summary per label (subgenre labels, n = 297)
    Precision: mean = 0.0042 sd = 0.0076
       Recall: mean = 0.0042 sd = 0.0076
      F-score: mean = 0.0042 sd = 0.0076
 
### Tagtraum set
 
    # summary per track (all labels, n = 486740)
    Precision: mean = 0.1309 sd = 0.2358
       Recall: mean = 0.131 sd = 0.2362
      F-score: mean = 0.1277 sd = 0.2271
    
    # summary per track (genre labels, n = 486740)
    Precision: mean = 0.2637 sd = 0.4309
       Recall: mean = 0.2641 sd = 0.4313
      F-score: mean = 0.2589 sd = 0.4215
    
    # summary per track (subgenre labels, n = 448362)
    Precision: mean = 0.0601 sd = 0.1846
       Recall: mean = 0.0602 sd = 0.1849
      F-score: mean = 0.0585 sd = 0.1767
    
    # summary per label (all labels, n = 296)
    Precision: mean = 0.0096 sd = 0.0351
       Recall: mean = 0.0096 sd = 0.035
      F-score: mean = 0.0096 sd = 0.0351
    
    # summary per label (genre labels, n = 31)
    Precision: mean = 0.0362 sd = 0.0897
       Recall: mean = 0.0362 sd = 0.0896
      F-score: mean = 0.0362 sd = 0.0897
    
    # summary per label (subgenre labels, n = 265)
    Precision: mean = 0.0065 sd = 0.0192
       Recall: mean = 0.0065 sd = 0.0191
      F-score: mean = 0.0065 sd = 0.0192
