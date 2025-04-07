docker build -t rust-dev-env .
if [ $? -ne 0 ]; then
  echo "Failed to build the image."
  exit 1
fi
docker run -d --name rust-dev-env -v $(pwd):/home/devuser -w /home/devuser rust-dev-env tail -f /dev/null