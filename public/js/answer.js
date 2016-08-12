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
			
			$('.comments').closest('ul').append(data);
			$('.question-comment').addClass('hidden');
			$('.new_question_comment_button').removeClass('hidden');

		})
		.fail(function(data){
			alert("missing content");

		});

	});

	$('.new_answer_comment_button').on('click', function(event){
		event.preventDefault();
		$(this).addClass('hidden');
		$(this).next('.answer-comment').removeClass('hidden');

	});
	$('.answer-comment').on('submit', function(event){
		event.preventDefault();
		var answer = $(this).serialize();
		
		$.ajax({
			url: $(this).attr("action"),
			method: $(this).attr("method"),
			data: answer

		})
		.done(function(data){
			
			$('.answer-comments').closest('ul').append(data);
			$('.answer-comment').addClass('hidden');
			$('.new_answer_comment_button').removeClass('hidden');

		})
		.fail(function(data){
			alert("missing content");

		});

	});

});