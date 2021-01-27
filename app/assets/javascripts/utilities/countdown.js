document.addEventListener('turbolinks:load', function() {
  var countdown = document.querySelector('.countdown')

  if (countdown) { 
    startCountDown(countdown)
  }
})

function startCountDown(countdown) {
  var countdownTime = countdown.dataset.time
  var awnswerSubmit = document.querySelector('.awnswer_submit')

  var timer = setInterval(function () {

    --countdownTime

    var seconds = countdownTime % 60
    var minuts = countdownTime / 60 % 60
    var hours = countdownTime / 60 / 60 % 60

    if (countdownTime < 0) {
      clearInterval(timer)
      awnswerSubmit.click()
    } else {
      countdown.innerHTML = format_of_countdown(Math.trunc(hours), Math.trunc(minuts), seconds)
    }
  }, 1000)
}

function format_of_countdown(hours, minuts, seconds) {
  var str_hours = hours < 10 ? "0" + hours : hours
  var str_minuts = minuts < 10 ? "0" + minuts : minuts
  var str_seconds = seconds < 10 ? "0" + seconds : seconds

  return str_hours +':'+ str_minuts +':'+ str_seconds
}