#!/bin/bash
./scripts/feeds update -a

#拉取istore界面和ddnsto
rm -rf package/istore/
mkdir package/istore/
git clone https://github.com/linkease/istore.git package/istore/luci-app-store --depth=1
git clone https://github.com/linkease/nas-packages.git ../nas-packages --depth=1
git clone https://github.com/linkease/nas-packages-luci.git ../nas-packages-luci --depth=1
cp -r ../nas-packages/network/services/quickstart package/istore/
cp -r ../nas-packages/network/services/ddnsto package/istore/
cp -r ../nas-packages-luci/luci/luci-app-quickstart package/istore/
cp -r ../nas-packages-luci/luci/luci-app-ddnsto package/istore/

#拉取lucky
rm -rf package/lucky/
mkdir package/lucky/
git clone https://github.com/gdy666/luci-app-lucky.git package/lucky/ --depth=1

#拉取wake on lan plus
git clone https://github.com/animegasan/luci-app-wolplus.git package/luci-app-wolplus --depth=1

#单独拉取vernesong版OpenClash
 rm -rf feeds/luci/applications/luci-app-openclash/
 git clone https://github.com/vernesong/OpenClash.git feeds/luci/applications/luci-app-openclash --depth=1

#单独拉取scutclient
rm -rf feeds/luci/applications/luci-app-scutclient/
git clone https://github.com/maimaiguanfan/luci-app-scutclient.git feeds/luci/applications/luci-app-scutclient --depth=1

#单独拉取联通加速
mkdir package/scut-unicom
wget https://raw.githubusercontent.com/wykdg/route_script/master/scut-unicom/Makefile -O package/scut-unicom/Makefile

./scripts/feeds install -a

#在启动项加入联通加速
sed -i '3i #如果使用联通加速，删除前面的#，并填充后面的值\n#sleep 10 && /usr/share/scut_unicom/add_route.sh server_ip username password' package/base-files/files/etc/rc.local 

sed  -i "s/exit 0/[ ! -f '\/usr\/sbin\/trojan' ] \&\& [ -f '\/usr\/bin\/trojan-go' ] \&\& ln -sf \/usr\/bin\/trojan-go \/usr\/bin\/trojan\nexit 0/" package/emortal/default-settings/files/99-default-settings                

