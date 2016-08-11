$(document).ready(function() {
	$('.answer-post').on('submit', function(event){
		event.preventDefault();
		var serai = $(this).serialize();
		

		$.ajax({
			url: $(this).attr("action"),
			method: $(this).attr("method"),
			data: serai
		})
		.done(function(data){
			
			$('.answers').last().append(data);
			$(".answer-post").find("[name='content']").val("");

		})
		.fail(function(data){
			
			alert("Missing content");

		});
	});
});