---
id: vv0j09edl3x10ed20hkwhml
title: Day 6
desc: ''
updated: 1670315465229
created: 1670313495350
---
## Notes on the challenge
Starting this one in the morning.
Though maybe that's an unwise idea.

The input for this is only one line long, and additionally we are provided with multiple test cases.

I finished part 1 relatively quickly, though my work for it was pretty inelegant.

### Part 2
We now need to find a more elegant solution.
I am not willing to hardcode a matching method for 14 elements.

The smarter and faster way to do this is the following:
- Take a list of 14 characters, starting at element 1.
- Compare element 14 with element 13. If they don't match, compare with element 12, and so on.
- If 14 matches with all other elements, do the same starting on element 13.
- If you find that element `m` matches element `n`, then you know that the distinct substring must begin on element `m + 1` at least. So, start again from here.
- If you get down to element `1` in the list, you know you are done.

I will implement this later, when I take a coffee break.