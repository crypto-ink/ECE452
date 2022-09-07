# PROGRAM: Q1 HW3

	.data		# Data declaration section

	input_string: .asciiz "\nEnter the value of n(0 to stop): "
	output_string: .asciiz "\nFirst 150 prime numbers:  \n"
	fail_prime: .asciiz "\n int is not prime\n"
	is_prime: .asciiz "\n int is prime\n"

	array: .space 1000	#declaring a space of size 1000 bytes or 250 words named array

	.text    # Assembly language instructions

main:	# Start of code section
	li $v0, 4		   	# system call code for printing string = 4
	la $a0, input_string	 	# load address of string to be printed into $a0
	syscall			      	# call operating system to perform print operation
	
	li $v0, 5			# get ready to read in integers
        syscall				# system waits for input, puts the value in $v0
	move $s0, $v0			# move the variable from $v0 to $s0
	
	beq $s0, $zero, exit		# ift the given value is 0 exit the program.
	
	li $v0, 4			# system call code for printing string = 4
	la $a0, output_string		# load address of string to be printed into $a0
	syscall
	
	addi $t0, $zero, 1		# create counter for ammount of primes
	addi $t1, $zero, 2		# load the first number to test from
	
main_loop:	
	move $a0, $t1			# position parameter for test_prime
	jal test_prime
	move $t2, $v0			#saving the value that test_prime returns
	bne $t2, $zero, print_prime	# checking if number we tested was prime, if prime print the number
	addi $t1, $t1, 1		# increment the number we are checking by one
	j main_loop
	
print_prime:		
	
	move $a0, $t1			# moving the number we were given into a0 fomr printing argument
	li $v0, 1	     		# system call code for print_int
	syscall		      		# print it the inital value we had
	
	addi $a0, $zero, 32		# loading the char for space
	li $v0, 11			# system call code for print char
	syscall				# print the space char
	
	
	beq $t0, $s0 prime_finish	# check if primes printed and value entered are equal if so repeat loop until 0 entered
	addi $t0, $t0, 1		# increment the prime counter by 1 if values are not the same
	addi $t1, $t1, 1		# increment the number we are checking if prime by 1
	j main_loop			# return and test the new number
	
#	move $a0, $t0			# print value returned from test_prime
#	li $v0, 1	     		# system call code for print_int
#	syscall		      		# print it
	
prime_finish:
	
	addi $a0, $zero, 10		# loading the char for new line
	li $v0, 11			# system call code for print char
	syscall				# print the space char
	j main
	
	
		
	
test_prime:
	#a0 will contains the value which we test if it is true
	#v0 contains 1 if n is prime and 0 if n is not prime
	addi $t4, $zero, 2 		# loading 2 into t0 for going from 2 2/2
	beq $a0, $t4 prime		# if the number we are checking is 2 it is a prime
	div $a0, $t4			# dividing to create boundry of loop
	mfhi $t5			# loading the remainder from division
	beq $t5, $zero not_prime	# checking if divisible by two if so not prime
	
	mflo $t5			# loading the int quotient 
	addi $t5, $t5, 1		# creating the final upper boundry to test from 
	
prime_loop:	
	beq $t4 $t5 prime		# if the value at t0 (i) == the upper boundry ($a0/2)+1
	addi $t4, $t4, 1		# i = i + 1 increment the i by 1 
	
	div $a0, $t4			# divide by updated int value
	mfhi $t6			# get the remainder quantity of $a0/$t0
	bne $t6, $zero prime_loop
	
not_prime:
#	li $v0, 4		   	# system call code for printing string = 4
#	la $a0, fail_prime	 	# load address of string to be printed into $a0
#	syscall			      	# call operating system to perform print operation

	move $v0,$zero 			#the int was not prime move on and return 0
	li $a0, 0			#clearing the arguement
	jr $ra				#return to when called from jal 
	
prime:	

#	li $v0, 4		   	# system call code for printing string = 4
#	la $a0, is_prime	 	# load address of string to be printed into $a0
#	syscall			      	# call operating system to perform print operation
	
	move $v0 $zero
	li $v0, 1			# moving 1 into return value since number is prime
	li $a0, 0			# clearing the argument
	jr $ra				# return to when called from jal
	
	
	#a0 containt
#	li $v0, 1	     		# system call code for print_int
#     	syscall		      		# print it
#	move $v0, $a0
#	add $a0, $zero, $zero
     	
	
			
exit:

	
    li $v0, 10				# syscall code 10 is for exit 
    syscall				# exit the code
