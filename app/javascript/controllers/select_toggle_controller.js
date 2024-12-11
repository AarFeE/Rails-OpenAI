import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="select-toggle"
export default class extends Controller {
  
  static targets = [ "select", "mailSection" ]

  connect() {
    this.toggleMailVisibility()
  }

  toggleMailVisibility() {
    // Convert the string value to a boolean for comparison
    const isBackgroundJob = this.selectTarget.value
    
    if (isBackgroundJob == "true") {
      this.mailSectionTarget.style.display = 'block';
    } else {
      this.mailSectionTarget.style.display = 'none';
    }
  }
}