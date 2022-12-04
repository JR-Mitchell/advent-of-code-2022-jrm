---
id: 3c1t5jnf587e5a3kku171z5
title: Day 4
desc: ''
updated: 1670152262508
created: 1670146973839
---
## Notes on the challenge
### Part 1
There is an important caveat to note for this puzzle.
The example data only contains single digit numbers, but the question states "This example list uses single-digit section IDs to make it easier to draw; your actual list might contain larger numbers".
Therefore, we'll have to ensure that our method can correctly solve multi-digit data - perhaps by coming up with our own second set of example data to test with.

Leaving that aside, for two pairs `a-b` and `c-d`, we know that one pair fully contains the other if `a <= b && c >= d`, or if `a >= b && c <= d`.

### Larger numbers
It's a good job I created a bonus set of test data - I ran a test on this data and it failed.
The pattern I was initially using to match the data was:

`([%d+])%-([%d+]),([%d+])%-([%d+])`

Which is incorrect, as the `+` is being treated as one of the possible characters, rather than a modifier on `%d` stating "one or more".
The correct pattern is:

`(%d+)%-(%d+),(%d+)%-(%d+)`

With that fixed, I was able to solve for the real input in part 1.