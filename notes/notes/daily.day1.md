---
id: ao8i6lect1cwr11b2f146gz
title: Day 1
desc: ''
updated: 1669915466357
created: 1669903400194
---
## Notes on the task
I definitely overengineered this one.
Given that the task contained the line:
```
In the example above, this is 24000 (carried by the fourth Elf)
```
I implemented my solution in such a way that both the quantity and the index of the elf can be calculated. However, the problem never actually asked for the index, just for the quantity.

My solution involved sorting all elves by their total quantity, which is overkill for the problem. I did this partly because it allows for a cleaner-looking implementation, but also in order to allow extendability.

In retrospect, a more efficient way to do this would be to update the `addElfInOrderToElfList()` method to take a parameter for the maximum number of entries, so that the search through the list of elves is cut short if the index exceeds this maximum number.

Finally, my `main()` method was intentionally inefficient, in order to keep a clean separation between a working solution for the first part of the problem and the second part of the problem. Optimisation could definitely be made by calling `findOrderedElfList(filename)` only once and then passing it to two separate methods, rather than having it called once in both `solvePuzzlePartOne()` and `solvePuzzlePartTwo()`. But, as I said, I wanted to keep the two solutions independent within the `main()` body.

## Other miscellaneous notes

I'm going to start keeping a separate "optimised" branch, so that I can revisit the tasks after completion and improve them.