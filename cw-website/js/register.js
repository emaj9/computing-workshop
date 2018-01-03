'use strict';

$(function() {
  var register = $("#register");

  console.log("Registration loaded!");

  function registerSuccess() {
    $('#how-to-register').replaceWith('<dd> Thanks for registering! ' +
                                      'You should receive shortly a ' +
                                      'confirmation email. </dd>');
  }

  function registerFailed() {
    formError = $('p.form-error');
    formError.removeClass('form-error-invisible');
    formError.text("There was a problem submitting your registration.");
  }

  function onRegisterRes(data, status, xhr) {
    if(data.registerStatus === "ok") {
      registerSuccess();
    }
    else {
      registerFailed();
    }
  }

  function onSubmitRegister(event) {
    console.log("Got submit! Serializing form...");

    var form = {};
    register.find('.field').each(function(i, e) {
      var e = $(e); // jquery it up in here
      var name = e.attr('name');
      console.log('Serialized ' + name);
      form[name] = e.val();
    });
    // var form = register.serialize();

    $.ajax({
      data: JSON.stringify(form),
      url: "/api/register",
      success: onRegisterRes,
      contentType: 'application/json',
      dataType: 'json',
      type: 'POST',
    });

    event.preventDefault();
  }

  register.children('input[type="submit"]').click(onSubmitRegister);
  // $('#submit-button').click(onSubmitRegister);
  console.log("Registered submit handler on button.");
});
