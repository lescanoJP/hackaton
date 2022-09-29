$(document).ready(function(){
  var $password = $("#password");
  var $passwordConfirmation = $("#passwordConfirmation");
  var $invalidPasswordMessage = $("#invalidPasswordMessage");

  function checkPassword() {
    if ($password.val().length >= 6 || $passwordConfirmation.val().length >= 6) {
      if ($password.val() == $passwordConfirmation.val()){
        $invalidPasswordMessage.hide();
      } else {
        $invalidPasswordMessage.show();
      }
    }
  }

  $password.keyup(checkPassword);
  $passwordConfirmation.keyup(checkPassword);

});
