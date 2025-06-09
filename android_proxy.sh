#!/bin/bash

# 默认代理端口
PROXY_PORT="8080"

# 获取本机局域网IP（适配macOS）
get_local_ip() {
    local_ip=$(ifconfig en0 inet | grep inet | awk '{print $2}')
    [ -z "$local_ip" ] && { echo "❌ 无法获取局域网IP" >&2; return 1; }
    echo "$local_ip"
}

# 设置代理
set_proxy() {
    local ip=$(get_local_ip) || return 1
    echo "🔧 设置代理: $ip:$PROXY_PORT"
    if adb shell settings put global http_proxy "$ip:$PROXY_PORT"; then
        echo "✅ 代理已设置"
    else
        echo "❌ 代理设置失败，请检查ADB连接"
    fi
}

# 关闭代理
disable_proxy() {
    echo "🔧 正在关闭代理..."
    adb shell settings put global http_proxy :0
    adb shell settings delete global http_proxy
    echo "✅ 代理已关闭"
}

# 检查代理状态
check_proxy() {
    echo "📡 正在检查代理状态..."
    current_proxy=$(adb shell settings get global http_proxy)
    case "$current_proxy" in
        "null"|"") echo "➖ 当前代理: 未设置" ;;
        *) echo "🔗 当前代理: $current_proxy" ;;
    esac
}

# 修改端口
change_port() {
    while true; do
        read -p "请输入新端口号 (当前: $PROXY_PORT): " new_port
        if [[ "$new_port" =~ ^[0-9]+$ ]] && (( new_port >= 1 && new_port <= 65535 )); then
            PROXY_PORT="$new_port"
            echo "✅ 端口已修改为: $PROXY_PORT"
            break
        else
            echo "❌ 无效输入，请输入1-65535之间的端口号"
        fi
    done
}

# 显示菜单
show_menu() {
    echo "===== 🚀 ADB代理控制菜单 ====="
    echo "1. 设置代理 (端口: $PROXY_PORT)"
    echo "2. 关闭代理"
    echo "3. 检查代理状态"
    echo "4. 修改代理端口"
    echo "============================"
}

# 主循环
main() {
    # 首次显示菜单
    show_menu
    
    while true; do
        read -p "请输入命令编号 (1-4, q=退出, m=菜单): " cmd

        case "$cmd" in
            1) set_proxy ;;
            2) disable_proxy ;;
            3) check_proxy ;;
            4) change_port ;;
            q|Q) echo "👋 退出脚本"; exit 0 ;;
            m|M) show_menu ;;
            *) echo "❌ 无效命令，输入 m 显示菜单" ;;
        esac
        
        # 每次操作后间隔一行
        echo
    done
}

main