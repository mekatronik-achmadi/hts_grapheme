#/bin/bash

export HERE_DIR=$(pwd)

# ============= root directory =========
rm -rvf configs/
rm -rvf edfiles/
rm -rvf gen/
rm -rvf gv/
rm -rvf models/
rm -rvf mspf/
rm -rvf proto/
rm -rvf stats/
rm -rvf trees/
rm -rvf voices/
rm -vf config.log
rm -vf config.status
rm -vf Makefile

# ============= scripts directory =========
cd $HERE_DIR/scripts/
rm -vf Config.pm

# ============= data directory =========
cd $HERE_DIR/data/

rm -rvf bap/
rm -rvf cmp/
rm -rvf lf0/
rm -rvf lists/
rm -rvf mgc/
rm -rvf scp/
rm -vf Makefile

# ============= data/labels directory =========
cd $HERE_DIR/data/labels/

rm -rvf full/
rm -rvf mono/
rm -vf full.mlf
rm -vf mono.mlf
