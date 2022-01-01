import { Turbo } from '@hotwired/turbo-rails'

import 'trix'
import '@rails/actiontext'
import './controllers'
import './channels'
import './vendor/'

// Make accessible for Electron and Mobile adapters
window.Turbo = Turbo
