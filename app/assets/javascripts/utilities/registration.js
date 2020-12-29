var passwordField, 
    passwordConfirmationField,
    groupPasswordConfirmation

document.addEventListener('turbolinks:load', function() {
  groupPasswordConfirmation = document.querySelector('.group-password-confirmation')

  passwordField = document.querySelector('.password')
  passwordConfirmationField = document.querySelector('.password-confirmation')

  if (passwordField && passwordConfirmationField) {
    passwordField.addEventListener('input', comparePasswords)
    passwordConfirmationField.addEventListener('input', comparePasswords)
  }
})

function comparePasswords(e) {
  if (e.target.classList.contains('password-confirmation')) {
    var pwd = passwordField.value,
        pwdCmf = e.target.value
  } else {
    var pwd = e.target.value,
        pwdCmf = passwordConfirmationField.value
  }

  if (pwdCmf != '' && pwd != pwdCmf) {
    groupPasswordConfirmation.querySelector('.password-fail').classList.remove('hide')
    groupPasswordConfirmation.querySelector('.password-success').classList.add('hide')
  } else if (pwdCmf != '') {
    groupPasswordConfirmation.querySelector('.password-success').classList.remove('hide')
    groupPasswordConfirmation.querySelector('.password-fail').classList.add('hide')
  } else if (pwdCmf == '') {
    groupPasswordConfirmation.querySelector('.password-success').classList.add('hide')
    groupPasswordConfirmation.querySelector('.password-fail').classList.add('hide')
  } 
}