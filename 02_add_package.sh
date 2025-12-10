


# 从配置文件读取
# 支持传入配置文件名作为参数，默认使用 package.conf
conf_file=${1:-package.conf}

if [ ! -f "../$conf_file" ]; then
    echo "Error: Configuration file ../$conf_file not found!"
    exit 1
fi

echo "Loading packages from $conf_file..."
file_content=$(cat "../$conf_file")
# 在每一行前面添加"CONFIG_PACKAGE_"，在后面添加"=y"
new_content=$(echo "$file_content" | awk '{print "CONFIG_PACKAGE_" $0 "=y"}')
# 将修改后的内容追加到.config文件中
echo "$new_content" >> .config
echo "Packages from $conf_file added successfully."



