
1. Write code in a way that helps the poor bastard who has to fix it in the future, because that poor bastard could be you.
2. Naming things is hard ... and arbitrary, don't waste time thinking about it. Open a dictionary at random and use the first noun, you'll work out a name pretty quick.
3. Always choose a declarative (what you want to do) over imperative (how you are doing it) programming style, esp. with naming and comments.
4. A bug is just code not matching requirements. If there are no requirements then there are no bugs, just code at odds with someone's opinion.
5. Document your data layouts.
6. Don't sacrifice clarity for small gains in efficiency.
7. Types enable the compiler to determine correctness, so use them; let ~~robots~~ compilers do all the work.
8. Don't focus on the "good" code path, most of the bugs are found in the "failure" code paths.
9. Strings and byte arrays are not structured types so stop trying to force structure onto them (through them?).
10. Check values whose origin is from outside your code as soon as possible. And then stash it in a specialised Type so you never have to worry about its correctness again.
11. Don't try and be "helpful", "smart", or "clever" - that just specialises the code in a way that others will have to working around later.
12. Naming things is hard (still), just because its name is "wheelbarrow" don't assume it does (what you think are) wheelbarrow things.
13. "Out by 1" errors still exist because people confuse ordinal and cardinal (and developers are too stubborn to give up foo[0])
14. When composing structures the relationship to members is always none, one, or infinite.
15. Explicit is better than implicit.

70. Failure is not an option - it is mandatory. The option is whether or not to let failure be the last thing you do.


--------------------------


1. code smells: using 2x booleans to describe 3 states
2. code smells: two state variables that are almost the same but not exactly the same
    (if they are the same, then refactor to use 1 state, if theyr'e not the same they
    should be more clearly differentiated)

3. Any sufficiently complicated state is best implemented as a state machine
4. Errors in state management are likely because you're not managing state like a state machine

5. Fixing the error message and not the underlying issue is just kicking the can down the road to future you.
"just fixing the error message not the actual problem"

6. loop termination should be the first or last lines of a `while true` ... and then
    you can refactor to a `while cond` or `do until` equivalant

n. Things developers complicate in the pursuit of false precision.
    + versioning
    + milli -> micro
    + firsts .. seconds .. thirds ... ora

n. Things developers try to force order on to low entry types (that i have seen)
    + phone numbers as strings
    + pointers as integers
    + version as double
    + anything as a byte array (bad because you can pass it to any other func taking a different "struct" byte array)

n. If you don't understand the why's of a bug you've only fixed the symptoms... maybe
n. unit tests commonly test the negative side of edge cases ... you need to test the positive side as well (to catch regressions)

n. Just because soemone called it a wheelbarrow doesn't mean it _is_ a wheelbarrow
    "You keep using that word. I do not think it means what you think it means"

With a sufficient number of users of an API,
it does not matter what you promise in the contract:
all observable behaviors of your system
will be depended on by somebody.

https://www.laws-of-software.com/


scope, resources, timeline - choose two ... Agile fixes timeline (short spritns), resources (can't change much
in a short sprint), leaving scope as the only thing that can change without degrading quality.

ticket velocity is a measure never a target [1]

Any sufficiently complicated C or Fortran program contains an ad hoc, informally-specified, bug-ridden, slow implementation of half of Common Lisp.


Everyone knows that debugging is twice as hard as writing a program in the first place. So if you’re as clever as you can be when you write it, how will you ever debug it?

Given enough eyeballs, all bugs are shallow.

[1] goodhart's law - when a measure becomes a target, it ceases to be a good measure


“Virding's First Rule of Programming:
Any sufficiently complicated concurrent program in another language contains an ad hoc informally-specified bug-ridden slow implementation of half of Erlang.”


https://martinfowler.com/bliki/TwoHardThings.html

There are 2 hard problems in computer science: cache invalidation, naming things, and off-by-1 errors.

There are only two hard problems in distributed systems: 2. Exactly-once delivery 1. Guaranteed order of messages 2. Exactly-once delivery

https://en.wikipedia.org/wiki/The_Elements_of_Programming_Style


## xkcd
https://xkcd.com/1172/
https://xkcd.com/1513/
https://xkcd.com/2138/
https://www.xkcd.com/327/
https://xkcd.com/292/
https://xkcd.com/2347/

https://www.explainxkcd.com/wiki/index.php/Category:Programming
