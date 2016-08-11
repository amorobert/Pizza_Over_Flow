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
});