#!/bin/bash

# =============================================
# 📦 安装脚本：将 Android Proxy 工具安装为本地命令
# ✅ 使用方式：
#    默认安装为 adbp：
#      curl -fsSL https://yourdomain.com/install.sh | bash
#    自定义命令名（如 adbp-lite）：
#      curl -fsSL https://yourdomain.com/install.sh | bash -s -- adbp-lite
# =============================================

# 默认变量
REMOTE_URL="https://raw.githubusercontent.com/mengxn/AndroidProxy/main/android_proxy.sh"
INSTALL_DIR="/usr/local/bin"
DEFAULT_NAME="adbp"

# 检查 curl 是否安装
if ! command -v curl &> /dev/null; then
    echo "❌ 错误: curl 未安装，请先安装 curl。"
    exit 1
fi

# 获取用户指定的名称（如果有）
CUSTOM_NAME="$1"

# 如果没有指定名称，使用默认名称
if [ -z "$CUSTOM_NAME" ]; then
  CUSTOM_NAME="$DEFAULT_NAME"
fi

TARGET_PATH="$INSTALL_DIR/$CUSTOM_NAME"

# 创建目录（如果不存在）
if [ ! -d "$INSTALL_DIR" ]; then
  echo "📁 创建目录 $INSTALL_DIR"
  sudo mkdir -p "$INSTALL_DIR"
fi

# 下载远程脚本
echo "🌐 正在从远程下载 $CUSTOM_NAME ..."
if ! curl -fsSL "$REMOTE_URL" -o "$TARGET_PATH"; then
    echo "❌ 错误: 下载 $TARGET_PATH 失败。"
    exit 1
fi

# 设置执行权限
echo "🔧 设置执行权限..."
sudo chmod +x "$TARGET_PATH"

# 检查是否在 PATH 中
if [[ ":$PATH:" != *":$(dirname "$TARGET_PATH"):"* ]]; then
    echo "⚠️ 注意: $(dirname "$TARGET_PATH") 不在 PATH 环境变量中。"
    echo "👉 您可能需要将其添加到 PATH 或使用完整路径执行脚本。"
fi

# 安装完成提示
echo "✅ 安装完成！你可以运行：$CUSTOM_NAME"