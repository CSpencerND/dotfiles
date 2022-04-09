#!/usr/bin/env python

import praw
from re import search
from datetime import datetime

# from pprint import pprint as pp


def get_subreddit():
    reddit = praw.Reddit(
        client_id="vBZwsGjgZec62NuWA70soA",
        client_secret="Xkr15O86p5xtLLo3wWsbUyA3OHS1tg",
        user_agent="aesgir",
    )
    return reddit.subreddit("OnePiece")


def get_data(one_piece):
    data = {}

    for submission in one_piece.hot(limit=5):
        if submission.spoiler:
            match_obj = search("[0-9][0-9][0-9][0-9]", submission.title)
            if match_obj:
                data["chapter"] = int(match_obj.group())
                data["text"] = submission.selftext

        if submission.link_flair_text == "Current Chapter":
            match_obj = search("[0-9][0-9][0-9][0-9]", submission.title)
            if match_obj:
                data["current_chapter"] = int(match_obj.group())

    return data


def get_day():
    return datetime.now().strftime("%A")


def main():
    # one_piece = get_subreddit()
    # data = get_data(one_piece)
    # chapter = data["chapter"]
    # current_chapter = data["current_chapter"]
    # next_chapter = current_chapter + 1
    # text = data["text"]

    # if "RAWS" in text:

    print(get_day())

    # full color etc for current chapter
    # expire on friday with greyed out next chapter
    # link for spoiler comes up colored in with hyphen RAWS greyed out
    # then RAWS ready gets colored


if __name__ == "__main__":
    main()
