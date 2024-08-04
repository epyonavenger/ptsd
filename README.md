# ptsd (PaintTool Sai Downloader)

This project is a quick and dirty script to download PaintTool Sai, and then fetch updates when they come out. It's mostly targeting version 2 (64-bit), but I may extend it to version 1 and the 32-bit binary as well.

You will still need to purchase and apply your own license files, that's outside the scope of this project.

# Installation

1. Go to Code -> Download Zip
2. Extract it somewhere. _(You can put it into your sai2 folder after it is created if you want to just run it from there in the future.)_

# Usage

Currently, you double-click the `run_me.bat` file in order to launch the Powershell file that does the work. Why? Because I couldn't figure out a pretty universal way to write this in pure batch file.

At present, it will create and populate "C:\sai2" if you don't specify where you want it to create things as an argument. In order to pass an argument, you have to trust the Powershell script, which is a longer write-up.

I will try to include instructions on how to just run the Powershell file directly _(with optional arguments)_, but that involves mucking about with security settings, and I don't love the idea of making anyone less secure if I can help it.

I may also someday try for a rewrite in some other language or some such that does a better job. We'll see.

If you have any problems, feel free to open an issue, but I can't promise I'll be quick on it.
