// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "flowbite"

document.addEventListener("DOMContentLoaded", function() {
    const select = document.getElementById('show-mail-select');
    const mail = document.getElementById('mail-opt');
  
    select.addEventListener('change', function() {
      console.log("THE VALUE IS: " + select.value);
      if (select.value === 'true') {
        mail.style.display = 'block';
      } else {
        mail.style.display = 'none';
      }
    });
});