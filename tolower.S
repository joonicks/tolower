.text
.global xtolower
xtolower:
	xor	%eax,%eax

	mov	(%rdi),%bh
	mov	(%rdi),%bl

	add	$191,%bh
	rcr	$3,%ah		// ah = 0x20 if char < 'Z'

	sub	$91,%bl
	rcr	$3,%al		// bh = 0x20 if char >= 'A'

	and	%ah,%al		// both conditions must be met
	add	%al,(%rdi)

	inc	%rdi
	mov	(%rdi),%ah
	or	%ah,%ah
	jnz	xtolower

	ret

