document.addEventListener('turbolinks:load', function() {

  $('.form-inline-link').on('click', formInlineLinkHandler)

  var errors = document.querySelector('.resource-errors')
  if (errors) {
    var resourceId = errors.dataset.testId
    formInlineHandler(resourceId)
  }
})

function formInlineLinkHandler(e) {
  e.preventDefault()

  var testId = this.dataset.testId
  formInlineHandler(testId)
}

function formInlineHandler(testId) {
  var link = document.querySelector('.form-inline-link[data-test-id="' + testId + '"]')

  if (link) {
    var $testTitle = $('.test-title[data-test-id="' + testId + '"]')
    var $formInline = $('.form-inline[data-test-id="' + testId + '"]')

    $testTitle.toggle()
    $formInline.toggle()

    if ($formInline.is(':visible')) {
      link.textContent = link.dataset.labelCancel
    } else {
      link.textContent = link.dataset.labelEdit
    }
  }
}