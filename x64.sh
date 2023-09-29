#!/bin/bash

# 添加SSRP+
sed -i "/helloworld/d" "feeds.conf.default"
echo "src-git helloworld https://github.com/fw876/helloworld.git" >>"feeds.conf.default"

# 添加iStore
echo >>feeds.conf.default
echo 'src-git istore https://github.com/linkease/istore;main' >>feeds.conf.default
# ./scripts/feeds update istore
# ./scripts/feeds install -d y -p istore luci-app-store

# 添加OpenClash
if [ -d "OpenClash" ]; then
    cd OpenClash
    git pull
else
    git clone https://github.com/vernesong/OpenClash.git
fi
cp -rf OpenClash/luci-app-openclash package/luci-app-openclash

# 添加UA2F
git clone https://github.com/Zxilly/UA2F.git package/UA2F

# 更新queue
git clone https://github.com/openwrt/packages
rm -rf package/libs/libnetfilter-queue
cp -rf packages/libs/libnetfilter-queue package/libs/

# 修改内核设置,不直接全部追加的原因是看起来不舒服
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
