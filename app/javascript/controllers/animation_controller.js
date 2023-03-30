import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="animation"
export default class extends Controller {
  static targets = [
    "fadeInTop",
    "fadeInLeft",
    "fadeInRight",
    "fadeInBottom",
  ]

  static values = {
    threshold: Number
  }

  connect() {
    this.applyDefaultClasses()
    this.attachObserver()
  }

  /**
   * Converts the camelCased target name to the
   * respective kebab cased name.
   * fadeInRight -> fade-in-right
   */
  toClassName(name) {
    return name.replace(/[A-Z]+(?![a-z])|[A-Z]/g, ($, ofs) => (ofs ? "-" : "") + $.toLowerCase())
  }

  /**
   * Attaches the observer to this.element
   * root is to the viewport and the threshold value is
   * retrieved from the data-value set on the element.
   */
  attachObserver() {
    this.observer = new IntersectionObserver(this.attachClasses.bind(this), {
      threshold: this.thresholdValue,
      root: null
    })

    this.observer.observe(this.element)
  }

  /**
   * Callback method to the intersection observer
   * if entry is intersecting, goes through all the
   * targets and removes the added opacity-0 class
   * and adds the respective named class to the element
   */
  attachClasses([entry]) {
    // check if parent element is intersecting
    if(entry.isIntersecting) {
      // loop through all our targets
      this.constructor.targets.forEach(target => {
        // find all the targets for that target
        this[`${target}Targets`].forEach(element => {
          // apply the class to the element
          element.classList.remove("opacity-0")
          element.classList.add(this.toClassName(target))
        })
      })
    }
  }

  /**
   * Apply bootstrap opacity-0 to all targets
   * to give them an initial hidden state
   */
  applyDefaultClasses() {
    this.constructor.targets.forEach(target => {
      this[`${target}Targets`].forEach(element => {
        element.classList.add("opacity-0")
      })
    })
  }
}
