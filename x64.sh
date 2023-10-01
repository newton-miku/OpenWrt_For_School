#!/bin/bash
###
# @Author: newton_miku 1316561519@qq.com
# @Date: 2023-09-28 14:03:36
# @LastEditors: newton_miku 1316561519@qq.com
# @LastEditTime: 2023-10-01 18:18:33
# @FilePath: \UA2F_Build\x64.sh
# @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
###

# 添加SSRP+
if ! grep -q "src-git helloworld https://github.com/fw876/helloworld.git" feeds.conf.default; then
    echo "src-git helloworld https://github.com/fw876/helloworld.git" >>"feeds.conf.default"
else
    echo "helloworld源存在，跳过添加"
fi

# 添加iStore
if ! grep -q 'src-git istore https://github.com/linkease/istore;main' feeds.conf.default; then
    echo 'src-git istore https://github.com/linkease/istore;main' >>feeds.conf.default
else
    echo 'istore源存在，跳过添加'
fi
# ./scripts/feeds update istore
# ./scripts/feeds install -d y -p istore luci-app-store

# 添加small8软件源
if ! grep -q 'src-git small8 https://github.com/kenzok8/small-package' feeds.conf.default; then
    echo 'src-git small8 https://github.com/kenzok8/small-package' >>feeds.conf.default
else
    echo 'small8源存在，跳过添加'
fi

# 添加OpenClash
if [ -d "OpenClash" ]; then
    cd OpenClash
    git pull
    cd ../
else
    git clone --depth=1 https://github.com/vernesong/OpenClash.git -b master
fi
cp -rf OpenClash/luci-app-openclash package/luci-app-openclash

# 添加xmurp-ua
if [ -d "package/xmurp-ua" ]; then
    cd package/xmurp-ua
    git pull
    cd ../../
else
    git clone https://github.com/newton-miku/xmurp-ua.git package/xmurp-ua
fi

# # 添加UA2F
# if [ -d "package/UA2F" ]; then
#     cd package/UA2F
#     git pull
#     cd ../../
# else
#     git clone https://github.com/Zxilly/UA2F.git package/UA2F
# fi

# 更新queue
if [ -d "packages" ]; then
    rm -rf packages
fi
git clone --depth=1 https://github.com/openwrt/packages
rm -rf package/libs/libnetfilter-queue
cp -rf packages/libs/libnetfilter-queue package/libs/

# 修改内核设置,不直接全部追加的原因是看起来不舒服
# echo $PWD
echo "CONFIG_IP_SET=y" >>target/linux/x86/config-5.4
echo "CONFIG_IP_SET_HASH_IPPORT=y" >>target/linux/x86/config-5.4
echo "CONFIG_IP_SET_MAX=256" >>target/linux/x86/config-5.4
echo "CONFIG_NETFILTER=y" >>target/linux/x86/config-5.4
echo "CONFIG_NETFILTER_FAMILY_ARP=y" >>target/linux/x86/config-5.4
echo "CONFIG_NETFILTER_FAMILY_BRIDGE=y" >>target/linux/x86/config-5.4
echo "CONFIG_NETFILTER_NETLINK=y" >>target/linux/x86/config-5.4
echo "CONFIG_NETFILTER_NETLINK_GLUE_CT=y" >>target/linux/x86/config-5.4
echo "CONFIG_NETFILTER_NETLINK_LOG=y" >>target/linux/x86/config-5.4
echo "CONFIG_NETFILTER_XTABLES=y" >>target/linux/x86/config-5.4
echo "CONFIG_NFT_REJECT=m" >>target/linux/x86/config-5.4
echo "CONFIG_NFT_REJECT_IPV4=m" >>target/linux/x86/config-5.4
echo "CONFIG_NF_CONNTRACK=y" >>target/linux/x86/config-5.4
echo "CONFIG_NF_CONNTRACK_LABELS=y" >>target/linux/x86/config-5.4
echo "CONFIG_NF_CT_NETLINK=y" >>target/linux/x86/config-5.4
echo "CONFIG_NF_DEFRAG_IPV4=y" >>target/linux/x86/config-5.4
echo "CONFIG_NF_REJECT_IPV4=m" >>target/linux/x86/config-5.4
echo "CONFIG_NF_TABLES=y" >>target/linux/x86/config-5.4
