---
id: u9c5jzx7b16mnz58r7us5rn
title: Day 5
desc: ''
updated: 1670264213047
created: 1670263772200
---
## Notes on the challenge
I'm starting this one quite late in the day - but, I looked at it during my lunch break, so I've had some time to consider part 1 at least.

### Part 1
The input data looks quite interesting to parse, but I'm sure some pattern matching will do it.
Then, in order to execute the movements, I think all I should need is some tables as arrays that I can pop and push to.

### Sidenote on Lua data structures and Teal
Lua only has one data structure - the table.
This is essentially a hashmap, where keys of any type map to values of any type.

However, the `table` library has some operations used to give a subclass of `table`s the semblance of acting like an array.
Such tables are defined as tables where the keys are all the `integer` values from `1` to some integer `n`.

Teal allows us to explicitly type a table as an array using the notation `{Type}`, meaning an array of items of type `Type`.

For our purposes, the `table` library includes the methods `table.insert()` and `table.remove()`.

### Things to watch out for when parsing
A few things jump out at me about the input data.
Firstly, we don't know how tall the tallest stack of input data will be.
Secondly, we don't know how many stacks there are.

In this case, I'm going to cheat a little and peek my input data before starting.
My input data contains 9 stacks - which is good, since it means we don't have to consider how this data might be formatted if the stack numbers start becoming double-digit.

Another issue is how to handle rows where only some of the stacks have items in them.
If we use `string.gfind("%[[A-Z]%]")`, we won't get any information about which stack the item is in.
In other words, with this call, all three of `"[D] [B]    "`, `"[D]     [B]"` and `"    [D] [B]"` would output the same.
However, the pattern `"[ %[][A-Z ][ %]]"` will successfully match the three inbetween spaces, giving us the correct position.
I, however, am a sucker for symmetry and aesthetics, so I'm going to format this pattern as `"[ %[ ][ A-Z ][ %] ]"` for no other reason than that it looks nicer.

I've just realised this pattern won't work.
For an input row like
`"[D]         [B]"`
This is 4 columns with values `D`, `nil`, `nil` and `B`. However, because there are 9 internal spaces, it will parse as `D`, `nil`, `nil`, `nil` and `B`.
We can fix this by adding optional spaces to the start and end:
`" ?[ %[ ][ A-Z ][ %] ]" ?`

Another thing that I didn't consider is that the first number in a move command - i.e `"move a from b to c"` - could be more than a single digit.

### Part 2
Part 2 should be fairly simple to implement.
We just need to change the `executeMove()` method to retain order when moving.