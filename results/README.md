# Results

The final submissions are (115 runs):

* `baseline` (8 runs): 2 runs for task1 on all 4 datasets.
* `dbis` [pdf](papers/dbis-2017.pdf) (40 runs): 5 runs for task1 and 5 runs for task2 on all 4 datasets.
* `icsi` [pdf](papers/icsi-2017.pdf) (15 runs): 5 runs for task1 on 3 datasets (no `allmusic`).
* `jku` [pdf](papers/jku-2017.pdf) (32 runs): 3 runs for task1 and 5 runs for task2 on all 4 datasets.
* `kart` [pdf](papers/kart-2017.pdf) (16 runs): 4 runs for task1 on all 4 datasets.
* `samirit` [pdf](papers/samirit-2017.pdf)(4 runs): 1 run for task1 on all 4 datasets.

For the baseline:

* `run1` is random, following the distribution of labels found in the development sets.
* `run2` always predicts the most popular genre in the development set.

The solid grey lines mark the performance of the random baseline, and the dotted lines mark the performance of the popularity-based baseline. The numbers indicate whether the run belongs to task1 or task2.

All results are also available in a [CSV file](allscores.csv). 

See the complete MediaEval2017 procedings including the working note papers for all submissions [here](http://ceur-ws.org/Vol-1984/). 

## Per-track average scores
### Per-track Precision vs Recall for all labels

![AllMusic - per track - all labels](png/320x240_allmusic_Rtrackall.png) ![Discogs - per track - all labels](png/320x240_discogs_Rtrackall.png)

![Lastfm - per track - all labels](png/320x240_lastfm_Rtrackall.png) ![Tagtraum - per track - all labels](png/320x240_tagtraum_Rtrackall.png)

### Per-track Precision vs Recall for genre labels

![AllMusic - per track - genre labels](png/320x240_allmusic_Rtrackgen.png) ![Discogs - per track - genre labels](png/320x240_discogs_Rtrackgen.png)

![Lastfm - per track - genre labels](png/320x240_lastfm_Rtrackgen.png) ![Tagtraum - per track - genre labels](png/320x240_tagtraum_Rtrackgen.png)

### Per-track Precision vs Recall for subgenre labels

![AllMusic - per track - subgenre labels](png/320x240_allmusic_Rtracksub.png) ![Discogs - per track - subgenre labels](png/320x240_discogs_Rtracksub.png)

![Lastfm - per track - subgenre labels](png/320x240_lastfm_Rtracksub.png) ![Tagtraum - per track - subgenre labels](png/320x240_tagtraum_Rtracksub.png)

## Per-label average scores
### Per-label Precision vs Recall for all labels

![AllMusic - per label - all labels](png/320x240_allmusic_Rlabelall.png) ![Discogs - per label - all labels](png/320x240_discogs_Rlabelall.png)

![Lastfm - per label - all labels](png/320x240_lastfm_Rlabelall.png) ![Tagtraum - per label - all labels](png/320x240_tagtraum_Rlabelall.png)

### Per-label Precision vs Recall for genre labels

![AllMusic - per label - genre labels](png/320x240_allmusic_Rlabelgen.png) ![Discogs - per label - genre labels](png/320x240_discogs_Rlabelgen.png)

![Lastfm - per label - genre labels](png/320x240_lastfm_Rlabelgen.png) ![Tagtraum - per label - genre labels](png/320x240_tagtraum_Rlabelgen.png)

### Per-label Precision vs Recall for subgenre labels

![AllMusic - per label - subgenre labels](png/320x240_allmusic_Rlabelsub.png) ![Discogs - per label - subgenre labels](png/320x240_discogs_Rlabelsub.png)

![Lastfm - per label - subgenre labels](png/320x240_lastfm_Rlabelsub.png) ![Tagtraum - per label - subgenre labels](png/320x240_tagtraum_Rlabelsub.png)

# Results adjusted by genre-subgenre hierarchies

The submissions to the task were required to include all predicted genres and subgenres explicitly. Therefore, we did not explicitly consider hierarchical relations in the evaluation.

We conducted an additional evaluation with an adjustment for such relations, because most submissions did not explicitly predict the genres of the predicted subgenres.
In these cases, we expanded all predictions to also include the corresponding genres, even if they were missing in the original submissions. Such correction may increase genre recall and alter precision, because more genres will be present in predictions, including relevant and irrelevant ones.
Note that the results at the subgenre label do not change.

The plots below demonstrate Precision, Recall and F-scores  with and without label expansion. The inspection of these results revealed no significant difference in performance. 
Recall changes very little, with the exception of ICSI. Still, its F-scores remain virtually the same due to the low precision.

All results are also available in a [CSV file](allscores2.csv). 

### Per-track F-score, Precision and Recall 

![Precision - per track - all labels](png2/320x240_Ptrackall.png) ![Precision - per track - genre labels](png2/320x240_Ptrackgen.png) 

![Recall - per track - all labels](png2/320x240_Rtrackall.png) ![Recall - per track - genre labels](png2/320x240_Rtrackgen.png) 

![F-score - per track - all labels](png2/320x240_Ftrackall.png) ![F-score - per track - genre labels](png2/320x240_Ftrackgen.png) 

### Per-label F-score, Precision and Recall

![Precision - per label - all labels](png2/320x240_Plabelall.png) ![Precision - per label - genre labels](png2/320x240_Plabelgen.png) 

![Recall - per label - all labels](png2/320x240_Rlabelall.png) ![Recall - per label - genre labels](png2/320x240_Rlabelgen.png) 

![F-score - per label - all labels](png2/320x240_Flabelall.png) ![F-score - per label - genre labels](png2/320x240_Flabelgen.png) 

