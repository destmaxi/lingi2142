#make dirs
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
