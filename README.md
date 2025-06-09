# 📱 ADB 代理控制脚本

该脚本用于通过 ADB 快速设置或关闭 Android 设备的 HTTP 代理，适用于开发调试代理流量场景（如配合 Charles、Mitmproxy、Fiddler 使用）。支持菜单交互，简单易用。

## ✨ 功能特性

* 获取当前 Mac 本机局域网 IP 地址（适配 macOS）
* 设置 Android 全局 HTTP 代理
* 一键关闭代理设置
* 查看当前代理状态
* 动态修改代理端口（默认 `8080`）

---

## 📦 使用前提

1. 已安装 `adb` 工具，并配置好环境变量
2. Android 设备已开启开发者选项 + USB 调试
3. 已连接设备（`adb devices` 可正常识别）

---

## 🚀 如何使用

### 1. 下载脚本

#### 默认安装为 `adbp`

```bash
curl -fsSL https://yourdomain.com/install.sh | bash
```

#### 自定义命令名称（如 `adbp-lite`）

```bash
curl -fsSL https://yourdomain.com/install.sh | bash -s -- adbp-lite
```

---

### 2. 运行脚本

```bash
adbp
```

### 3. 菜单选项

```
===== 🚀 ADB代理控制菜单 =====
1. 设置代理 (端口: 8080)
2. 关闭代理
3. 检查代理状态
4. 修改代理端口
============================
```

按提示输入编号进行操作，输入 `q` 退出脚本，`m` 可重新显示菜单。

---

## 🛠 示例用法

#### 设置代理（默认端口 8080）

选择 `1`，将设备代理设置为 `你的本机局域网 IP:8080`

#### 修改端口为 8888 再设置代理

1. 输入 `4` 修改端口
2. 输入 `1` 设置代理

#### 查看当前代理状态

输入 `3` 查看当前设备的 `http_proxy` 设置

#### 关闭代理

输入 `2`，设备将清空 http\_proxy 设置

---

## ⚠️ 注意事项

* 当前仅适配 macOS 获取局域网 IP（使用 `ifconfig en0`）
* 若你使用的是其他系统（如 Linux、Windows WSL），请根据需要修改 `get_local_ip()` 方法
* 有些设备可能无法通过 `adb shell settings` 成功设置代理，此为系统限制
