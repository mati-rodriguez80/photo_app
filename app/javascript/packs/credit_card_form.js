console.log('credit_card_form.js file is loaded!');

$(document).on('ready turbolinks:load', function() {

  var show_error, stripeResponseHandler, submitHandler;

  submitHandler = function (event) {
    console.log("submitHandler function has been executed!");
    console.log(event);
    console.log(event.target);
    var $form = $(event.target);
    $form.find("input[type=submit]").prop("disabled", true);
    //If Stripe was initialized correctly this will create a token using the credit card info
    if (Stripe){
      Stripe.card.createToken($form, stripeResponseHandler);
    } else {
      show_error("Failed to load credit card processing functionality. Please reload this page in your browser.");
    }
    return false;
  };

  $(".cc_form").on('submit', submitHandler);

  stripeResponseHandler = function (status, response) {
    console.log("stripeResponseHandler function has been executed!");
    console.log(response);
    var token, $form;
    $form = $('.cc_form');
    if (response.error) {
      show_error(response.error.message);
      $form.find("input[type=submit]").prop("disabled", false);
      $("div#collapseWidthExample").removeClass("show");
    } else {
      token = response.id;
      $form.append($("<input type=\"hidden\" name=\"payment[token]\" />").val(token));
      $("[data-stripe=number]").remove();
      $("[data-stripe=cvc]").remove();
      $("[data-stripe=exp-year]").remove();
      $("[data-stripe=exp-month]").remove();
      $("[data-stripe=label]").remove();
      $form.get(0).submit();
    }
    return false;
  };

  show_error = function (message) {
    console.log("show_error function has been executed!");
    console.log(message);
    if ($("#flash-messages").length < 1) { // “.size() has been removed in JQuery 3.0. Use .length() instead”
      $('div#page-content.container.mt-4').prepend("<div id='flash-messages'></div>")
    }
    $("#flash-messages").html(
      '<div class="alert alert-danger alert-dismissible fade show" role="alert">' 
      + message 
      + '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' 
      + '<span aria-hidden="true">&times;</span>' 
      + '</button>' 
      + '</div>'
    );
    $('.alert').delay(5000);
    return false;
  };
});
