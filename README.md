# The AcousticBrainz Genre Dataset
A multi-source and multi-label dataset of hierarchical genre annotations.


## Data
The AcousticBrainz Genre Dataset is a large-scale collection of hierarchical
multi-label genre annotations from different metadata sources. It allows researchers to explore how the same music pieces are annotated differently by different communities following their own genre taxonomies, and how this could be addressed by genre recognition systems. With this dataset, we hope to contribute to developments in content-based music genre recognition as well as cross-disciplinary studies on genre metadata analysis.

Genre labels for the dataset are sourced from both expert annotations and crowds, permitting comparisons between strict hierarchies and folksonomies. Music features are available via the [AcousticBrainz](https://acousticbrainz.org/) database.

We provide four datasets containing genre and subgenre annotations extracted from four different online metadata sources. These genre datasets were created using as a source four different music metadata websites. Their genre taxonomies vary in class spaces, specificity and breadth. Each source has its own definition for its genre labels meaning that these labels may be different between sources.

* **AllMusic** and **Discogs** are based on editorial metadata databases maintained by music experts and enthusiasts. These sources contain explicit genre/subgenre annotations of music releases (albums) following a predefined genre namespace and taxonomy. We propagated release-level annotations to recordings (tracks) in AcousticBrainz to build the datasets.

* **Lastfm** and **Tagtraum** are based on collaborative music tagging platforms with large amounts of genre labels provided by their users for music recordings (tracks). We have automatically inferred a genre/subgenre taxonomy and annotations from these labels.

Importantly, annotations in the datasets are multi-label. **There may be multiple genre and subgenre annotations for the same music recording.** It is guaranteed that each recording has at least one genre label, while subgenres are not always present.

The resulting genre metadata is licensed under CC BY-NC-SA4.0 license, except for data extracted from the AllMusic database, which is released for non-commercial scientific research purposes only. Any publication of results based on the data extracts of the AllMusic database must cite AllMusic as the source of the data.

For details on format and contents, please refer to the [data webpage](data/).

Details on the genre/subgenre taxonomies and their distributions  are  reported [here](data_stats/).


## Downloads

- Development and validation datasets are now available on Zenodo ([here](https://zenodo.org/record/2553414) and [here](https://zenodo.org/record/2554044)).
- TODO add URLs for the test set


## Citations
If you use the MediaEval AcousticBrainz Genre dataset or part of it, please cite our ISMIR 2019 overview paper:

```
TODO new reference

Bogdanov D, Porter A, Urbano J, Schreiber H. The MediaEval 2018 AcousticBrainz genre task: Content-based music genre recognition from multiple sources. Paper presented at: MediaEval'18; 2018 Oct 29-31; Sophia Antipolis, France.
```


## Using the dataset for music genre recognition

The dataset can be used within the context of the MGR task to develop systems that **predict genre and subgenre of unknown music recordings (songs) given automatically computed features of those recordings**.

We provide four training sets and four validation sets with all data publicly available,  and four test sets with a hidden ground truth.  The training and validation sets can be used for the evaluation of MGR systems. The test sets do not include a publicly available ground truth and have anonymized MBIDs; they are reserved to be used in future MGR challenges such as MediaEval [2017](https://multimediaeval.github.io/2017-AcousticBrainz-Genre-Task/)/[2018](https://multimediaeval.github.io/2018-AcousticBrainz-Genre-Task/). Nevertheless, it is possible to run an evaluation on the test sets upon request.

Using our data for this task may serve as an example of the development and validation of automatic annotation algorithms on complementary datasets with different taxonomies and coverage.


## Task Organizers
- [Dmitry Bogdanov](https://dbogdanov.github.io/), Music Technology Group, Universitat Pompeu Fabra, Spain (`first.last @upf.edu`)
- [Alastair Porter](https://www.dtic.upf.edu/~aporter/), Music Technology Group, Universitat Pompeu Fabra, Spain (`first.last @upf.edu`)
- [Julián Urbano](https://julian-urbano.info/), Multimedia Computing Group, Delft University of Technology, Netherlands
- [Hendrik Schreiber](http://www.tagtraum.com/), tagtraum industries incorporated, USA


## Acknowledgments

[AcousticBrainz](https://acousticbrainz.org/), [Audio Commons](http://audiocommons.org/), [tagtraum industries](http://www.tagtraum.com/) and [TROMPA](https://trompamusic.eu/)

<img src="img/audio-commons-icon_64px.jpg" height="64" hspace="20"><img src="img/acousticbrainz_logo_short_horizontal.png" height="64" hspace="20"><img src="img/tagtraum_logo_small_w_g@2x.png" height="64" hspace="20"><img src="img/trompa-logo.png" height="64" hspace="20">

This research has received funding from the European Union's Horizon 2020 research and innovation programme under grant agreements No 688382 (AudioCommons) and 770376-2 (TROMPA), as well as the Ministry of Economy and Competitiveness of the Spanish Government 
(Reference: TIN2015-69935-P).
