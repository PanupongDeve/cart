#!/bin/bash

export REMOTE_CONTAINER_REGISTRY=${REMOTE_CONTAINER_REGISTRY:-"panupongdeve/gitops-my-cart"}
REMOTE_CONTAINER_REGISTRY_USERNAME=${REMOTE_CONTAINER_REGISTRY_USERNAME:-"panupongdeve"}
REMOTE_CONTAINER_REGISTRY_PATH_PATH=${REMOTE_CONTAINER_REGISTRY_PATH_PATH:-"$HOME/.ssh/docker-pat.txt"}
GIT_MANIFEST_URL=${GIT_MANIFEST_URL:-"git@github.com:PanupongDeve/nonprod-k8s-manifests.git"}
CLONE_DIR=${CLONE_DIR:-"nonprod-k8s-manifests"}
MANIFEST_PATH=${MANIFEST_PATH:-"dev/e-commerce/cart"}
BRANCH=${BRANCH:-"develop"}
SSH_KEY=${SSH_KEY:-"$HOME/.ssh/argocd_ssh_key"}

ROOT_DIR=$PWD
export SHORT_COMMIT=$(git rev-parse --short HEAD)

# Ensure SSH key exists
if [ ! -f "$SSH_KEY" ]; then
    echo "❌ SSH key not found at $SSH_KEY"
    exit 1
fi

# Build and push container
cat $REMOTE_CONTAINER_REGISTRY_PATH_PATH | docker login --username $REMOTE_CONTAINER_REGISTRY_USERNAME --password-stdin
docker build -t $REMOTE_CONTAINER_REGISTRY:$SHORT_COMMIT .
docker push $REMOTE_CONTAINER_REGISTRY:$SHORT_COMMIT


# Create a temporary SSH wrapper to avoid prompts
SSH_WRAPPER=$(mktemp)
chmod 700 "$SSH_WRAPPER"

cat > "$SSH_WRAPPER" <<EOF
#!/bin/sh
exec ssh -i "$SSH_KEY" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "\$@"
EOF

# Clone using the wrapper
echo "🔄 Cloning from $GIT_MANIFEST_URL..."
GIT_SSH="$SSH_WRAPPER" git clone "$GIT_MANIFEST_URL" "$CLONE_DIR"

# Check result
if [ $? -eq 0 ]; then
    echo "✅ Clone successful."
else
    echo "❌ Clone failed."
    exit 1
fi

# Assign short commit to tag image 
cd $CLONE_DIR; git checkout $BRANCH
cd $ROOT_DIR/$CLONE_DIR/$MANIFEST_PATH
yq -i '.spec.template.spec.containers[0].image = strenv(REMOTE_CONTAINER_REGISTRY) + ":" + strenv(SHORT_COMMIT)' deployment.yaml
git commit -am "release $REMOTE_CONTAINER_REGISTRY:$SHORT_COMMIT"
git push origin $BRANCH



# Clean up
rm -f "$SSH_WRAPPER"
echo "deletig $CLONE_DIR"
cd $ROOT_DIR
rm -rf "$CLONE_DIR"
echo "deleted $CLONE_DIR"

