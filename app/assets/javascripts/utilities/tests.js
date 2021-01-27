document.addEventListener('turbolinks:load', function() {
  var timeForTestSeconds = document.querySelector('.time_for_test_seconds')
  var timeForTestMinuts = document.querySelector('.time_for_test_minuts')

  if (timeForTestSeconds && timeForTestMinuts) { 
    setMinutsFromSeconds()
    timeForTestMinuts.addEventListener('input', processorSecondsMinuts)
  }

  function processorSecondsMinuts(e) {
    timeForTestSeconds.value  = parseInt(e.target.value) * 60
  }

  function setMinutsFromSeconds() {
    timeForTestMinuts.value = parseInt(timeForTestSeconds.value) / 60
  }
})