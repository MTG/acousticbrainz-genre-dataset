# AcousticBrainz Genre Task 2017: Content-based music genre recognition from multiple sources
## Announcements
- May 1: We are almost ready to release development and testing datasets within a few days!

## Task schedule
- **Development and testing datasets will be released on May 1, 2017**
- Baseline approach will be released on May 15, 2017
- May-Mid-August: Work on algorithms
- Mid-August: Submit runs
    - 14 August: Run submission
    - 21 August: Results returned to participants
- Early September: Working notes paper due
- 13-15 September MediaEval 2017 Workshop in Dublin
 
## Task description
This task invites participants to predict genre and subgenre of unknown music recordings (songs) given automatically computed features of those recordings. We provide a training set of such audio features taken from the AcousticBrainz database and genre and subgenre labels from four different music metadata websites. The taxonomies that we provide for each website vary in their specificity and breadth. Each source has its own definition for its genre labels meaning that these labels may be different between sources. Participants must train model(s) using this data and then generate predictions for a test set. 

The models will be evaluated in two subtasks:
- Subtask 1: consider each set of genre annotations individually to generate predictions
- Subtask 2: combine sources together to generate predictions

Participants will first consider each set of genre annotations individually (Subtask1) and then take advantage of combining sources together (Subtask 2).

See the complete task description here: http://www.multimediaeval.org/mediaeval2017/acousticbrainz/index.html


The task has two sub-tasks. In both tasks participants must create a system that uses provided music features as an input and predicts genre labels as an output.

