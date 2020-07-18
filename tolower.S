.text

L0:
	inc	%rdi

.global xtolower
xtolower:
	xor	%eax,%eax

	mov	(%rdi),%bl

	cmp	$91,%bl		// cmp is a sub instruction that discards the result, but sets flags
				// <='Z' - 91 == -1 --> underflow, Carry = 1
	rcr	$3,%al		// bh = 0x20 if char <= 'Z'

	add	$191,%bl	// >='A' + 191 == 256 --> overflow, Carry = 1
	sbb	%ah,%ah		// ah = 0xff if char >= 'A'
				// sbb is 1 byte smaller opcode than rcr

	and	%ah,%al		// both conditions must be met
	add	%al,(%rdi)	// will write to every single character in the string, including the zero termination
				// but only actally modify if both conditions are met, if not met %al is zero

	jnz	L0

	ret

