
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
