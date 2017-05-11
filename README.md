# AcousticBrainz Genre Task 2017: Content-based music genre recognition from multiple sources
## Announcements
- May 11: It took us extra time to process and organize our very large amounts of data. We are almost ready to release development and testing datasets within a few days!

## Task schedule
- **Development and testing datasets will be released on May 1, 2017**
- June: Release of a baseline approach
- May-Mid-August: Work on algorithms
- Mid-August: Submit runs
    - 14 August: Run submission
    - 21 August: Results returned to participants
- Early September: Working notes paper due
- 13-15 September MediaEval 2017 Workshop in Dublin
 
## Task description
This task invites participants to predict genre and subgenre of unknown music recordings (songs) given automatically computed features of those recordings. We provide a training set of such audio features taken from the AcousticBrainz database and genre and subgenre labels from four different music metadata websites. The taxonomies that we provide for each website vary in their specificity and breadth. Each source has its own definition for its genre labels meaning that these labels may be different between sources. Participants must train model(s) using this data and then generate predictions of genre and subgenre labels for a test set. 

Participants will be given four development datasets. All proposed models will be evaluated on four testing datasets in two subtasks:

- Subtask 1: consider each set of genre annotations individually to generate predictions. This subtask serves as a baseline for Subtask 2.
- Subtask 2: combine sources together to generate predictions

Participants are expected to create models and submit their predictions for both subtasks. In the case they only want to work on Subtask 1, the same predictions will be used for evaluation in the subtask 2.


In both tasks participants must create a system that uses provided music features as an input and predicts genre labels as an output.

**Subtask 1: Single-source Classification.** 
This subtask will explore conventional systems each one trained on a single dataset. Participants will submit predictions for the test set of each dataset separately, following their respective class spaces (genres and subgenres). These predictions will be produced by a separate system for each dataset, trained without any information from the other sources.

![alt text](img/ab_subtask1.jpeg)

**Subtask 2: Multi-source Classification.**
This subtask will explore how to combine several ground-truth sources to create a classification system. We will provide the same four test sets, each created from one of the four data sources. Participants will submit predictions for each test set separately, again following each corresponding genre class space. Predictions may be produced by a single system for all datasets or by one system for each dataset. Participants are free to make their own decision, however, about how to combine the training data/ground truth.

![alt text](img/ab_subtask2.jpeg)

Participants are expected to submit predictions for both subtasks. If they only want to work on the first subtask, they should submit the same predictions for the second subtask. We allow only five evaluation runs. 
In every single run, participants should submit predictions for both Subtask1 and Subtask2 in two separate files. 


See the complete task description here: http://www.multimediaeval.org/mediaeval2017/acousticbrainz/index.html

## Data
### Genre annotations
We provide four datasets containing genre/subgenre annotations extracted from four different online metadata sources. Two of our sources (**AllMusic** and **Discogs**) are online editorial metadata databases maintained by music experts and enthusiasts. These sources contain explicit genre/subgenre annotations following a genre taxonomy predefined by experts. Two other sources (**Lastfm** and **Tagtraum**) are collaborative music tagging platforms with large amounts of weak genre labels provided by their users. We have automatically inferred genre/subgenre taxonomy and annotations from these tags following the algorithm proposed in [6].  

Importantly, all our annotations are multi-label. There may be multiple genre and subgenre annotations for the same music recording. It it guaranteed that each recording has at least one genre label, while subgenres are not always present. 

All four genre datasets are distributed as TSV files with the following format: 
```
[RecordingID] [ReleaseGroupID] [genre or subgenre label] ...
```

