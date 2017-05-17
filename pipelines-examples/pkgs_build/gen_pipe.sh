#! /bin/bash

gen_pipe(){
PKG_NAME=$1
cat << EOF >> pipegen.yml
  - name: $PKG_NAME
    plan:
      - task: install-$PKG_NAME
        config:
         platform: linux
         image_resource:
           type: docker-image
           source: {repository: opensuse}
         run:
           path: zypper
           args: ["-n in $PKG_NAME"]
EOF
}

# take input, which pkg to test
mapfile -t pkgs < pkgs.txt

rm -f pipegen.yml
echo "jobs:" > pipegen.yml

# generate pipe
for pkg in "${pkgs[@]}"
do
   gen_pipe $pkg
done
