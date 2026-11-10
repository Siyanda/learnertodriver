import { Controller as BaseController } from "@hotwired/stimulus"

const SCRIPT_URL = 'https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit'

let turnstileLoader

export function loadTurnstile() {
  turnstileLoader ||= new Promise((resolve, reject) => {
    const script = document.createElement('script')

    script.src     = SCRIPT_URL
    script.async   = true
    script.onload  = () => resolve(window.turnstile)
    script.onerror = () => {
      turnstileLoader = null
      reject(new Error('Turnstile failed to load'))
    }

    document.head.appendChild(script)
  })

  return turnstileLoader
}

export default class extends BaseController {
  static values = { siteKey: String }

  async connect() {
    const turnstile = await loadTurnstile()
    if (!this.element.isConnected) return

    this.widgetId = turnstile.render(this.element, { sitekey: this.siteKeyValue })
  }

  disconnect() {
    if (this.widgetId !== undefined) window.turnstile.remove(this.widgetId)
    this.widgetId = undefined
  }
}
