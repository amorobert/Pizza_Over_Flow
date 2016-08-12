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
	$('.new_question_comment_button').on('click', function(event){
		event.preventDefault();
		$(this).addClass('hidden');
		$('.question-comment').removeClass('hidden');

	});
	$('.question-comment').on('submit', function(event){
		event.preventDefault();
		var submission = $(this).serialize();
		
		$.ajax({
			url: $(this).attr("action"),
			method: $(this).attr("method"),
			data: submission

		})
		.done(function(data){
			$

		})
		.fail(function(data){
			alert("missing content")

		});

	});

});