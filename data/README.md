## Data

### Genre Annotations

All four training genre datasets are distributed as TSV files with the following format: 

```
[RecordingID] [ReleaseGroupID] [genre/subgenre label] [genre/subgenre label] ...
```

A real data example:
```
6bb7e980-791c-44b5-9024-cc7c90bc8230    969ebfe8-0786-3ee0-b49b-3005fe653aa4    metal   metal---heavymetal  metal---progressivemetal    rock    rock---progressiverock
92a70a47-98c4-43fd-8b1f-972657f627c3    7378d3cf-a3a9-3fe3-825b-70d6f0230250    country country---countryfolk   folk
c7bee376-0020-461a-90a7-d5af73cfff05    6e652b2f-6f94-47ef-834a-a85d25921fce    soul
93597a3e-cdca-4123-bcf5-343ff8debbe2    47de1259-bdeb-3f11-b612-4976887dca5c    pop pop---ballad
a4d017d4-e75b-4eac-8f46-1b000ef407b0    9b1640de-4eb7-3071-b6a3-1c6f76c1a1b4    electronic  electronic---ambient    electronic---downtempo  pop rock    rock---indie    rock---spacerock
27b7cf35-0238-4316-b2fd-c589a866603a    b6f21355-5e8e-33f7-acbf-03d99e9e90f9    electronic  electronic---bigbeat    electronic---techno
```

Each line corresponds to one [recording](https://musicbrainz.org/doc/Recording) (a music track or song), and contains all its ground-truth genre and subgenre labels. `recordingmbid` is the [MusicBrainz identifier](https://musicbrainz.org/doc/MusicBrainz_Identifier) of the particular recording. To distinguish between genre and subgenre labels, subgenre strings are compound and contain ```---``` as a separator between a parent genre and an actual subgenre name. For example, ```rock```, ```electronic```, ```jazz``` and ```hip hop``` are genres, while ```electronic---ambient```, ```rock---singersongwriter``` and ```jazz---latinjazz``` are subgenres. 

Additionally, we provide `releasegroupmbid` for each recording, which is a MusicBrainz identifier of a [release group](https://musicbrainz.org/doc/Release_Group) (an album, single, or compilation) that it belongs to. This data may be useful if one wants to avoid an "album effect" [4], which consists in potential overestimation of the performance of a classifier when a test set contains music recordings from the same albums as the training set.

Groundtruth files have a header

    recordingmbid   releasegroupmbid    genre1  genre2  ... genren
    
to show that the first two columns contain MusicBrainz IDs, and subsequent columns contain genre annotations. As the number of annotations per recording differ, this header contains as many rows as necessary to provide a header to the row with the most annotations. Additionally, rows with fewer genre annotations are padded with the field separator (a tab) to ensure that all rows have the same number of columns. You should ensure that you remove "empty" annotations if your preferred tool to read these files does not do this automatically.

Genre annotations are ordered alphabetically. There is no correlation between the annotations of two different recordings in the same column.

### Music features

We provide a dataset of music features precomputed from audio for every music recording. The dataset can be downloaded as an archive. It contains a JSON file with music features for every `RecordingID`. See an [example JSON file](http://acousticbrainz.org/a3b8950a-d1f8-49b9-b88f-89f38726f332/low-level/view?n=0).

All music features are taken from the community-built database [AcousticBrainz](http://acousticbrainz.org) and were extracted from audio using [Essentia](http://essentia.upf.edu), an open-source library for music audio analysis [2].
They are grouped into categories (low-level, rhythm, and tonal) and are [explained in detail here](http://essentia.upf.edu/documentation/streaming_extractor_music.html#music-descriptors). Only statistical characterization of time frames is provided (bag of features), no frame-level data is available.

### Development, Validation and Test Data

The **development data** contains:

- **music features for all recordings** in AllMusic, Discogs, Lastfm and Tagtraum datasets (~30GB bz2 archives, 83GB uncompressed JSON files). Each filename corresponds to a ``RecordingID`` (which is a [UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier)). They are split into 8 separate archives according to the first hex digits of their RecordingIDs.
 - Because there is substantial overlap between the Recordings in each dataset, we provide a single series of archives which contain data for all datasets.
 - All archives will uncompress into a directory named `acousticbrainz-mediaeval-train`. Data files are named in the form `54/54551aad-fb76-4e22-8725-fd495c32b155.json`, where the file is inside a subdirectory named by the first two letters of its RecordingId.
 - You may find that the data files have a value in the `metadata.tags.musicbrainz_recordingid` field which is different to the RecordingID used in the filename. [This is to be expected due to Musicbrainz ID redirects](https://musicbrainz.org/doc/MusicBrainz_Identifier).
- **four archives with ground-truth genre annotations** (AllMusic, Discogs, Lastfm, Tagtraum - see format description above)

The **test data** contains **four archives of music features for recordings with anonymized RecordingIDs**. To avoid a potential album effect [4], no recording in the test set contains music from the same release groups as the recordings in the train set.
- Although RecordingIDs are UUIDs, they have been randomly anonymised and do not correspond to any MusicBrainz IDs on musicbrainz.org

The **validation data** contains archives of muic features for recordings and the corresponding ground-truth annotations. This data was used as our test data in the 2017's edition of the task.

All data is compressed with bzip2. Checksums are provided to ensure that you have correctly downloaded the archives.

### Download

The development, validation and test data for Discogs, Lastfm and Tagtraum is publicly available [here](https://drive.google.com/open?id=0B8wz5KkuLnI3RjFYSFY5TkJVU1U).

The development data (genre ground truth), validation and test data for AllMusic requires signing the **Data Usage agreement** by participants. The data will be shared to the participants in personal communication (please, ask the organizers).

The datasets are licensed under CC BY-NC-SA4.0 license, except for data extracted from the AllMusic database, which is released for non-commercial
scientific research purposes only. Any publication of results based on the data extracts of the AllMusic database must cite AllMusic as the source of the data.


### Notes

To give an idea of the scale of the data, we report some statistics for the train datasets.

AllMusic:

- 1353213 recordings by 163654 releasegroups
- 21 genres, 745 subgenres
- 1.33 genres and 3.15 subgenres per recording on average
- [genre/subgenre distribution](https://drive.google.com/open?id=0B9efYsv7Y7gpMzZkUVVjUnItUHM)

Discogs:

- 904944 recordings by 118475 releasegroups
- 15 genres, 300 subgenres
- 1.37 genres and 1.69 subgenres per recording on average
- [genre/subgenre distribution](https://drive.google.com/open?id=0B9efYsv7Y7gpZUFSYjlJaXJhbVk)

Lastfm:

- 566710 recordings by 115161 releasegroups
- 30 genres, 297 subgenres
- 1.14 genres and 1.28 subgenres per recordings on average
- [genre/subgenre distribution](https://drive.google.com/open?id=0B9efYsv7Y7gpRGh6NEdIMVJ3Rk0)

Tagtraum:

- 486740 recordings by 69025 releasegroups
- 31 genres, 265 subgenres
- 1.13 genres and 1.72 subgenres per recording on average
- [genre/subgenre distribution](https://drive.google.com/open?id=0B9efYsv7Y7gpSTZyeXlQREhsOWc)

Genre/subgenre taxonomy and distribution in terms of recordings and releasegroups for all four development datasets are reported [here](../data_stats/).

The datasets are partially intersected. 

Note that the data we provide is very large-scale. It includes a large number of music recordings and many of music features for those recordings. Participants are free to use all of the data to train their systems or only its part.

Please, contact the organizers if you have further questions or need help. 
