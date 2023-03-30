import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="countdown"
export default class extends Controller {
  static targets = [
    "countdown",
    "days1",
    "days2",
    "hours1",
    "hours2",
    "minutes1",
    "minutes2",
    "seconds1",
    "seconds2"
  ]

  connect() {
    console.log("Connected to countdown stimulus!");
    this.secondsUntilEnd = this.countdownTarget.dataset.secondsUntilEnd;

    const now = new Date().getTime();
    this.endTime = new Date(now + this.secondsUntilEnd * 1000);

    this.countdown = setInterval(this.countdown.bind(this), 250);
  }

  countdown() {
    const now = new Date();
    const secondsRemaining = (this.endTime - now) / 1000;

    if (secondsRemaining <= 0) {
      clearInterval(this.countdown);
      this.countdownTarget.innerHTML = "Countdown is up!";
      return;
    }

    const secondsPerDay = 86400;
    const secondsPerHour = 3600;
    const secondsPerMinute = 60;

    const days = Math.floor(secondsRemaining / secondsPerDay);
    const hours = Math.floor((secondsRemaining % secondsPerDay) / secondsPerHour);
    const minutes = Math.floor((secondsRemaining % secondsPerHour) / secondsPerMinute);
    const seconds = Math.floor(secondsRemaining % secondsPerMinute);

    // Days first number
    this.days1Targets.forEach((target) => {
      if (days < 10) {
        target.innerHTML = 0
      } else
      target.innerHTML = `${(days - (days % 10)) / 10}`
    })

    // Days second number
    this.days2Targets.forEach((target) => {
      if (days < 10) {
        target.innerHTML = `${days}`
      } else
      target.innerHTML = `${days % 10}`
    })

    // Hours first number
    this.hours1Targets.forEach((target) => {
      if (hours < 10) {
        target.innerHTML = 0
      } else
      target.innerHTML = `${(hours - (hours % 10)) / 10}`
    })

    // Hours second number
    this.hours2Targets.forEach((target) => {
      if (hours < 10) {
        target.innerHTML = `${hours}`
      } else
      target.innerHTML = `${hours % 10}`
    })

    // Minutes first number
    this.minutes1Targets.forEach((target) => {
      if (minutes < 10) {
        target.innerHTML = 0
      } else
      target.innerHTML = `${(minutes - (minutes % 10)) / 10}`
    })

    // Minutes second number
    this.minutes2Targets.forEach((target) => {
      if (minutes < 10) {
        target.innerHTML = `${minutes}`
      } else
      target.innerHTML = `${minutes % 10}`
    })

    // Seconds first number
    this.seconds1Targets.forEach((target) => {
      if (seconds < 10) {
        target.innerHTML = 0
      } else
      target.innerHTML = `${(seconds - (seconds % 10)) / 10}`
    })

    // Seconds second number
    this.seconds2Targets.forEach((target) => {
      if (seconds < 10) {
        target.innerHTML = `${seconds}`
      } else
      target.innerHTML = `${seconds % 10}`
    })
  }
}
