import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["avatarThumbnails", "thumbnail", "thumbnailMain", "avatarPath"]

  // Adds event listener to open / close the thumbnails screen
  connect(){
    this.thumbnailMainTarget.addEventListener("click", () => {
      this.avatarThumbnailsTarget.style.display = 'block';
    });
  
    this.avatarThumbnailsTarget.addEventListener("click", () => {
      this.avatarThumbnailsTarget.style.display = 'none';
    });
  }

  selectThumbnail(event) {
    // Adjust the value of the hidden field #avatar_path to match the .jpg file name
    this.avatarPathTarget.value = event.currentTarget.querySelector('img').id;

    // Hide the avatarThumbnails div
    this.avatarThumbnailsTarget.style.display = 'none';

    // Update the main avatar image to match the selected image
    const selectedImage = event.currentTarget.querySelector('img').src;
    this.thumbnailMainTarget.src = selectedImage;
  }
}