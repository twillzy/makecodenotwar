var app = {};

$(document).ready(function(){

	$.ajax({
		url: '/notifications'
	}).done(function(data){
		app.data = data;
		console.log(app.data);
	});

	setInterval(function(){
		$.ajax({
		url: '/notifications'
	}).done(function(data){
		if (data > app.data) {
			console.log('bigger');
		}
		// app.data = data;
		// console.log(app.data);
	});
	},4000);
})