A real data example:
```
4d7ec57e-e0fa-42be-be93-592bcba9fe2b    3518b072-a066-41b6-b7f1-d8e66b04880f    metal   metal---heavymetal      metal---progressivemetal        rock    rock---progressiverock
73274526-a840-4a51-b496-09fb94bf9360    b06eb8c1-4fae-4034-9a22-64fb2b37166f    country country---countryfolk   folk
1a09500c-5a08-4381-9fcb-cb8ef0aed520    55a0b305-29a2-4120-99d6-2edca519cc8d    soul
71a96555-5cd7-4062-9570-fb1921bab2f9    c6f1ff2d-d295-4f28-9161-559c3370cec9    pop     pop---ballad
728f0f0e-1b7c-487a-ad0b-f5888d637ac6    1199fd4e-4125-45f0-88a5-2865c9d10a20    electronic      electronic---ambient    instrumental    rock    rock---spacerock
```

RecordingID is a [MusicBrainz identifier](https://musicbrainz.org/doc/MusicBrainz_Identifier) of each particular music [recording](https://musicbrainz.org/doc/Recording) (a music track or song). Each line corresponds to a particular RecordingID and contains all its ground-truth genre and subgenre labels. To distinguish between genre and subgenre labels, subgenre strings are compound and contain ```---``` as a separator between a parent genre and a subgenre name. For example, ```rock```, ```electronic```, ```jazz``` and ```hip hop``` are genres, while ```electronic---ambient```, ```rock---singersongwriter``` and ```jazz---latinjazz``` are subgenres. 

Additionally, we provide ReleaseGroupID of a recording, which is a MusicBrainz identifier of a [release group](https://musicbrainz.org/doc/Release_Group) (an album, single, or compilation) it belongs to. This data may be useful, if one wants to avoid a potential "album effect" [8], which consists in overestimation of the performance of a classifier when a test set contains music tracks from the same albums as the training set.


### Music features
We provide a dataset of music features precomputed from audio for every music recording from the four genre ground truths. The dataset can be downloaded as  an archive. It contains a json file with music features for every ReleaseID. See an [example json file](http://acousticbrainz.org/a3b8950a-d1f8-49b9-b88f-89f38726f332/low-level/view?n=0).

All music features are taken from the community-built database [AcousticBrainz](http://acousticbrainz.org) and were extracted from audio using [Essentia](http://essentia.upf.edu), an open-source library for music audio analysis.
They are grouped into categories, low-level, rhythm, and tonal, and are [explained in details here](http://essentia.upf.edu/documentation/streaming_extractor_music.html#music-descriptors). Only statistical characterization of time frames is provided (bag of features), no frame data is available.

 
## Development Data
Download links

- music features: **to be announced on May 15**
- ground-truth genre annotations:
    - AllMusic: **to be announced on May 15**
    - Discogs: **to be announced on May 15**
    - Lastfm: **to be announced on May 15**
    - Tagtraum: **to be announced on May 15**

## Test Data
Download links

- music features: **to be announced on May 15**

Test data contains music features for recordings with anonymized RecordingIDs. To avoid a potential album effect [8], no recording in the test set contains music from the same release groups as the recordings in the train set.  


## Evaluation Methodology and Metrics

Download evaluation script: (**to be announced in mid-May**). 

(TO BE UPDATED)

There will be a separate evaluation on both genre- and subgenre-levels for each ground-truth dataset (AllMusic, Discogs, Lastfm, Tagtraum). In both cases, the main metric will be F-score across recordings. Additionally, we will compute the F-score for each genre/subgenre label.

The ground truth does not necessarily contain subgenre annotations for some recordings. Therefore, only recordings containing subgenres will be considered for the evaluation on the subgenre level.

 
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

[8] Flexer, A., & Schnitzer, D. (2009). Album and Artist Effects for Audio Similarity at the Scale of the Web. In Proceedings of the 6th Sound and Music Computing Conference. Porto, Portugal.



## Task Organizers
- Dmitry Bogdanov, Music Technology Group, Universitat Pompeu Fabra, Spain (first.last @upf.edu)
- Alastair Porter, Music Technology Group, Universitat Pompeu Fabra, Spain (first.last @upf.edu)
- Julián Urbano, Music Technology Group, Universitat Pompeu Fabra, Spain
- Hendrik Schreiber, Tagtraum Industries Incorporated, USA 

