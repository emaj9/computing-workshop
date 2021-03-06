'use strict';

$(function() {
    var register = $("#register");
    var submitButton = register.children('input[type="submit"]');

    console.log("Registration loaded!");

    function registerSuccess() {
        $('#how-to-register').replaceWith(
            '<dd>' +
                'Your registration has been accepted! ' +
                'You should hear back from us soon.' +
                '</dd>'
        );
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
        submitButton.prop("disabled", true);
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
            error: registerFailed,
            contentType: 'application/json',
            dataType: 'json',
            type: 'POST',
        });

        event.preventDefault();
    }

    submitButton.click(onSubmitRegister);
    // $('#submit-button').click(onSubmitRegister);
    console.log("Registered submit handler on button.");
});
