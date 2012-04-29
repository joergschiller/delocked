delocked
========

Ruby tool for decrypting files that were encrypted by some sort of ransomware.

Usage
-----

Find the original version of an encrypted file (example pictures from windows are fine).

```./getkey.rb --original Autumn\ Leaves.jpg --locked locked-Autumn\ Leaves.jpg.geus --key keyfile.bin```

You will find your key in ```keyfile.bin```.
