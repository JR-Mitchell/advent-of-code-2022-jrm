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

For reference, my bonus set of test data was:
```
20-40,60-80
92-93,94-95
155-197,167-189
29-88,39-87
60-65,40-69745
21-69,4371-88523
```

It's a good job I created this bonus set of test data - I ran a test on this data and it failed.
The pattern I was initially using to match the data was:

`([%d+])%-([%d+]),([%d+])%-([%d+])`

Which is incorrect, as the `+` is being treated as one of the possible characters, rather than a modifier on `%d` stating "one or more".
The correct pattern is:

`(%d+)%-(%d+),(%d+)%-(%d+)`

With that fixed, I was able to solve for the real input in part 1.

### Part 2
Now, we're looking for pairs that overlap *at all*, rather than overlapping completely.
This changes our condition on two pairs `a-b` and `c-d` to `(a <= c && b >= c) || (a <= d && b >= d)`.

### The bonus test saves me once again
The bonus test was failing, with the expected number one larger than the actual so I added log statements to display which lines were returning as overlapping.

I also realised that all of the example code cases that overlap at all were also completely overlapping. So I added an extra line `52-221,183-445` to the bonus test data, to see if I can glean any more information from this.

The offending line was `60-65,40-69745`. This makes sense, since `a > c`, `a < d`, but also `b < d`, suggesting that the above condition is wrong.

In simplest terms, the condition for two ranges to overlap is that there exists some number `n` that can be found in both ranges.
Therefore, it is that there exists some `n` such that `a <= n`, `n <= b`, `c <= n` and `n <= d`.

`a <= n` and `n <= d` => `a <= d`.

`n <= b` and `c <= n` => `c <= b`.

So, is it a sufficient condition `a <= d && c <= b`?
Consider all of the possible cases (I think):
- `b < c` (no overlap) (e.g `2-3,4-5`)
- `a < c, b >= c` (overlap) (e.g `2-6,4-8`)
- `a >= c, a <= d` (overlap) (e.g `5-8,4-7`)
- `a > d` (no overlap) (e.g `6-7,4-5`)

So, by this logic, the condition `a <= d && c <= b` is indeed correct.
Time to update my code - and the puzzle is complete :)