**Subtask 1: Single-source Classification.** This subtask will explore conventional systems each one trained on a single dataset. Participants will submit predictions for the test set of each dataset separately, following their respective class spaces (genres and subgenres). These predictions will be produced by a separate system for each dataset, trained without any information from the other sources.
![alt text](http://www.multimediaeval.org/mediaeval2017/acousticbrainz/files/page95-ab_subtask1.jpg)

**Subtask 2: Multi-source Classification.**
This subtask will explore how to combine several ground-truth sources to create a classification system. We will provide the same four test sets, each created from one of the four data sources. Participants will submit predictions for each test set separately, again following each corresponding genre class space. Predictions may be produced by a single system for all datasets or by one system for each dataset. Participants are free to make their own decision, however, about how to combine the training data/ground truth. 
![alt text](http://www.multimediaeval.org/mediaeval2017/acousticbrainz/files/page95-ab_subtask2.jpg)

Participants are expected to submit predictions for both subtasks. If they only want to work on the first subtask, they should submit the same predictions for the second subtask. We allow only five evaluation runs. 
In every single run, participants should submit predictions for both Subtask1 and Subtask2 in two separate files. 


## Data
### Genre annotations
We provide four datasets containing genre/subgenre annotations extracted from different online metadata sources:

- Discogs (community-built database of editorial metadata) 730,849 recordings, ~1.6 genre tags per recording
- AllMusic (online music database with annotations by expert editorial staff) 789,423 recordings, ~1.3 genres per recording, ~3 subgenres per recording
- Last.fm (genre annotations inferred from collaborative tags) 1,031,100 recordings, 22.9 tags per recording (all tags, not just genres)
- Tagtraum (genre annotations inferred from collaborative tags)

All genre datasets are distributed as TSV text files with the following format: 
```
[MusicBrainzId] [genre] [sub-genre]
...
```
MusicBrainzId is an identifier of each particular music recording (music track or song). Each line in the file contain a single genre/sub-genre annotation for a particular MusicBrainzId. There may be multiple genre/subgenre annotations for the same MusicBrainzId. They are stored on separate (consequent) lines in the TSV file. There may be missing subgenre annotations, in this case only genre is provided

For example:

```
MBID1 electronic trip-hop
MBID1 electronic downtempo
MBID2 rock    surf rock
MBID2 pop
```

In this example, there are two songs, the first one is annotated as "trip-hop" and "downtempo", both being subgenres of "electronic". The second is annotated as "surf rock" (subgenre of "rock") and "pop" although no subgenre is provided. 

### Music features
We provide a dataset of music features precomputed from audio for every music recording (track/song) in the genre annotation corpus. We distribute this dataset as an archive, containing a json file for every MusicBrainzId. See an [example json file](http://acousticbrainz.org/a3b8950a-d1f8-49b9-b88f-89f38726f332/low-level/view?n=0). 

The music features are taken from the community-built database [AcousticBrainz](http://acousticbrainz.org). They were extracted using [Essentia](http://essentia.upf.edu), an open-source library for music audio analysis.

Music features provided in the json files are grouped into categories, low-level, rhythm, and tonal, and are [explained here](http://essentia.upf.edu/documentation/streaming_extractor_music.html#music-descriptors).


<Describe the data and include detailed information about the format and how it is to be used (or not to be used) in the task>
 
## Development Data
<Add the directions on how to access the development data.>
 
## Test Data
<When the test set is released, and the directions on how to access the test set.>
 
## Evaluation Methodology and Metrics

For evaluation, we will use standard measures for classification adapted to our setting. The task is multi-label and it uses a two-level hierarchy, so we will mainly employ hierarchical versions of Precision (hP), Recall (hR) and F-measure (hF). In particular, for each track we will compute hP, hR and hF of the predicted genres, which will be macro-averaged (hF will be the main evaluation measure). This will allow us study expected performance for a new track. In addition, for each genre we will compute binary (non-hierarchical) P, R and F of the tracks for which the genre was predicted, again macro-averaging. This will allow us to study possible biases across genres.

The evaluation script will be published on in the first week of May, 2017.

<Add the exact information about how the task will be evaluated. Participants need to know exactly how their runs will be ranked.>
 
## Run submission

Submissions should follow the same genre annotation format (see Data section)

<Please specify the format in which the run submission file should be created. Later, here you will also add the official instructions on run submission on Github, which are still being created.>
 
 
## Working Notes and Overview Paper
Please follow the general instructions for the working notes paper. Remember to cite the task overview paper in your working notes paper. A draft version of that paper is available here: <Link to be added when the test data is released>
 
## Recommended Reading
[1] Porter, A., Bogdanov, D., Kaye, R., Tsukanov, R., Serra, X. Acousticbrainz: a community platform for gathering music information obtained from audio. In Proceedings of the 16th International Society for Music Information Retrieval Conference. Málaga, Spain, 2015, 786-792.

[2] Bogdanov, D., Wack, N., Gómez, E., Gulati, S., Herrera, P., Mayor, O., Roma, G., Salamon, J., Zapata, J., Serra, X. ESSENTIA: an audio analysis library for music information retrieval. In Proceedings of the 14th International Society for Music Information Retrieval Conference. Curitiba, Brazil, 2013, 493-498.

[3] Porter, A., Bogdanov, D., Serra, X. Mining metadata from the web for AcousticBrainz. In Proceedings of the 3rd International workshop on Digital Libraries for Musicology. New York, USA, 2016, 53-56. ACM.

[4] Silla, C.N., Freitas, A. A. A survey of hierarchical classification across different application domains. Data Mining and Knowledge Discovery, 2011, 22(1-2), 31-72.

[5] Kiritchenko S., Matwin S., Famili A.F. Functional annotation of genes using hierarchical text categorization. In Proceedings of the ACL workshop on linking biological literature, ontologies and databases: mining biological semantics. 2005.

[6] Schreiber, H. Improving genre annotations for the million song dataset. In Proceedings of the 16th International Society for Music Information Retrieval Conference. Málaga, Spain, 2015, 242-247.

[7] Pachet, F., & Cazaly, D. A taxonomy of musical genres. In Content-Based Multimedia Information Access, RIAO 2000, volume 2, 1238-1245. 

## Task Organizers
- Dmitry Bogdanov, Music Technology Group, Universitat Pompeu Fabra, Spain (first.last @upf.edu)
- Alastair Porter, Music Technology Group, Universitat Pompeu Fabra, Spain (first.last @upf.edu)
- Julián Urbano, Music Technology Group, Universitat Pompeu Fabra, Spain
- Hendrik Schreiber, Tagtraum Industries Incorporated, USA 

