$(document).ready(function(){

  //when you click the edit button, it shows the edit fields erb

  $(".edit-form").on("submit", function(event){
    event.preventDefault();

    $("#edit-erb-form").show();
  });

  //when you submit the edit button, it updates live and hides the edit fields
  $(".live-edit-form").on("submit", function(event){
    event.preventDefault();

    var url = $(this).attr("action");
    var method = "put";
    var data = $(this).serialize();

    var editRequest = $.ajax({
      url: url,
      method: method,
      data: data
    });

    editRequest.done(function(response){
      $("#edit-erb-form").css("display", "none");
      var json = JSON.parse(response);
      $(".name").text(json.name);
    });
  });

  //when you click the login link the form slides in from navbar
  $("#login-link").on("click", function(event){
    event.preventDefault();

    $("#register-form-container").hide(400);

    var url = $(this).attr("href");

    var request = $.ajax({
      url: url,
      method: "GET"
    });

    request.done(function(response){
      $('#login-form-container').show(400);
    });
  });

  $("#login-form").on("submit", function(event){
    event.preventDefault();

    var $form = $(this);
    var url = $form.attr("action");
    var method = $form.attr("method");
    var data = $form.serialize();

    request = $.ajax({
      url: url,
      method: method,
      data: data
    });

    request.done(function(response){
      $("#login-form-container").html(response);
    });
  });

  $("#register-link").on("click", function(event){
    event.preventDefault();

    $("#register-form-container").hide(400);

    var url = $(this).attr("href");

    var request = $.ajax({
      url: url,
      method: "GET"
    });

    request.done(function(response){
      $('#register-form-container').show(400);
    });
  });
});

$("#register-form").on("submit", function(event){
  event.preventDefault();

  var $form = $(this);
  var url = $form.attr("action");
  var method = $form.attr("method");
  var data = $form.serialize();

  request = $.ajax({
    url: url,
    method: method,
    data: data
  });

  request.done(function(response){
    $("#register-form-container").html(response);
  });
});
