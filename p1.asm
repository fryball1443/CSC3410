section .data
  prompt1 db 'Please enter the first single-digit number: ', 0  ; Define a string prompt to display to the user
  prompt2 db 'Please enter the second single-digit number: ', 0  ; Define a string prompt to display to the user
  answer db 'The answer is: ', 0  ; Define a string to display the answer

section .bss
  input1 resb 1  ; Define a variable to store the first user input
  input2 resb 1  ; Define a variable to store the second user input
  result resb 1  ; Define a variable to store the result of the addition

section .text
  global _start

_start:
  ; Display prompt1
  mov eax, 4  ; System call number for write
  mov ebx, 1  ; File descriptor for standard output (stdout)
  mov ecx, prompt1  ; Address of the prompt1 string
  mov edx, 37  ; Length of the prompt1 string
  int 0x80  ; Call the kernel to perform the write system call

  ; Read first user input
  mov eax, 3  ; System call number for read
  mov ebx, 0  ; File descriptor for standard input (stdin)
  mov ecx, input1  ; Address of the input1 variable
  mov edx, 1  ; Maximum number of characters to read
  int 0x80  ; Call the kernel to perform the read system call

  ; Display prompt2
  mov eax, 4  ; System call number for write
  mov ebx, 1  ; File descriptor for standard output (stdout)
  mov ecx, prompt2  ; Address of the prompt2 string
  mov edx, 38  ; Length of the prompt2 string
  int 0x80  ; Call the kernel to perform the write system call

  ; Read second user input
  mov eax, 3  ; System call number for read
  mov ebx, 0  ; File descriptor for standard input (stdin)
  mov ecx, input2  ; Address of the input2 variable
  mov edx, 1  ; Maximum number of characters to read
  int 0x80  ; Call the kernel to perform the read system call

  ; Convert first input to number
  sub al, '0'  ; Subtract the ASCII value of '0' from the first input character to convert it to a number

  ; Convert second input to number
  sub byte [input2], '0'  ; Subtract the ASCII value of '0' from the second input character to convert it to a number

  ; Add the two numbers
  add al, byte [input2]  ; Add the second input number to the first input number

  ; Convert the result to a character
  add al, '0'  ; Add the ASCII value of '0' to the result to convert it to a character

  ; Store the result
  mov [result], al

  ; Display "The answer is: "
  mov eax, 4  ; System call number for write
  mov ebx, 1  ; File descriptor for standard output (stdout)
  mov ecx, answer  ; Address of the answer string
  mov edx, 15  ; Length of the answer string
  int 0x80  ; Call the kernel to perform the write system call

  ; Display the result
  mov eax, 4  ; System call number for write
  mov ebx, 1  ; File descriptor for standard output (stdout)
  mov ecx, result  ; Address of the result variable
  mov edx, 1  ; Length of the result string
  int 0x80  ; Call the kernel to perform the write system call

  ; Exit the program
  mov eax, 1  ; System call number for exit
  xor ebx, ebx  ; Exit status code (0 for success)
  int 0x80  ; Call the kernel to perform the exit system call
