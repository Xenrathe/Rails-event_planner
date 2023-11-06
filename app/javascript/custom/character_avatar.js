function initializeFunctions()
{
  const avatarThumbnailsFull = document.getElementById("avatar-thumbnails-full")
  const showAvatarsButton = document.getElementById("show-avatars");

  showAvatarsButton.addEventListener("click", () => {
    avatarThumbnailsFull.style.display = 'block';
  });

  avatarThumbnailsFull.addEventListener("click", () => {
    avatarThumbnailsFull.style.display = 'none';
  });

  document.querySelectorAll('.avatar-thumbnail-btn').forEach(button => {
    button.addEventListener('click', function() {
      // Adjust the value of the hidden field #avatar_path to match the .jpg file name
      document.getElementById('avatar-path').value = this.querySelector('img').id;
  
      // Hide the avatarThumbnails div
      avatarThumbnailsFull.style.display = 'none';
  
      // Update the main avatar image to match the selected image
      const selectedImage = this.querySelector('img').src;
      document.getElementById('avatar-thumbnail-main').src = selectedImage;
    });
  });

}

initializeFunctions();
document.addEventListener('turbo:render', function() { initializeFunctions(); });