# 源程序使用说明
TrueTime Kernel 1  ---------执行器和传感器        
TrueTime Kernel 2  ---------控制器    
TrueTime Network 1 ------GTS    
TrueTime Network 2 ------CAP       
TrueTime Network 3 ------Beacon     


### 基本说明

- Matlab 2014, Truetime 2.0


### 系统框架
![](https://github.com/jiangtaohe/pb_truncation_controller/blob/master/system.PNG)
<br>

![](https://github.com/jiangtaohe/pb_truncation_controller/blob/master/truetime_block.PNG)

### 函数列表

| 函数名称 | 输入参数说明 | 输出参数说明 | 函数功能 |
| -------- | ------------ | ------------ | -------- |
|S_A_init|square of the threshold||初始化 kernel 1|
|sen_code|||实现传感器采样并根据调度策略发送|
|act_code|||实现 CAS，将控制量施加给执行器|
|update_u_code|||更新 ECS|
|con_init|  |              |初始化 kernel 2|
| cal_code| ||接收 Kernel 1 发送的信息，计算 ECS并根据调度策略发送|
|self_tr|||实现 MBT, 计算 FCS 的截断位置 |
|self_tr2|||不同条件下的 self_tr|
|self_tr3|||不同条件下的 self_tr|



### 注意事项
sen_code 和 cal_code 中包含静态变量。因此每次运行 simulink 仿真系统前需要使用如下命令恢复静态变量。
```matlab
 clear sen_code
 clear cal_code
```
