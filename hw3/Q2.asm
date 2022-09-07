# PROGRAM: Q2 HW3

	.data		# Data declaration section
	buffer: .space 512

	input_string: .asciiz "\nEnter a line of input (Enter 's' to stop program):  "
	position_string: .asciiz "Enter a position:  "
	character_string: .asciiz "Character is: "
	array: .space 1000	#declaring a space of size 1000 bytes or 250 words named array

	.text    # Assembly language instructions

main:	# Start of code section
	#section for entering an input string
	
	li $v0, 4		   	# system call code for printing string = 4
	la $a0, input_string	 	# load address of string to be printed into $a0
	syscall			      	# call operating system to perform print operation
	
	li $v0, 8			# system call code for receiving a string
	la $a0, buffer			# load address reserved for string
	li $a1, 512			# allot the space for the string
	move $t0, $a0			# $t0 now contains the address of the string 
	
	syscall				# call operating system to wait for a string.
	
	#check if the string was s 
	
	lb $t1, 0($t0)			# load the the first char of the string
	lb $t2, 1($t0)			# load the second char of the string
	addi $t3, $zero, 10		# load t3 with the end of line char value
	beq $t2, $t3, test		# test if second char is end of file value
	
	
return:	
	
	#section for entering a position
	
	
	li $v0, 4		   	# system call code for printing string = 4
	la $a0, position_string	 	# load address of string to be printed into $a0
	syscall			      	# call operating system to perform print operation
	
	
	li $v0, 5			# get ready to read in integers
        syscall				# system waits for input, puts the value in $v0
	move $s0, $v0			# move the variable from $v0 to $s0
	add $t0, $t0, $s0		# incrementing the address pointer of the string the the desired character
	
	#section for printing what the character at index i is
	
	
	li $v0, 4		   	# system call code for printing string = 4
	la $a0, character_string	# load address of string to be printed into $a0
	syscall			      	# call operating system to perform print operation
	
	lb $a0, 0($t0)			# load the char of the string
	li $v0, 11			# system call code for printing a character = 11
	syscall
	
	j main				# return back to the main 
	
test:
	addi $t3, $zero, 115		# load t3 with the ascii s char value
	bne $t3, $t1, return		# if the first char is s exit
	
exit:
	
    li $v0, 10				# syscall code 10 is for exit 
    syscall				# exit the code
