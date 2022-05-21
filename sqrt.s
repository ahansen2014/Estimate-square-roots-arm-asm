/* square roots */
.data
.balign 4
counter:
	.word 0		@ This is the value for the root

.balign 4
input_message:
	.asciz "Number to find square root of: "

.balign 4
user_input:
	.asciz "%d"

.balign 4
number_read:
	.word 0		@ User input

.balign 4
test_value:
	.word 0		@ Value to find root of

.balign 4
current_value:
	.word 0		@ Stores the current value during the subtraction process

.balign 4
subtract:
	.word 1		@ First odd integer.  Integers subtracted are 1, 3, 5, 7, ...

.balign 4
exact_root_message:
	.asciz "The square root of %d is %d.\n"

.balign 4
between_root_message:
	.asciz "The square root of %d is between %d and %d.\n"

.balign 4
return:
	.word 0		@ Location of return point


.text
.global printf		@ So we can print stuff
.global scanf		@ So we can get user input
.global main

main:
	/* Store the return addresss in memory */
	ldr r1, =return
	str lr, [r1]

	/* Get the value we are finding the root of.  */
	ldr r0, =input_message
	bl printf

	ldr r0, =user_input	@ r0 contains the user input pattern.  We are looking for an integer
	ldr r1, =number_read	@ r1 contains the address to store it in
	bl scanf		@ r1 now contains the user input
	
	/* Store the test value in memory so we can refer to it later. */
	ldr r1, =number_read	@ Get the address of the users input
	ldr r1, [r1]		@ Get the user's actual input value
	ldr r2, =test_value	@ Get the address of the location we are storing the test value
	str r1, [r2]		@ Store the test value in memory so we can print it later
 
	/* Store the test value in current_value so we can modify it. */
	ldr r2, =current_value	@ Get the address of the current value
	str r1, [r2]		@ Store a copy of the test value in current value so we can modify it

loop:
	/* Load the current value from memory and compare it to zero. */
	ldr r1, =current_value	@ Get the address of the current value
	ldr r1, [r1]		@ r1 now contains current value
	cmp r1, #0		@ Has the current value reached or fallen below zero?
	beq exact_root_found	@ If it is zero we have an exact root
	blt approx_root_found	@ If it is below zero we have an approx root
	
	/* Calculate the new current value */
	ldr r2, =subtract	@ Get the address of the subtraction value
	ldr r2, [r2]		@ r2 now contains the value to subtract
	sub r3, r1, r2		@ r3 now contains new current value

	ldr r1, =current_value
	str r3, [r1]		@ current_value is now updated

	/* Update the subtraction value to the next odd integer */ 
	add r2, r2, #2		@ Increment subtract to the next odd integer
	ldr r1, =subtract	@ Get the address of the subtract value
	str r2, [r1]		@ Subtraction value is now updated

	/* Increment the counter */
	ldr r1, =counter	@ Get the address of the counter
	ldr r1, [r1]		@ Get the value of the counter
	add r2, r1, #1		@ r2 now contains the updated counter

	/* Update the counter value in memory */
	ldr r1, =counter	@ Get the address of the counter
	str r2, [r1]		@ Counter is now updated
	b loop

exact_root_found:
	ldr r0, =exact_root_message	@ r0 contains the message and expects two integers
	ldr r1, =test_value	@ Get the address of the test value
	ldr r1, [r1]		@ r1 now contains the  value of the test value
	ldr r2, =counter	@ Get the address of the counter
	ldr r2, [r2]		@ r2 now contains the  value of the counter
	bl printf
	b end

approx_root_found:
	ldr r0, =between_root_message	@ r0 contains the message and expects three integers
	ldr r1, =test_value	@ Get the address of the test value
	ldr r1, [r1]		@ r1 now contains the test value
	ldr r2,  =counter	@ Get the address of the counter
	ldr r2, [r2]		@ r2 now contains the higher of the two root approximations
	sub r2, #1		@ By subtracting one r2 now contains the lower of the two approximations
	ldr r3, =counter	@ Get the address of the counter
	ldr r3, [r3]		@ r3 now contains the higher of the two root approximations
	bl printf
	b end

end:
	ldr lr, =return		@ Get the address of the break location
	ldr lr, [lr]		@ Restore the break location to the loader register
	bx lr			@ Terminate
