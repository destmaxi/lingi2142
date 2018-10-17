#make dirs if non exist
mkdir -p ucl_minimal_cfg/HALL/log
mkdir -p ucl_minimal_cfg/MICH/log
mkdir -p ucl_minimal_cfg/PYTH/log
mkdir -p ucl_minimal_cfg/STEV/log
mkdir -p ucl_minimal_cfg/SH1C/log
mkdir -p ucl_minimal_cfg/CARN/log

#cleanup log files
sudo echo > ucl_minimal_cfg/HALL/log/bird_log
sudo echo > ucl_minimal_cfg/PYTH/log/bird_log
sudo echo > ucl_minimal_cfg/STEV/log/bird_log
sudo echo > ucl_minimal_cfg/CARN/log/bird_log
sudo echo > ucl_minimal_cfg/MICH/log/bird_log
sudo echo > ucl_minimal_cfg/SH1C/log/bird_log

#cp protocols file
cp /etc/protocols ucl_minimal_cfg/HALL/
cp /etc/protocols ucl_minimal_cfg/PYTH/
cp /etc/protocols ucl_minimal_cfg/STEV/
cp /etc/protocols ucl_minimal_cfg/CARN/
cp /etc/protocols ucl_minimal_cfg/MICH/
cp /etc/protocols ucl_minimal_cfg/SH1C/
