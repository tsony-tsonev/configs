#bin/sh
set -x

#rm ~/$1/config/eval/GoLand*.evaluation.key # for versions before 2020
rm ~/.config/JetBrains/$1/eval/GoLand*.evaluation.key
#sed -i '/evlsprt/d' ~/$1/config/options/options.xml #for versions before 2019
#sed -i '/evlsprt/d' ~/$1/config/options/other.xml # for versions before 2020
sed -i '/evlsprt/d' ~/.config/JetBrains/$1/options/other.xml 
rm -rf ~/.java/.userPrefs/jetbrains/goland
