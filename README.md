# DifferentialSteering

这是一个基于 ESP32 的双轮差速小车控制项目，核心目标是实现遥控输入下的双电机速度闭环控制。

## 当前工程内容

- 控制代码：`src/main.cpp`
- 控制链路：接收机 PWM 输入 -> 差速混合 -> 双路速度 PID -> TB6612 输出
- 反馈传感：双轮编码器测速
- 安全机制：遥控信号超时失控保护
- 状态遥测：串口输出统一 `STAT,...` 行，便于日志记录与分析

## 当前硬件（按你的最新目标）

- 主控：ESP32
- 接收机：FlySky FGr8B
- 电机驱动：TB6612
- 电机：WheelTec MG310P20_7.4V（双轮）
- 新增电源：DCP3512 四路电源模块

## 下一步闭环控制建议

1. 先完成供电分层：电机电源与控制电源分离，共地。
2. 先单轮调参再双轮联调，减少耦合干扰。
3. 标定编码器计数与减速比，修正速度换算。
4. PID 调参顺序建议：先 Kp，再 Ki，最后按需加 Kd。

## 代码仓策略

本仓库按“轻量代码仓”管理：

- 保留代码与说明文档。
- 忽略大体积资料包、安装器、视频、三维模型等文件。
- 如需共享大资料，建议使用网盘链接或 GitHub Release。

## 调试记录

调试过程请记录到 [DEBUG_LOG.md](DEBUG_LOG.md)，每次你反馈系统状态、串口日志、参数修改建议时，都按统一模板补充，便于后续回看和复盘。

## VS Code 本地运行与调试（仅 PlatformIO）

已完全按 VS Code + PlatformIO 工作流配置，不再依赖 Arduino IDE。

### 一次性准备

1. 安装 VS Code 扩展：PlatformIO IDE。
2. 在项目根目录执行：

```bash
./scripts/setup_env.sh
```

### 每次本地调试（从云端同步）

```bash
./scripts/sync_and_build.sh
```

### 烧录与串口监视

```bash
./scripts/upload.sh
./scripts/monitor.sh
```

也可以在 VS Code 里直接运行任务：

- `Setup Local Env`
- `Sync And Build`
- `Build Firmware`
- `Upload Firmware`
- `Open Serial Monitor`
- `Repo Status Snapshot`

### 状态更新输出格式

固件会周期性输出状态行（默认 200ms 一次），格式示例：

```text
STAT,ms=12345,failsafe=0,rc1=1502,rc2=1498,thr=0,str=0,tgtL=0.00,tgtR=0.00,actL=0.00,actR=0.00,pwmL=0,pwmR=0,encL=120,encR=118
```

可用于：

- 调参时观察目标/实际速度偏差
- 比较左右轮输出一致性
- 记录失控保护触发与恢复
- 导出日志做离线分析

## GitHub 推送（模板）

```bash
git remote add origin <你的GitHub仓库地址>
git push -u origin main
```

如果远端默认分支是 `master`，将 `main` 改为 `master` 即可。