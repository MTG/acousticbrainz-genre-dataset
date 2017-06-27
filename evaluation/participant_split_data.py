import argparse
import sys
import os
import csv
import collections
import logging
import random

log = logging.Logger("splitter")
ch = logging.StreamHandler()
ch.setFormatter(logging.Formatter("%(levelname)s - %(message)s"))
log.setLevel(logging.INFO)
log.addHandler(ch)


def _get_all_tags_in_gt(groundtruth):
    tags = set()
    for line in groundtruth:
        tags.update(line[2:])
    return tags


def check_minimum_tags(train, test, minimum_num_tags_train, minimum_num_tags_test):
    """Check that there are no tags in one of train/test but not the other
    Check that tags in train occur at least `minimum_num_tags_train` times in the dataset
    and the same for the test set"""

    all_tags_in_train = _get_all_tags_in_gt(train)
    all_tags_in_test = _get_all_tags_in_gt(test)

    intersection_tags = all_tags_in_train & all_tags_in_test
    union_tags = all_tags_in_train | all_tags_in_test
    # Tags to remove is union-intersection

    log.debug("%s tags in union of train-test", len(union_tags))
    log.debug("%s tags in intersection of train-test", len(intersection_tags))
    tags_to_remove = union_tags - intersection_tags
    log.info("need to remove %s tags which don't appear both train and test", len(tags_to_remove))

    log.debug("counting number of tags in train and test")
    number_tags_train = collections.Counter()
    number_tags_test = collections.Counter()
    for line in train:
        for t in line[2:]:
            number_tags_train[t] += 1
    for line in test:
        for t in line[2:]:
            number_tags_test[t] += 1

    remove_train = [tag for tag, count in number_tags_train.most_common() if count < minimum_num_tags_train]
    remove_test = [tag for tag, count in number_tags_test.most_common() if count < minimum_num_tags_test]
    log.info("removing %s tags from train because there are less than %s", len(remove_train), minimum_num_tags_train)
    log.debug(remove_train)
    tags_to_remove.update(set(remove_train))
    log.info("removing %s tags from test because there are less than %s", len(remove_test), minimum_num_tags_test)
    log.debug(remove_test)
    tags_to_remove.update(set(remove_test))

    log.debug("going to remove these tags")
    log.debug(tags_to_remove)

    train = remove_tags_from_groundtruth(train, tags_to_remove)
    test = remove_tags_from_groundtruth(test, tags_to_remove)

    return train, test


def remove_tags_from_groundtruth(groundtruth, tags):
    """ Remove all tags in `tags` from the groundtruth.
    If a recording has no more tags, remove it from the groundtruth
    """

    log.debug("Removing %s tags from groundtruth", len(tags))

    count = 0
    newgt = []
    for line in groundtruth:
        removed_any = False
        linetags = set(line[2:])
        newtags = linetags - tags

        if newtags:
            newgt.append(line[:2] + sorted(list(newtags)))
        else:
            count += 1
    groundtruth = newgt

    log.debug("completely deleted %s recordings from gt", count)

    return groundtruth


def main(filename, trainsplit, minimum_num_tags_train, rgfilter):
    assert trainsplit <= 100
    assert trainsplit >= 0

    minimum_num_tags_test = minimum_num_tags_train / 2

    rg_to_rows = collections.defaultdict(list)
    releasegroups = set()
    data = []
    log.info("Reading file...")
    with open(filename) as fp:
        r = csv.reader(fp, delimiter="\t")
        header = r.next()
        for l in r:
            data.append(l)
            if rgfilter:
                rg_id = l[1]
                releasegroups.add(rg_id)
                rg_to_rows[rg_id].append(l)

    log.info("Splitting")
    if rgfilter:
        """The releasegroup filter means that we don't want tracks from the same
           releasegroup appearing in both the train and test sets. We do this
           by doing our split on releasegroup ids. This means that the number
           of items in each set won't exactly respect the size split. We
           assume that the number of items in each releasegroup is about the same."""

        releasegroups = list(releasegroups)
        random.shuffle(releasegroups)
        size_train = int(trainsplit / 100. * len(releasegroups))
        rg_train = releasegroups[:size_train]
        rg_test = releasegroups[size_train:]
        train = []
        for rg in rg_train:
            train.extend(rg_to_rows[rg])
        test = []
        for rg in rg_test:
            test.extend(rg_to_rows[rg])
    else:
        random.shuffle(data)
        size_train = int(trainsplit / 100. * len(data))
        train = data[:size_train]
        test = data[size_train:]

    log.info("Split %s items into %s%%-%s%% train/test split of %s and %s items", len(data), trainsplit, 100-trainsplit, len(train), len(test))

    train, test = check_minimum_tags(train, test, minimum_num_tags_train, minimum_num_tags_test)

    train_name, test_name = create_train_test_filenames(filename)
    log.info("Writing train split to %s", os.path.basename(train_name))
    dump_subset(train, train_name)
    log.info("Writing test split to %s", os.path.basename(test_name))
    dump_subset(test, test_name)


def dump_subset(dataset, filename):
    max_genres = find_max_number_of_genres(dataset)
    header = ["recordingmbid", "releasegroupmbid"] + genre_headers(max_genres)
    with open(filename, "w") as fp:
        w = csv.writer(fp, delimiter="\t")
        w.writerow(header)
        w.writerows(dataset)


def create_train_test_filenames(inputfile):
    """Take a filename and return two files with -train and -test inserted before the extension."""
    in_dir = os.path.dirname(inputfile)
    in_file = os.path.basename(inputfile)
    in_name, in_ext = os.path.splitext(in_file)

    train_name = "%s-train%s" % (in_name, in_ext)
    test_name = "%s-test%s" % (in_name, in_ext)

    return train_name, test_name


def find_max_number_of_genres(dataset):
    """Find the largest number of genres in any row in the dataset.
       (used to create a header for the output csv file)
    """
    max_genres = 0
    for line in dataset:
        num_genres = len(line) - 2 # Remove mbid, rgid
        if num_genres > max_genres:
            max_genres = num_genres
    return max_genres


def genre_headers(num_genres):
    """Return a list genre1, genre2, ..., genren to be used in a csv header."""
    return ["genre%s" % n for n in range(1, num_genres+1)]


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Split an AcousticBrainz MediaEval groundtruth file into train/test parts")
    parser.add_argument("datafile", help="Data file to process (probably the 'train' TSV)")
    parser.add_argument("-s", type=int, default=80, help="Percentage size of train set (default: 80)")
    parser.add_argument("-m", type=int, default=20, help="Minimum number of times tags must appear in the training set (default: 20)")
    parser.add_argument("-f", action="store_true", default=False, help="Perform release-group filtering")

    args = parser.parse_args()
    main(args.datafile, args.s, args.m, args.f)
