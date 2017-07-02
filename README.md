# OTF2WOFF Service

## About

An OS X service to convert OTF to WOFF files and vice versa.

This is a wrapper around the WOFF sample code released in 2009 by Jonathan Kew (see <https://people-mozilla.org/~jkew/woff/>). Jonathans code does all the heavy lifting; this project adds little more than the boilerplate stuff required for an OS X service. 

It was originally written in 2011 to help some then co-workers with their daily duties. The slightly unusual form of a standalone OS X service resulted from me not being really that interested in web fonts but still wanting to learn something new along the way – the OS X services API, in this case. 

Over the years the project sunk into oblivion – until 2017, when a request for service bundle came in. Instead of just forgetting about it again, it decided to slightly dust it off and put it here.

Given the age and the original motivation this is not recommended as an example of how to do modern Objective-C or Cocoa code. _TRIGGER WARNING: This project is non-ARC (yes, memory is managed manually), passes C function pointers as arguments and has absolutely no Swift code or cocoa pods. May be harmful to hipsters._

## Installation

Compiled versions are available from [releases](https://github.com/fluthaus/OTF2WOFFService/releases), should work from OS X 10.6 Snow Lepard up to the latest version of macOS (10.13 Developer Beta 2, at the time of this writing). To install:

1. Download and unzip. Copy `OTF2WOFF.service` to `/Library/Services` or `~/Library/Services`, creating the `Services` directory if necessary (you may have to press `Alt` or `Shift` while in the Finder `Go` menu to get access to the user domain `Library` folder)

2. Depending on your version of OS X you may have to manually activate the service:   
a) open `System Preferences` -> `Keyboard` -> `Shortcuts`   
b) in the left column select `Services`   
c) in the right column find and activate `Convert to WOFF` and/or `Convert to OTF`  
d) and/or under some circumstances: log out and back in again

## Usage

In the Finder, select an OTF or WOFF file, and choose `Convert to WOFF` or `Convert to OTF` from `Finder` -> `Services` or the context menu.

## License

Licensed under the GNU GPLv3.
