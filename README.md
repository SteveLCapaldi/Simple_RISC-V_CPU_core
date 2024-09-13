# Simple_RISC-V_CPU_core
This is the course project of ADDL(Application and Design of Digital Logic) Challenge course at Glasgow College,UESTC. 
This project involves a simple CPU core which supports the ISA from RISC-V.(More details could be found in the document)
The main work of design is accomplished by hdl Verilog, and it has passed simple testbenches which were designed specifically.
This readme could be uploaded further if I have any time.
这个项目是电子科技大学格拉斯哥学院挑战性课程-数字逻辑设计与应用的课程设计。
此项目需要我们设计一个简易的CPU并下板（FPGA）运行，我们选择的指令集是RISC-V的部分指令。
这个项目的大部分工作通过Verilog硬件描述语言完成，并通过了专门设计的简易测试平台。
（由于课程限制，我并未采取verilator或者ModelSim这种较为专业的查看波形图的软件，而是采用Vivado内置的仿真功能）
具体的设计信息在Design Report的doc文件里面可以翻到（为了避免开盒我把组员的名字学号信息去掉了）
关于设计，在报告里面有些思想没有写进去：（1）设计的时候本来想做流水线，但是后期花的时间不够，所以只能把流水线寄存器删掉做成多周期的（仍然在打拍子），整了个伪流水线结构哈哈（2）RAM是存的数据，ROM是存的指令，这俩不在CPU结构里，而是在做测试的时候添加的（3）最后项目没有下板，因为我们组里负责下板的相关同学没有想到合适的下板思路去验证我们的CPU是可以运作的（没想到怎么去运行流水灯），所以没有.xdc的constraints文件
（4）如果你是参加挑战班的新手，而且打算使用RISC-V架构的指令集，那么我推荐从伯克利的CS61C课程入手，而不是局限于Verilog和数字设计。此外，开源不等于可以直接抄，希望看到这个项目的同学不要偷懒。这是一个很好的学习机会。 
如果有专业人士无意间翻到了这个渣作，求大佬轻喷（另外readme也没时间写的很完整，以后有时间想起来再写吧）
