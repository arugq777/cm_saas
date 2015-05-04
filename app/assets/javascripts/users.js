$(document).ready(function(){
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  //set up an event to watch for form submission
  // $('.pro_form').submit(function(event){ 
  //   var $form = $(this);
  //   event.preventDefault();
  //   $('.form-submit-btn').prop('disabled', true);
  //   Stripe.card.createToken({
  //     number: $('#card_number').val(),
  //     cvc: $('#card_code').val(),
  //     exp_month: $('#card_month').val(),
  //     exp_year: $('#card_year').val()
  //   }, stripeResponseHandler);

  //   return false;
  // }); //form submission

  $('#pro_form').submit(function(event){
    var $form = $(this);
    event.preventDefault();
    $('.form-submit-btn').prop('disabled', true);
  },stripeFormSubmit);

  $('#pro_upgrade_form').submit(function(event){
    var $form = $(this);
    event.preventDefault();
    $('.form-submit-btn').prop('disabled', true);
  },stripeFormSubmit);

  function stripeFormSubmit(){
    Stripe.card.createToken({
      number: $('#card_number').val(),
      cvc: $('#card_code').val(),
      exp_month: $('#card_month').val(),
      exp_year: $('#card_year').val()
    }, stripeResponseHandler);
    return false;    
  }

  function stripeResponseHandler(status, response){ 
    //get a reference to the form
    var $f = $('.pro_form');
    //alert(response.id);
    //get the token from the response
    var token = response.id;

    //Add token to the form:
    $f.append("<input type='hidden' name='user[stripe_card_token]' value='" + token + "'/>");

    //Submit form
    $f.get(0).submit();
  }
});