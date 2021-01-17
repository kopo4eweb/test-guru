document.addEventListener('turbolinks:load', function() {
  var progressTestPassage = document.querySelector('.progress-test-passage')
  
  if (progressTestPassage) {
    var passedQuestions = parseInt(document.querySelector('.passed-questions').dataset.passedQuestions)
    var totalQuestions = parseInt(document.querySelector('.total-questions').dataset.totalQuestions)

    var part = 100 / totalQuestions
    var progressPassed = part * (passedQuestions - 1)

    progressTestPassage.style.width = progressPassed + '%'
  }

})