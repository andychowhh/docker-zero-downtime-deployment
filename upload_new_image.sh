save_image_to_tar() {
  docker save webapp > webapp.tar
}

upload_tar_to_vm() {
  scp ./webapp.tar username@your_vm_public_ip:~/
}

load_image_from_tar() {
  ssh username@your_vm_public_ip "docker load -i webapp.tar"
}

main() {
  # Prepare a new version of your application locally
  docker build -t webapp ./webapp

  # Save the image as TAR file for uploading the image to VM
  save_image_to_tar

  # Upload the TAR file to your target VM
  upload_tar_to_vm

  # Load an image from a tar archive in your VM
  load_image_from_tar
}

main