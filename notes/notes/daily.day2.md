---
id: gbk8osgp3k09qbsaizgqb3y
title: Day 2
desc: ''
updated: 1670017096838
created: 1670008702998
---
## General notes
I'm starting this one a lot later in the day than yesterday.
I did however get a chance to look at the problem in my lunch-break.

## Notes on the challenge
### Arithmetic in part 1
Since the challenge uses characters (`ABC` and `XYZ`) for the three possible states per player (rock, paper and scissors), I think it's easiest to convert to integers first.
I want to avoid using messy if/else statements, and see if I can instead use arithmetic to calculate the scores.
We already are provided with a map - we are told Rock -> `1`, Paper -> `2` and Scissors -> `3`, in context of the score value for playing it.

So, when it comes to determining a round's victory, we know that, modulo 3, each number is beaten by the number above it.
I.e, you lose if you play `1` and they play `2`, if you play `2` and they play `3`, or if you play `3` and they play `1`.

It seems like the modulo may come in handy here.
`2 - 1 = 1`, `3 - 2 = 1` and `1 - 3 = -2`.
Lua's modulo operation works in such a way that `-2 % 3 = 1`.
Therefore, we know that, if `t` represents their play and `y` represents your play, then if `(t - y) % 3 = 1`, they have beaten you.
Similarly, it is trivial that if `(t - y) % 3 = 0`, it is a draw (in this case, `t = y`).
Finally, we can show that if `(t - y) % 3 = 2`, you have won - this will occur for `1 - 2 = -1`, `2 - 3 = -1`, and `3 - 1 = 2`.

A simple method that calculates your victory score, then needs to map `1 -> 0`, `0 -> 3` and `2 -> 6`.
We can construct a 2nd order polynomial that meets this criteria.
Since 1 is a root, this will be in the form:

`f(x) = (x - 1)(ax + b)`

Plugging in our values:

`f(0) = -b` => `b = -3`

`f(2) = 2a + b = 2a - 3` => `a = 4.5`

Giving us `f(x) = (x - 1)(9x - 6)/2`

Therefore, the victory score is calculable using the expression:
`((t - y) % 3 - 1) * (9 * (t - y) % 3 - 6) / 2`

## Modifying this for part 2
We have the rug pull moment, and it turns out that `XYZ` actually represent the match states - win, draw or loss.
We should, however, be able to use very similar maths to solve this, just going in reverse.

In this case, the mapping of results to numbers is Lose -> `1`, Draw -> `2`, Win -> `3`.
From this, the victory score is easily calculable as `3(r - 1)`, where `r` is the match result.
To calculate the value that you play, we first need a reverse map from these states `r` to the three values modulo 3 that we can calculate from.

This needs to map `1 -> 1`, `2 -> 0` and `3 -> 2`.
This will be in the form:

`g(r) = (r - 2)(cr + d)`

Plugging in our values:

`g(3) = 3c + d = 2`

`g(1) = -c - d = 1`

=> `2c = 3` => `c = 3/2` => `d = -5/2`

Giving us `g(r) = (r - 2)(3r - 5)/2`

This will give us 1 for a loss, 0 for a draw, and 2 for a victory.
Now, given the other player played a `t`, from our previous logic, we can work out that we played `y = (t - g(r))%3`
This will give `y = t` for a draw, `y = (t - 1)%3` for a loss (remember, "each number is beaten by the number above it") and `y = (t + 1)%3` for a victory.
This is all we need to recalculate our scores given this twist.

## Uh-oh
I got it wrong the first time.
This is because my `y = (t - g(r))%3` gives a score of `0`, not `3`, for scissors.
I should've checked my working!
And annoyingly, this didn't come up for the test input.

Consider `j(x) = x % 3`.
For `x` from `-2` to `3`, this will give `1, 2, 0, 1, 2, 0`.
Now consider `k(x) = (x - 1)%3 + 1`.
For `x` from `-2` to `3`, this will give `1, 2, 3, 1, 2, 3`.
So, this is in fact the method we want to use.