// app/javascript/controllers/application.js

import { Application } from "@hotwired/stimulus"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

// Automatically eager load all controllers
eagerLoadControllersFrom("controllers", application)

export { application }
