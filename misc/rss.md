# RSS & NEWSBOAT

![RSS Logo](./img/rss.png)

Notes on [this video by Luke Smith](https://youtu.be/dUFCRqs822w).

You can get information from your favorite channel but without the need to use
your web browser.

They have an RSS feed, you have an RSS feed reader that looks at that URL and
updates based on that.

E.g., [https://lukesmith.xyz/index.xml](https://lukesmith.xyz/index.xml).

NEWSBOAT is a terminal client for viewing RSS feeds. You can scroll through the
entries, each one of them is an XML file. Each of them is viewed as a unit.

The config is located in `~/.newsboat/config`, [here's
Luke's](https://github.com/LukeSmithxyz/voidrice/blob/master/.config/newsboat/config):

```
#show-read-feeds no
auto-reload yes

external-url-viewer "urlscan -dc -r 'linkhandler {}'"

bind-key j down
bind-key k up
bind-key j next articlelist
bind-key k prev articlelist
bind-key J next-feed articlelist
bind-key K prev-feed articlelist
bind-key G end
bind-key g home
bind-key d pagedown
bind-key u pageup
bind-key l open
bind-key h quit
bind-key a toggle-article-read
bind-key n next-unread
bind-key N prev-unread
bind-key D pb-download
bind-key U show-urls
bind-key x pb-delete

color listnormal cyan default
color listfocus black yellow standout bold
color listnormal_unread blue default
color listfocus_unread yellow default bold
color info red black bold
color article white default bold

browser linkhandler
macro , open-in-browser
macro t set browser "qndl" ; open-in-browser ; set browser linkhandler
macro a set browser "tsp yt-dlp --embed-metadata -xic -f bestaudio/best --restrict-filenames" ; open-in-browser ; set browser linkhandler
macro v set browser "setsid -f mpv" ; open-in-browser ; set browser linkhandler
macro w set browser "lynx" ; open-in-browser ; set browser linkhandler
macro d set browser "dmenuhandler" ; open-in-browser ; set browser linkhandler
macro c set browser "echo %u | xclip -r -sel c" ; open-in-browser ; set browser linkhandler
macro C set browser "youtube-viewer --comments=%u" ; open-in-browser ; set browser linkhandler
macro p set browser "peertubetorrent %u 480" ; open-in-browser ; set browser linkhandler
macro P set browser "peertubetorrent %u 1080" ; open-in-browser ; set browser linkhandler

highlight all "---.*---" yellow
highlight feedlist ".*(0/0))" black
highlight article "(^Feed:.*|^Title:.*|^Author:.*)" cyan default bold
highlight article "(^Link:.*|^Date:.*)" default default
highlight article "https?://[^ ]+" green default
highlight article "^(Title):.*$" blue default
highlight article "\\[[0-9][0-9]*\\]" magenta default bold
highlight article "\\[image\\ [0-9]+\\]" green default bold
highlight article "\\[embedded flash: [0-9][0-9]*\\]" green default bold
highlight article ":.*\\(link\\)$" cyan default
highlight article ":.*\\(image\\)$" blue default
highlight article ":.*\\(embedded flash\\)$" magenta default
```

You put the URLs to RSS feeds to `/home/$USER/.newsboat/urls`:

```bash
https://lukesmith.xyz/index.xml
```

These are all the feeds your RSS client is looking at. You can tag links at the
end of lines:

```bash
https://lukesmith.xyz/index.xml "luke"
```

You can then search by that tag in newsboat by pressing `t`.

If an feed doesn't have a good name, you can rename with `"-new-name"`:

```bash
https://lukesmith.xyz/index.xml "luke" "~Luke Smith Blog"
```

Since a terminal client doesn't show inline images by default, you can open RSS
feeds with a url viewer, in this case it's `urlscan` with `linkhandler`.

```bash
pacman -S urlscan
```

[`$HOME/.local/bin/linkhandler`](https://gitlab.com/LukeSmithxyz/voidrice/-/blob/master/.local/bin/linkhandler):

```bash
#!/bin/sh

# Feed script a url or file location.
# If an image, it will view in nsxiv,
# if a video or gif, it will view in mpv
# if a music file or pdf, it will download,
# otherwise it opens link in browser.

if [ -z "$1" ]; then
	url="$(xclip -o)"
else
	url="$1"
fi

case "$url" in
	*mkv|*webm|*mp4|*youtube.com/watch*|*youtube.com/playlist*|*youtube.com/shorts*|*youtu.be*|*hooktube.com*|*bitchute.com*|*videos.lukesmith.xyz*|*odysee.com*)
		setsid -f mpv -quiet "$url" >/dev/null 2>&1 ;;
	*png|*jpg|*jpe|*jpeg|*gif|*webp)
		curl -sL "$url" > "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")" && nsxiv -a "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 & ;;
	*pdf|*cbz|*cbr)
		curl -sL "$url" > "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")" && zathura "/tmp/$(echo "$url" | sed "s/.*\///;s/%20/ /g")"  >/dev/null 2>&1 & ;;
	*mp3|*flac|*opus|*mp3?source*)
		qndl "$url" 'curl -LO'  >/dev/null 2>&1 ;;
	*)
		[ -f "$url" ] && setsid -f "$TERMINAL" -e "$EDITOR" "$url" >/dev/null 2>&1 || setsid -f "$BROWSER" "$url" >/dev/null 2>&1
esac
```

All the macros are preceded by commas, to open a page in your browser: `,,`. To
open a video, use `,v` etc.

You can set a setting `auto-reload yes` to automatically load every feed when
you open `newsboat`. You can download an RSS feed by pressing `r` or `R` for
all of them. Or you can set up a `cron` job:

```bash
*/20 * * * * /usr/bin/newsboat -x reload
```

Every 20 minutes, it reloads (downloads all the new URLs and stuff).

If you want a YouTube feed, you have to use the following format:

```bash
https://www.youtube.com/feeds/videos.xml?channel_id=ID "yt"
```

To get the ID, right click -> view page source -> search for "channelid":

```bash
https://www.youtube.com/feeds/videos.xml?channel_id=UC2eYFnH61tmytImy1mTYvhA "yt" "luke smith"
```

So, to view a video from your favorite channel:

1. Add it to `.newsboat/urls`
1. Select the channel
1. Navigate to the video (don't select it)
1. Press `,v`
1. Your favorite video will be opened with `mpv`. :)

You could set up automatic channel id extraction with `youtube-viewer`, but I'm
not sure it works anymore (*try it out anyway*). You need to be able to:

1. Extract channel ID from a YouTube channel URL
1. Extract channel ID from a YouTube video URL

You could do the same thing with `twitrss`, but it doesn't work anymore either.
