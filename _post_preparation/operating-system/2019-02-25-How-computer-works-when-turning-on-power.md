---
layout: post
title: How computer works when turning on power
bigimg: /img/path.jpg
tags: [Computer]
---



You turn the computer on.
The computer loads data from read-only memory (ROM) and performs a power-on self-test (POST) to make sure all the major components are functioning properly. As part of this test, the memory controller checks all of the memory addresses with a quick read/write operation to ensure that there are no errors in the memory chips. Read/write means that data is written to a bit and then read from that bit.
The computer loads the basic input/output system (BIOS) from ROM. The BIOS provides the most basic information about storage devices, boot sequence, security, Plug and Play (auto device recognition) capability and a few other items.
The computer loads the operating system (OS) from the hard drive into the system's RAM. Generally, the critical parts of the operating system are maintained in RAM as long as the computer is on. This allows the CPU to have immediate access to the operating system, which enhances the performance and functionality of the overall system.
When you open an application, it is loaded into RAM. To conserve RAM usage, many applications load only the essential parts of the program initially and then load other pieces as needed.
After an application is loaded, any files that are opened for use in that application are loaded into RAM.
When you save a file and close the application, the file is written to the specified storage device, and then it and the application are purged from RAM.



How the CPU Executes Program Instructions
Let us examine the way the central processing unit, in association with memory, executes a computer program. We will be looking at how just one instruction in the program is executed. In fact, most computers today can execute only one instruction at a time, though they execute it very quickly. Many personal computers can execute instructions in less than one-millionth of a second, whereas those speed demons known as supercomputers can execute instructions in less than one-billionth of a second.

Figure 2: The Machine Cycle
Before an instruction can be executed, program instructions and data must be placed into memory from an input device or a secondary storage device (the process is further complicated by the fact that, as we noted earlier, the data will probably make a temporary stop in a register). As Figure 2 shows, once the necessary data and instruction are in memory, the central processing unit performs the following four steps for each instruction:

    The control unit fetches (gets) the instruction from memory.
    The control unit decodes the instruction (decides what it means) and directs that the necessary data be moved from memory to the arithmetic/logic unit. These first two steps together are called instruction time, or I-time.
    The arithmetic/logic unit executes the arithmetic or logical instruction. That is, the ALU is given control and performs the actual operation on the data.
    Thc arithmetic/logic unit stores the result of this operation in memory or in a register. Steps 3 and 4 together are called execution time, or E-time. 


The control unit eventually directs memory to release the result to an output device or a secondary storage device. The combination of I-time and E-time is called the machine cycle. Figure 3 shows an instruction going through the machine cycle.

Each central processing unit has an internal clock that produces pulses at a fixed rate to synchronize all computer operations. A single machine-cycle instruction may be made up of a substantial number of sub-instructions, each of which must take at least one clock cycle. Each type of central processing unit is designed to understand a specific group of instructions called the instruction set. Just as there are many different languages that people understand, so each different type of CPU has an instruction set it understands. Therefore, one CPU-such as the one for a Compaq personal computer-cannot understand the instruction set from another CPU-say, for a Macintosh.
Figure 3: The Machine Cycle in Action

It is one thing to have instructions and data somewhere in memory and quite another for the control unit to be able to find them. How does it do this?

Figure 4: Memory Addresses Like Mailboxes
The location in memory for each instruction and each piece of data is identified by an address. That is, each location has an address number, like the mailboxes in front of an apartment house. And, like the mailboxes, the address numbers of the locations remain the same, but the contents (instructions and data) of the locations may change. That is, new instructions or new data may be placed in the locations when the old contents no longer need to be stored in memory. Unlike a mailbox, however, a memory location can hold only a fixed amount of data; an address can hold only a fixed number of bytes - often two bytes in a modern computer.

Figure 4 shows how a program manipulates data in memory. A payroll program, for example, may give instructions to put the rate of pay in location 3 and the number of hours worked in location 6. To compute the employee's salary, then, instructions tell the computer to multiply the data in location 3 by the data in location 6 and move the result to location 8. The choice of locations is arbitrary - any locations that are not already spoken for can be used. Programmers using programming languages, however, do not have to worry about the actual address numbers, because each data address is referred to by a name. The name is called a symbolic address. In this example, the symbolic address names are Rate, Hours, and Salary.


When your computer is turned on, the microprocessor gets the first instruction from the basic input/output system (BIOS) that comes with the computer as part of its memory. After that, either the BIOS, or the operating system that BIOS loads into computer memory, or an application progam is "driving" the microprocessor, giving it instructions to perform.


Refer:



[https://computer.howstuffworks.com/microprocessor2.htm](https://computer.howstuffworks.com/microprocessor2.htm)

[https://whatis.techtarget.com/definition/microprocessor-logic-chip](https://whatis.techtarget.com/definition/microprocessor-logic-chip)

[https://www.doc.ic.ac.uk/~eedwards/compsys/memory/index.html](https://www.doc.ic.ac.uk/~eedwards/compsys/memory/index.html)

[https://computer.howstuffworks.com/computer-memory1.htm](https://computer.howstuffworks.com/computer-memory1.htm)

[https://homepage.cs.uri.edu/faculty/wolfe/book/Readings/Reading04.htm](https://homepage.cs.uri.edu/faculty/wolfe/book/Readings/Reading04.htm)

[https://en.wikipedia.org/wiki/Cache_(computing)](https://en.wikipedia.org/wiki/Cache_(computing))

[https://www.webopedia.com/TERM/C/cache.html](https://www.webopedia.com/TERM/C/cache.html)

[https://computer.howstuffworks.com/cache3.htm](https://computer.howstuffworks.com/cache3.htm)

