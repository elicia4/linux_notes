# `wal`

[***Table of Contents***](/README.md)

From `tldr wal`: create color schemes based on the dominant colors of a
wallpaper.

Preview color scheme:

```bash
wal --preview image.png
```

Create color scheme from an image, set the image as the wallpaper:

```bash
wal -i image.png
```

Only set the terminal colors (skip setting the desktop wallpaper):

```bash
wal -i image.png -n
```

Only set the wallpaper (skip setting the terminal colors):

```bash
wal -i image.png -s
```

Create a light color scheme:

```bash
wal -i image.png -l
```

Adjust the saturation of the color scheme (0.0 - 1.0):

```bash
wal -i ~/Pictures/Wallpapers/autumn_birch_forest.jpg --saturate 1
```

Restore the previously generated color scheme and wallpaper (doesn't work on my
machine):

```bash
wal -R
```
