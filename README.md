
# ALU

The purpose of this project is to build a logical unit in VHDL language in ISE software, which includes sequential and composite parts.
In the first part of the project, we build the combined part of the circuit in which the logical unit (ALU) performs 16 different operations. which include logical operations, arithmetic operations, shift and rotation, and conversion of BCD code to binary.
In the second part of the project, we add the sequential part of the circuit to the previous part to complete the desired logic-arithmetic unit.
Finally, in the third part of the project, we test the written code with two different methods and compare these two methods.


## 

 ## OPCODES
  
As mentioned before, we create the combined part of the circuit. In addition to 16 different operations that this logical unit
does, it also provides information regarding the output of the operations, which are whether it is symmetrical or not (X_bin_pal),
prime or not (X_prime) and negative or not (N). For the first two cases, we created separate modules.
- For OPCODE=0000, two inputs A and B are put into X, and output Y, Cout, and V are equal to zero.

- For OPCODE=0001, the result of two inputs A and B are put in X, and output Y, Cout and V are equal to zero.

- For OPCODE=0010, the xor result of two inputs A and B is put in X, and output Y, Cout and V are equal to zero.

- For OPCODE=0011, the result of xnor two inputs A and B are put in X and output Y, Cout and V are equal to zero.

- For OPCODE=0100, the unsigned addition operation is performed in such a way that the inputs are first resized (X,N)
 , we make A and B 9 bits and add them together, and then put the first 8 bits in X output and the 9th bit in Cout. 


- For OPCODE=0101, the addition operation is performed with a sign in such a way that first with the resize(X,N) operation of the inputs, i.e.
    We make A and B 9 bits and add them together, and then put the first 8 bits in X output. Next, we have to check the head,
    If the ninth bit was equal to one, the output V would be equal to one and vice versa. Output Y and Cout are equal to zero.

- For OPCODE=0110, the unsigned addition operation is performed with the input transfer bit in such a way that first with the operation
    resize(X,N) We make the inputs A and B 9-bit (unsigned) and add them together. In this case, we must also add Cin with it.
    for this we must first convert it from std_logic to std_logic_vector. for this purpose
    We add an ineffective zero bit to the MSB and because Cin has two bits, it is converted to std_logic_vector
   . Finally, we make Cin unsigned and add A and B at the end. Then the first 8 bits are output
    We put X and the 9th bit in Cout. Output Y and V are equal to zero.

- For OPCODE=0111, the operation of multiplying with a sign is performed in such a way that the inputs, namely A and B, are mixed with a sign.
    We multiply and then put the first 8 bits in the X output and the second 8 bits in the Y output. Output Cout and V are equal to zero.
- For OPCODE=1000, unsigned multiplication is performed in such a way that the inputs A and B are unsigned.
    We multiply and then put the first 8 bits in the X output and the second 8 bits in the Y output. Output Cout and V equal to zero.

- For OPCODE=1001, the unsigned subtraction operation is performed in such a way that the inputs are first resized (X,N)
    That is, we make A and B 9 bits and subtract them from each other, and then put the first 8 bits in X output and the 9th bit in Cout. output
    Y and V are equal to zero.

- For OPCODE=1010, the operation of rotation to the left is performed in such a way that with the input rotate_left(X,N) operation
    We shift A to the left by one unit and put it in X output.     Output Y, Cout and V are equal to zero.

- For OPCODE=1011, the operation of turning to the left is done with the carry bit so that when Cin: A
    We rotate the unit to the left, the last bit of A is removed, and as a result, we put it in Cout, and the Cin bit is connected to the beginning of the A input.
    We can finally put the result in X output. Output Y and V are equal to zero.

- For OPCODE=1100, the logical shift operation is performed to the right in such a way that with the operation shift_right(X,N)
    We shift the input A to the right by one unit without the sign and put it in the output X. Output Y, Cout and V equal to zero

- For OPCODE=1101, the arithmetic shift operation is performed to the right in such a way that with the operation shift_right(X,N)
    We shift the input A to the right by one unit and put it in the output X. The eighth bit of input A during shift
    The output falls out, so we put it in the Cout output. Output Y and V are equal to zero.

- For OPCODE=1110, the logical shift operation is performed to the left in such a way that with the operation shift_left(X,N)
    We shift the input A to the left by one unit without the sign and put the eighth bit of the input A at the output X during the shift.
    The output falls out, so we put it in the Cout output. Output Y and V are equal to zero.

- For OPCODE=1111, the conversion of BCD code to binary code is done by first combining two inputs A and B.
    We consider connected and then separate 4 digits - 4 digits of bits and to create a binary number, all four separated digits in the value
    Multiply its own place (unsigned) and finally add it all together (unsigned). More precisely, it means four bits.
    First input A in one, second four bits input A in binary code number 10, first four bits input B in binary code number 100
    and we multiply the second four bits of input B in the binary code number 1000 and finally the first 8 bits of the obtained result (BCD)
    We pour in X output. We also have to put the second 8 bits of BCD in the Y output, but because the BCD variable can only be up to 14 bits
    value, then we add two zeros to the beginning of Y for bits 15 and 16. The output V is zero.






 
 







