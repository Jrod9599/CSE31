#sprintf!
#$a0 has the pointer to the buffer to be printed to
#$a1 has the pointer to the format string
#$a2 and $a3 have (possibly) the first two substitutions for the format string
#the rest are on the stack
#return the number of characters (ommitting the trailing '\0') put in the buffer
#%u, %x, %o, %s, %d
	.data	
percent:	.byte	'%'
dec:		.byte	'd'
hex:		.byte	'x'
uns:		.byte	'u'
oct:		.byte	'o'
stri:		.byte	's'
	.text
sprintf:
	add	$t0, $a0, $0	#t0 = buffer
	la	$t1, ($a1)	#load format
	lb	$t2, percent	#t2 = '%'
	lb	$t3, ($t1)	#load first part of the format
	addi	$sp, $sp, 8
	sw	$a3, 0($sp)
	
check: 	beqz	$t3, Exit
	beq	$t3, $t2, type
	li	$v0, 11
	add	$a0, $t3, $0
	syscall
	sll	$t1, $t1, 1
	lb	$t3, ($t1)
	syscall
	j	check
	
type:	add	$t3, $t3, 1	#loads next charcter form the format
	lb	$t2, stri
	beq	$t3, $t2, string
	lb	$t2, uns	
	beq	$t3, $t2, unsigned 
	lb	$t2, dec
	beq	$t3, $t2, decimal
	lb	$t2, hex
	beq	$t3, $t2, hexi
	lb	$t2, oct
	beq	$t3, $t2, octi
	
# string 
string: add	$sp, $sp, 4
	lw	$a0, 0($sp) #a3 uses argument 1 
	li	$v0, 4
	syscall
	addi	$t3, $t3, 1
	lb	$t2, percent
	j	check

#unsigned check
unsigned:
	add	$sp, $sp, 4
	lw	$a0, 0($sp) #take in next argument
	#slt	$t4, $a0, $0
	#beq	$t4, 1, positive
	li	$v0, 1
	syscall
	addi	$t3, $t3, 1
	lb	$t2, percent
	j	check

#decimal check
decimal:	
	add	$sp, $sp, 4
	lw	$a0, 0($sp)
	li	$v0, 1
	syscall
	addi	$t3, $t3, 1
	lb	$t2, percent
	j	check

#hex check
hexi:	
	add	$sp, $sp, 4
	lw	$a0, 0($sp)
	add	$t5, $a0, $0 #load argument into temp to manipulate
	li	$t4, 8	#counter
loop:
	beqz	$t0, hex_exit	#counter hits 0 exit
	rol	$t5, $t5, 4
	and	$t6, $t5, 0xf
	ble	$t6, 9, sum
	addi	$t6, $t6, 55

	b	end	
sum:
	addi	$t6, $t6, 48
end:	
	sb	$t6, ($a0)
	addi	$t0, $t0, -1
	
	j loop
	
hex_exit:	
	la	$a0, ($t5)
	li	$v0, 4
	syscall
	
	j check
#octidecimal check
octi:
	
Exit:
	jr	$ra		#this sprintf implementation rocks!
