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
2025.2.15 Update: 系统学习了计组过后发现我们做的这个东西严格意义上也不算多周期hhhh，实际上可以加上流水线再加forwarding, early branch resolution, 乱序啥的，我们这个太toy project了

# ADDL Challenge Course Project: Simple RISC-V CPU Core

This is the course project of **ADDL (Application and Design of Digital Logic) Challenge course** at **Glasgow College, UESTC**.  
This project involves a simple CPU core which supports part of the RISC-V ISA (more details can be found in the document). The main design work is accomplished in Verilog HDL, and the design has passed the simple testbenches specifically developed for this project.

> **Note:** This README will be updated further if I have more time.

---

# 项目简介

这个项目是电子科技大学格拉斯哥学院挑战性课程——**数字逻辑设计与应用**的课程设计。项目要求我们设计一个简易的 CPU 并在 FPGA 上运行。我们选择的指令集是 RISC-V 的部分指令。

- **主要工作：**
  - 使用 Verilog 硬件描述语言完成设计。
  - 通过专门设计的简易测试平台验证了 CPU 的功能。

> **备注：**  
> 由于课程限制，我没有使用 Verilator 或 ModelSim 这类专业波形查看软件，而是采用了 Vivado 内置的仿真功能。

---

# 设计说明

详细的设计信息请参见 Design Report 的 doc 文件（为了避免暴露组员的姓名和学号信息，报告中已做了相应处理）。

在设计过程中，有些思想没有在报告中写明：
  
1. **流水线设计：**  
   - 原计划实现流水线，但由于时间不足，最后删去了流水线寄存器，做成了多周期设计（实际上仍然在打拍子），最终形成了一个伪流水线结构，哈哈。
  
2. **存储器划分：**  
   - RAM 用于存储数据，ROM 用于存储指令。这两部分不在 CPU 结构内部，而是在测试时另外添加的。
  
3. **下板问题：**  
   - 项目最终没有下板验证，因为负责下板的同学没有找到合适的下板思路来验证 CPU 的运行（例如如何驱动流水灯），因此没有提供 .xdc 的 constraints 文件。
  
4. **项目建议：**  
   - 如果你是挑战班的新手，并且打算使用 RISC-V 架构的指令集，我推荐从伯克利的 CS61C 课程入手，而不要只局限于 Verilog 和数字设计。  
   - 此外，开源并不意味着可以直接抄袭，希望看到这个项目的同学不要偷懒，这也是一个很好的学习机会。

> 如果有专业人士无意间看到了这个“渣作”，请多多包涵（另外，由于时间有限，README 写得也不够完整，以后有时间再补充）。

---

# 更新日志

**2025.2.15 Update:**  
系统学习了计算机组成原理后发现，我们做的这个项目严格意义上也不算是多周期设计。实际上，可以在此基础上加入流水线、转发（forwarding）、提前分支决议（early branch resolution）、乱序执行等技术。但目前这个项目只是个 toy project。

---

