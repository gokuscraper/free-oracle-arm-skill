#!/bin/bash
# ==========================================
# Oracle Cloud Free Tier ARM 抢机脚本
# 区域自动检测 + 每60秒重试
# ==========================================

export PATH=$PATH:$HOME/.local/bin
export SUPPRESS_LABEL_WARNING=True
export OCI_CLI_SUPPRESS_FILE_PERMISSIONS_WARNING=True

# ====== Server酱 微信通知（可选）=======
# 注册地址：https://sct.ftqq.com（微信扫码）
# 不填则不通知
SCT_KEY=""

# ====== 必填参数（替换为你的值）=======
COMPARTMENT_ID=""           # 租户OCID
AVAILABILITY_DOMAIN=""      # 可用域，如 xxx:AP-OSAKA-1-AD-1
SUBNET_ID=""                # 公网子网ID
IMAGE_ID=""                 # Ubuntu ARM 镜像ID
SSH_KEY_FILE=""             # SSH公钥路径

# ====== 可选参数 ======
SHAPE="VM.Standard.A1.Flex"
OCPUS=2
MEMORY=12
BOOT_SIZE=100
DISPLAY_NAME="arm"
INTERVAL=60

# ====== 检查参数是否填全 ======
if [ -z "$COMPARTMENT_ID" ] || [ -z "$AVAILABILITY_DOMAIN" ] || [ -z "$SUBNET_ID" ] || [ -z "$IMAGE_ID" ] || [ -z "$SSH_KEY_FILE" ]; then
    echo "错误：请先填写脚本中的必填参数"
    echo "  COMPARTMENT_ID（租户OCID）"
    echo "  AVAILABILITY_DOMAIN（可用域）"
    echo "  SUBNET_ID（子网ID）"
    echo "  IMAGE_ID（镜像ID）"
    echo "  SSH_KEY_FILE（SSH公钥路径）"
    exit 1
fi

if [ ! -f "$SSH_KEY_FILE" ]; then
    echo "错误：SSH公钥文件不存在: $SSH_KEY_FILE"
    exit 1
fi

# ====== 发送微信通知 ======
send_notification() {
    if [ -n "$SCT_KEY" ]; then
        local title="$1"
        local content="$2"
        curl -X POST "https://sctapi.ftqq.com/${SCT_KEY}.send" \
            -d "title=${title}" \
            -d "desp=${content}" >/dev/null 2>&1
    fi
}

# ====== 主循环 ======
echo "=========================================="
echo "  Oracle Cloud ARM 抢机脚本"
echo "  区域: ${AVAILABILITY_DOMAIN}"
echo "  配置: ${OCPUS} OCPU / ${MEMORY} GB"
echo "  间隔: ${INTERVAL}秒/次"
echo "=========================================="
echo ""

COUNT=0
while true; do
    COUNT=$((COUNT + 1))
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[${TIMESTAMP}] 第 ${COUNT} 次尝试..."

    RESULT=$(oci --no-retry compute instance launch \
        --availability-domain "${AVAILABILITY_DOMAIN}" \
        --compartment-id "${COMPARTMENT_ID}" \
        --shape "${SHAPE}" \
        --shape-config "{\"ocpus\":${OCPUS},\"memoryInGBs\":${MEMORY}}" \
        --display-name "${DISPLAY_NAME}" \
        --image-id "${IMAGE_ID}" \
        --boot-volume-size-in-gbs "${BOOT_SIZE}" \
        --subnet-id "${SUBNET_ID}" \
        --assign-public-ip true \
        --ssh-authorized-keys-file "${SSH_KEY_FILE}" \
        2>&1)

    if echo "$RESULT" | grep -qiE "error|InternalError"; then
        if echo "$RESULT" | grep -qiE "Out of host capacity|Out of capacity"; then
            echo "  → 没货，${INTERVAL}秒后重试..."
            sleep ${INTERVAL}
        elif echo "$RESULT" | grep -qiE "TooManyRequests|rate limit"; then
            echo "  → 被限速了，休息2分钟..."
            sleep 120
        elif echo "$RESULT" | grep -qiE "LimitExceeded"; then
            echo "  → 配额已满（可能已有实例），退出"
            send_notification "ARM 抢机失败" "配额已满，请检查控制台已有实例"
            exit 1
        else
            echo "  → 未知错误:"
            echo "$RESULT"
            echo "  → 休息30秒后重试..."
            sleep 30
        fi
    elif echo "$RESULT" | grep -qi "provisioning"; then
        echo ""
        echo "=========================================="
        echo "  🎉 抢到了！"
        echo "=========================================="
        echo "$RESULT"
        echo ""

        INSTANCE_IP=$(echo "$RESULT" | grep -oP '"public-ip":\s*"[^"]*"' | grep -oP '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+')
        echo "$TIMESTAMP 成功创建" >> $HOME/grab_success.log
        echo "${INSTANCE_IP:-IP不可用}" >> $HOME/grab_success.log

        send_notification "🎉 ARM 抢机成功" "区域：${AVAILABILITY_DOMAIN}
配置：${OCPUS} OCPU / ${MEMORY} GB
时间：${TIMESTAMP}
IP：${INSTANCE_IP:-查看控制台}

登录：ssh -i 私钥 ubuntu@${INSTANCE_IP:-IP}"

        exit 0
    else
        echo "  → 未知返回，${INTERVAL}秒后重试..."
        echo "$RESULT"
        sleep ${INTERVAL}
    fi
done
