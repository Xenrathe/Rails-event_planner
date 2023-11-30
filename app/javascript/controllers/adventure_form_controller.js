import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["date", "min", "max"]

  // Adds event listener to these targets to reset customValidity
  connect(){
    this.resetValidity(this.minTarget);
    this.resetValidity(this.maxTarget);
  }

  validate(event) {
    // Parse inputs to appropriate data types
    const selectedDate = new Date(this.dateTarget.value);
    console.log("selectedDate: " + selectedDate);
    const minLevel = parseInt(this.minTarget.value, 10);
    const maxLevel = parseInt(this.maxTarget.value, 10);
    this.dateTarget.setCustomValidity("");
    this.minTarget.setCustomValidity("");
    this.maxTarget.setCustomValidity("");

    // Perform validations
    if (selectedDate < new Date()) {
      this.dateTarget.setCustomValidity("Date cannot be in the past.");
      this.dateTarget.reportValidity();
      event.preventDefault(); // Prevent form submission
    }
    else if (minLevel < 1 || minLevel > 99) {
      this.minTarget.setCustomValidity("Min level must be between 1-99.");
      this.minTarget.reportValidity();
      event.preventDefault();
    }
    else if (maxLevel < 1 || maxLevel > 99) {
      this.maxTarget.setCustomValidity("Max level must be between 1-99.");
      this.maxTarget.reportValidity();
      event.preventDefault();
    }
    else if (minLevel > maxLevel) {
      this.minTarget.setCustomValidity("Min-level cannot be greater than max-level.");
      this.minTarget.reportValidity();
      event.preventDefault();
    }
  }

  //Note: Not currently in-use
  addErrorDiv(originalElement) {
    var errorDiv = document.createElement('div');
    errorDiv.classList.add('field_with_errors');
    var originalClone = originalElement.cloneNode(true);
    errorDiv.appendChild(originalClone);
    originalElement.parentNode.replaceChild(errorDiv, originalElement);
  }

  resetValidity(element) {
    element.addEventListener('input', function () {
      element.setCustomValidity('');
    });
  }
}