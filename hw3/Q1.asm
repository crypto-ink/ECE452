# PROGRAM: Q1 HW3

	.data		# Data declaration section

	input_string: .asciiz "\nEnter a number(0 to stop): "
	output_string: .asciiz "\nThe product = "

	array: .space 1000	#declaring a space of size 1000 bytes or 250 words named array

	.text    # Assembly language instructions

main:	# Start of code section
	addi $s1, $zero, 1 		#setting $s1 with 1 to hold a running sum
start:
	li $v0, 4		   	# system call code for printing string = 4
	la $a0, input_string	 	# load address of string to be printed into $a0
	syscall			      	# call operating system to perform print operation
	
	li $v0, 5			# get ready to read in integers
        syscall				# system waits for input, puts the value in $v0
	move $s0, $v0			# move the variable from $v0 to $s0
	
	beq $s0, $zero, exit		# if the inserted varibale is 0 exit
	blt $s0, $zero, negative 	# check if the number is negative

fixed: 
	mult $s1, $s0			# $s1 = $s1 * $s0 Running product of 
	mflo $s1			# loading the lower 32 bits from lo back into $s1
     	
     	j start
     	
negative:     
   	subu $s0, $zero, $s0
   	j fixed
        
exit:
	li $v0, 4		   	# system call code for printing string = 4
	la $a0, output_string	 	# load address of string to be printed into $a0
	syscall			      	# call operating system to perform print operation
	
	move $a0, $s1			# prepare $t 0 for printing
	li $v0, 1	     		# system call code for print_int
     	syscall		      		# print it	
	
    li $v0, 10				# syscall code 10 is for exit 
    syscall				# exit the code
