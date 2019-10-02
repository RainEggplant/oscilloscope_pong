# Oscilloscope Pong

**Oscilloscope pong（示波器上的弹球游戏）** is a project for the _Electronic Circuit Course Design （电子电路课程设计）_ course of E.E., Tsinghua University. It contains the circuit diagram (in `report.pdf`) and the FPGA project. 

[**Video Display**](./display.mp4)



## Set up the FPGA Project

When opening the project after cloning it, do it by using `Tools -> Run Tcl Script...` and selecting the `mips_pipeline_cpu.tcl` file. This will regenerate the project so that you can start to work.

## VSCode Integration

If you want to use VSCode to develop, please view this [link](https://github.com/RainEggplant/vscode-verilog-integration).

After you set up the environment, remember to change `"systemverilog.launchConfiguration"` property in `.vscode/settings.json` to ensure that it contains the correct directories.

## About

This project uses [kevlaine/vivado-git](https://github.com/kevlaine/vivado-git) to make it git-friendly (works under Vivado 2018.3).

