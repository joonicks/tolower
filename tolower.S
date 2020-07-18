.text

L0:
	inc	%rdi

.global xtolower
xtolower:
	xor	%eax,%eax

	mov	(%rdi),%bh
	mov	(%rdi),%bl

	add	$191,%bh	// >='A' + 191 == 256 --> overflow, Carry = 1
	sbb	%al,%ah		// ah = 0xff if char >= 'A' --- sbb is 1 byte smaller opcode than rcr

	sub	$91,%bl		// <='Z' - 91 == -1 --> underflow, Carry = 1
	rcr	$3,%al		// bh = 0x20 if char <= 'Z'

	and	%ah,%al		// both conditions must be met
	add	%al,(%rdi)

	jnz	L0

	ret

