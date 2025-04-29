#!/bin/bash

#使用 sqlcipher 加密现有数据库
#需要先配置 sqlcipher
# macOS : brew install sqlcipher
#https://discuss.zetetic.net/t/encrypte-existing-db/4190

ENCRYPTED_NAME="encrypted.db"
ENCRYPTED_PATH="../$ENCRYPTED_NAME"
# 源文件
DB_NAME="words.db"
DB_PATH="../$DB_NAME"
# 密码
PASSWORD="words"

# 检查明文数据库是否存在
if [ ! -f $DB_PATH ]; then
    echo "数据库不存在"
    exit 1
fi

# 创建 SQL 命令
SQL_COMMANDS=$(cat << EOF
ATTACH DATABASE '$ENCRYPTED_NAME' AS encrypted KEY '$PASSWORD';
SELECT sqlcipher_export('encrypted');
DETACH DATABASE encrypted;
.exit
EOF
)

echo "开始加密......"

# 执行 SQLCipher 命令
echo "$SQL_COMMANDS" | sqlcipher "$DB_PATH"

# 检查加密数据库是否存在，如果存在则移动到 assets 目录下
if [ ! -f "$ENCRYPTED_NAME" ]; then
    echo "加密失败"
    exit 1
fi
# 移动加密数据库到 assets 目录下
mv "$ENCRYPTED_NAME" "$ENCRYPTED_PATH"

echo "加密完成"
echo "加密数据库路径：$ENCRYPTED_PATH"
echo "加密数据库密码：$PASSWORD"
