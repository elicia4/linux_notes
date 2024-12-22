# `split`

[***Table of Contents***](/README.md)

It can be used to split a file into a series of smaller files:

```bash
echo "Hello World!
This message will
be split into
multiple files." > example.txt

split -l 1 example.txt
ls
cat xaa xab xac xad
```

Say you have a file `file.zip` that you want to send as an e-mail attachment.
You can only send attachments that are up to 5 MB in size, but your file is
almost 15 MB. You can use `split -b` to split the file into three smaller ones:

```bash
split -b 5MB file.zip
ls -l
```

On the receiving end, a person can use `cat` to reconstruct the file:

```bash
cat xaa xab xac > restored_file.zip
```

The hash checksum shows a match for both files:

```bash
md5sum *.zip
```

You can also add a prefix to each file part:

```bash
split -b 5MB file.zip 'part-'
ls -l
```

`-b` supports all the standard unit sizes:

```bash
man split
# The SIZE argument is an integer and optional unit (example: 10K is 10*1024).  
# Units are K,M,G,T,P,E,Z,Y,R,Q (powers of 1024) or KB,MB,... (powers of 1000).  
# Binary prefixes can be used, too: KiB=K, MiB=M, and so on.  
```

More specifically:

```bash
info split
# ‘-b SIZE’
# Put SIZE bytes of INPUT into each output file.  
# SIZE may be, or may be an integer optionally followed by, 
# one of the following multiplicative # suffixes:
# 
# - ‘b’  =>            512 ("blocks")
# - ‘KB’ =>           1000 (KiloBytes)
# - ‘K’  =>           1024 (KibiBytes)
# - ‘MB’ =>      1000*1000 (MegaBytes)
# - ‘M’  =>      1024*1024 (MebiBytes)
# - ‘GB’ => 1000*1000*1000 (GigaBytes)
# - ‘G’  => 1024*1024*1024 (GibiBytes)
# 
# and so on for ‘T’, ‘P’, ‘E’, ‘Z’, ‘Y’, ‘R’, and ‘Q’. 
# Binary prefixes can be used, too: ‘KiB’=‘K’, ‘MiB’=‘M’, and so on.
```

`-n` can be used to split a file into a target number of equal parts:

```bash
split -n 8 file.zip
```

`-l` will split text files by line quantity:

```bash
split -l 3 foo.txt
```

The `--filter` flag allows you to filter each output file through a shell
command:

```bash
split -l 3 --filter='gzip > $FILE.gz' foo.txt
```
