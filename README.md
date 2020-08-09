# Overview

This project, tolower, is a handwritten and optimized assembly version of the commonly used tolower() function.

# Purpose
To demonstrate how to write and implement branchless assembly, applied to a useful function.

# C equivalent (roughly)

```
void xtolower(char *text)
{
	unsigned char mod;
	do
	{
		mod = (*text >= 'A' && *text <= 'Z') ? 32 : 0;
		*text += mod;
	}
	while(*(text++));
}
```

# How it works
Back in the early days with 486'es and before, predicting the runtime of any given code was almost humanly
possible for a nerdy enough geek. But current day (year 2020) processors are far more complicated with
multilevel caches, parallel pipelines, prefetchers, instruction reschedulers, branch predictors and threads.
As a result, the only reasonable way to know how efficient a piece of code is is to run it and time it.

But there are a few ideas that are generally true, such as branches being expensive (speaking of time).

If/then/else statements are almost guaranteed to result in branches unless the compiler somehow manages
to optimize them away. But in some cases there are logical and mathematical ways of accomplishing the same
results. tolower is such a case.

tolower uses the fact that certain mathematical operations causes over- or underflow, which results in the
Carry bit being set. And the Carry bit can pretty easily be turned into any value. With, for example...

```RCR	#, register```

If register is zero, RCR will rotate the Carry bit into the #'th position. If Carry is zero, result will still
be zero, but if Carry is 1, you can get any power of 2 value from 128 down to 1.

```SBB	register1, register2```

If both registers are zero, if Carry is also 0, all will remain 0. But if Carry is 1, register2 will underflow
and turn into 0xFF. Register2 can then be AND'ed with any value to get any arbitrary value, so that you get
zero if the "condition" is false and <anyvalue> if the "condition" is true.

In the tolower code, the "condition" looks like this:

```ADD	$191, %bh```

The character to be tested is stored in %bh, adding 191 to it will result in a value greater than 255 if the
character is greater than 'Z', thus if it is greater, Carry will be set to 1, otherwise Carry is set to 0.

# Using
If you wish to use this code in your own project;
* copy the tolower.S file,
* edit your Makefile to include it
	* `gcc -c tolower.S`
	* Also add it to the list of object files to include in your binary
* add the proper prototype to your C headers
	* `void xtolower(char *);`
* call it
* profit


