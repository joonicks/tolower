# Overview

This project, tolower, is a handwritten and optimized assembly version of the commonly used tolower() function.

# Purpose
To demonstrate how to write and implement branchless assembly, applied to a useful function.

# C equivalent (roughly)

```
void xtolower(char *text)
{
	do
	{
		if (*text >= 'A' && *text <= 'Z')
			*text = *text + 32;
	}
	while(*(text++));
}
```

# How it works


# Using
If you wish to use this code in your own project;
* copy the tolower.S file,
* edit your Makefile to include it
* add the proper prototype to your C headers
* call it
* profit

## C function prototype

```(void xtolower(char *);```

