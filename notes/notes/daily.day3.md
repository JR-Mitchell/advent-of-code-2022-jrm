---
id: bda5l32wntb5l5ndgv8lla7
title: Day 3
desc: ''
updated: 1670057803945
created: 1670057771401
---
## Notes on the challenge
### Part 1
We need to find a duplicate character between two strings.
Fortunately, I think there might be an easy way to do this.
If we employ pattern matching, using the first string within square brackets as a captured pattern (e.g `vJrwpWtwJgWr` becomes the pattern `([vJrwpWtwJgWr])`), we should then be able to search for this in the second string and find the common character.

Once we have the matching character, it is relatively trivial to convert to the priority value.
I am however choosing to use an `if / else` here, since the bytes for `A-Z` are lower than the bytes from `a-z`.

### General notes
I've also decided on this day to start formalising my tests.
Previously, I've been running my code with an optional param allowing a different filename to be passed in, so that I can manually check my logic against the example data. This time, I'm not doing that, but explicitly running tests against the example data before solving my input, with the expected values for the example data hardcoded.

Also, since it seems that basically every challenge will involve reading in lines of a file, I've reworked things slightly to add a method which will reduce code duplication in reading and processing a file line-by-line.

### Part 2
Now, we are comparing the characters in consecutive lines.
Fortunately, similar pattern matching will help us out here.
If we use Lua's `gmatch` to get all occurring matches, we can find the common characters between lines 1 and 2.
Then, we can use this as a pattern for line 3, to find the character that matches all three.