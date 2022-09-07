# PROGRAM: Q1 HW3

	.data		# Data declaration section

	input_n: .asciiz "\nValue of n: "
	input_d: .asciiz "Value of d: "
	array_value: .asciiz "Enter value of array one by one: " 
	final_array: .asciiz "Final array: "

	array: .space 1000	#declaring a space of size 1000 bytes or 250 words named array

	.text    # Assembly language instructions

main:	# Start of code section
	li $v0, 4		   	# system call code for printing string = 4
	la $a0, input_n	 		# load value of n message
	syscall			      	# call operating system to perform print operation
	
	li $v0, 5			# get ready to read in integers
        syscall				# system waits for input, puts the value in $v0
	move $s0, $v0			# move the variable from $v0 to $s0
	
	sll $a0, $s0, 2			# multiply n by 4 to get the ammount of bytes to allocate.
	li $v0, 9			# loading system call to allocate bytes
	syscall				# allocate the ammount of space 
	move $s2, $v0			# move the address from v0 to s2
	
	li $v0, 4		   	# system call code for printing string = 4
	la $a0, input_d	 		# laod value of d message
	syscall			      	# call operating system to perform print operation
	
	li $v0, 5			# get ready to read in integers
        syscall				# system waits for input, puts the value in $v0
	move $s1, $v0			# move the variable from $v0 to $s0
	
	li $v0, 4		   	# system call code for printing string = 4
	la $a0, array_value	 	# laod value of enter value of array string
	syscall			      	# call operating system to perform print operation
	
	add $t0, $zero, $zero		# t0 is a counter to see if we've inserted enough elements
	move $t1, $s2			# move the address into t1 for temporary manipulation
insert: 	
	li $v0, 5			# get ready to read in integers
        syscall				# system waits for input, puts the value in $v0
	move $s3, $v0			# move the variable from $v0 to $s0
	
	#s2 contains address of array 
	#s1 contains the ammount to be shifted
	#s0 contains the ammount of elements in the array. 
	
	sw $s3, 0($t1)			#store to array[i] (first pass through i = 0)
	addi $t1, $t1, 4		# increment the array pointer by 1 
	addi $t0, $t0, 1		# increment the ammount of elements
	
	bne $t0, $s0, insert		# if not all elements have been inserted keep inserting elements
	
	#shift d number of times	
	#$t4 will contain the ammount of times shifted
	
	addi $t4, $zero, 0		# counter for ammount of times shifted 
left_shift_loop:	
	beq $t4, $s1 left_shift_done	# if counter is the same as d done shifting the array to the left 
	
left_shift_one:
	 addi $t1, $s0, -1		# set address of t1 to final element of array
	 sll $t1, $t1, 2		# increment into byte pointer
	 add $t1, $s2, $t1		# increment pointer to array[d]
	 lw $t0, 0($s2)			# set t0 to the last element of the array. for temp storage 
	 addi $t7, $zero, 0		# create counter for times shifted left
	 addi $t6, $s0, -1		# total amount of time needed to shift left
	 
	 #move element at a[i] to a[i+1] 
	 addi $t1, $s2, 0		# set t1 t0 address of array[0] or array[i]
	 addi $t2, $s2, 4		# set t2 to addres of array[1] or array [i+1]
left_shift_one_repeat:
	 lw $t3, 0($t2)			# set t3 to contents of array[1] or array [i+1]
	 sw $t3, 0($t1)			# store the contents into address of t1 array[0] or array[i]
	 addi $t7, $t7, 1		# increment the counter for times shifted
	 beq $t7, $t6, left_shift_one_finish	# checking if have shifted total ammount of times if put array[0] into array[n-1]
	 addi $t1, $t1, 4		# increment the pointer of i by 1
	 addi $t2, $t2, 4		# increment the pointer of i + 1 by 1
	 j left_shift_one_repeat
	 
left_shift_one_finish:
	#t0 contains the final element
	#s0 contains the ammount of elements
	# 
	sw $t0, 0($t2)			#store the final element as the first element of the array
	addi $t4, $t4, 1		#increment the ammount of times shifted
	j left_shift_loop		# return back to the left shift loop
	
left_shift_done:
	
	li $v0, 4		   	# system call code for printing string = 4
	la $a0, final_array	 	# load value of n message
	syscall			      	# call operating system to perform print operation

	addi $t1, $zero, 0		# create a counter to print char
	
print_loop:		
	lw $t0, 0($s2)			# load the contents of the first element of the array 
	
	move $a0, $t0			# move the int print into a0
	li $v0, 1			# get ready to read in integers
        syscall				# system waits for input, puts the value in $v0
        
        addi $a0, $zero, 32		# loading the char for space
	li $v0, 11			# system call code for print char
	syscall				# print the space char
	addi $s2, $s2, 4		# increment the counter to the next value
	addi $t1, $t1, 1		# increment the counter by 1
	
	bne $t1, $s0, print_loop	# if counter doesnt equal n repeat print loop
	
	
    li $v0, 10				# syscall code 10 is for exit 
    syscall				# exit the code
