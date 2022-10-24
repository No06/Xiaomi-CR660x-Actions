echo '--开始部署环境--'
sleep 3
sudo apt update
sudo -E apt-get -qq install $(curl -fsSL https://is.gd/depends_ubuntu_2204)
sudo -E apt-get -qq install libfuse-dev
sudo -E apt-get -qq install rename
sudo -E apt-get -qq install time
sudo -E apt-get -qq autoremove --purge
sudo -E apt-get -qq clean
df -Th

echo '--下载源码--'
sleep 3
git clone --depth 1 https://github.com/coolsnowwolf/lede -b master
cd lede
bash -c "$(https://github.com/runoo6/Xiaomi-CR660x-Actions/raw/main/diy-part1.sh)"

echo '--更新软件源--'
sleep 3
./scripts/feeds update -a
./scripts/feeds install -a

echo '--导入配置--'
sleep 3
rm .config
wget https://github.com/runoo6/Xiaomi-CR660x-Actions/raw/main/.config
wget https://github.com/runoo6/Xiaomi-CR660x-Actions/raw/main/overclock.patch
bash -c "$(https://github.com/runoo6/Xiaomi-CR660x-Actions/blob/main/diy-part2.sh)"
mv overclock.patch target/linux/ramips/patches-5.4/102-mt7621-fix-cpu-clk-add-clkdev.patch
make defconfig
make download -j8
find dl -size -1024c -exec ls -l {} \;
find dl -size -1024c -exec rm -f {} \;

echo '--开始编译--'
sleep 3
make -j$(nproc)