.data
shouldben1:	.asciiz "Should be -1, and firstposshift and firstposmask returned: "
shouldbe0:	.asciiz "Should be 0 , and firstposshift and firstposmask returned: "
shouldbe16:	.asciiz "Should be 16, and firstposshift and firstposmask returned: "
shouldbe31:	.asciiz "Should be 31, and firstposshift and firstposmask returned: "

.text
main:
	la	$a0, shouldbe31
	jal	print_str
	lui	$a0, 0x8000	# should be 31
	jal	first1posshift
	move	$a0, $v0
	jal	print_int
	jal	print_space

	lui	$a0, 0x8000
	jal	first1posmask
	move	$a0, $v0
	jal	print_int
	jal	print_newline

	la	$a0, shouldbe16
	jal	print_str
	lui	$a0, 0x0001	# should be 16
	jal	first1posshift
	move	$a0, $v0
	jal	print_int
	jal	print_space

	lui	$a0, 0x0001
	jal	first1posmask
	move	$a0, $v0
	jal	print_int
	jal	print_newline

	la	$a0, shouldbe0
	jal	print_str
	li	$a0, 1		# should be 0
	jal	first1posshift
	move	$a0, $v0
	jal	print_int
	jal	print_space

	li	$a0, 1
	jal	first1posmask
	move	$a0, $v0
	jal	print_int
	jal	print_newline

	la	$a0, shouldben1
	jal	print_str
	move	$a0, $0		# should be -1
	jal	first1posshift
	move	$a0, $v0
	jal	print_int
	jal	print_space

	move	$a0, $0
	jal	first1posmask
	move	$a0, $v0
	jal	print_int
	jal	print_newline

	li	$v0, 10
	syscall

first1posshift:
	### YOUR CODE HERE ###
	addiu	$t1, $0, -1
	slt	$t0, $a0, $0
	#beq	$t0, $0, zero
	bne	$t0, $0, negative

positive:
	beq $a0, $zero, positive_end
	addiu $t1, $t1, 1
	srl $a0, $a0, 1
	j positive
zero:
	li	$v0, -1
	j	end
negative:
	addiu	$v0, $0, 31	
end:
	jr $ra
	
positive_end: 
	move $v0, $t1
	jr $ra
	
	
	
first1posmask:
	### YOUR CODE HERE ###	
	addiu	$t1, $0, -1
	slt	$t0, $a0, $0
	#beq	$t0, $0, zero
	bne	$t0, $0, negative
	addiu	$t0, $0, 0x80000000
	addiu	$t2, $0, 31
for:
	and	$t1, $a0, $t0
	beq	$t0, $t1, bitend
else:
	srl	$t0, $t0, 1
	addiu	$t2, $t2, -1
	j	for
bitend:
	move	$v0, $t2
	jr	$ra
	

print_int:
	move	$a0, $v0
	li	$v0, 1
	syscall
	jr	$ra

print_str:
	li	$v0, 4
	syscall
	jr	$ra

print_space:
	li	$a0, ' '
	li	$v0, 11
	syscall
	jr	$ra

print_newline:
	li	$a0, '\n'
	li	$v0, 11
	syscall
	jr	$ra
	
	

