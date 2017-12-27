# remove alias from oh-my-zsh

# rails plugins
rails_cmds=("devlog" "prodlog" "testlog" "RED" "REP" "RET" "rc" "rcs" "rd" "rdb" "rg" "rgm" "rp" "ru" "rs" "rsd" "rsp" "rdm" "rdms" "rdr" "rdc" "rds" "rdd" "rdrs" "rdtc" "rdtp" "rdmtc" "rdsl" "rlc" "rn" "rr" "rrg" "rt" "rmd" "rsts" "sstat" "sg" "sd" "sp" "sr" "ssp" "sc" "sd")
for cmd in ${rails_cmds[*]}
do
    unalias $cmd > /dev/null 2>&1
done
