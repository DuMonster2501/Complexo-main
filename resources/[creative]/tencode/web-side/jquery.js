/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function(){
	window.addEventListener("message",function(event){
		switch(event.data.action){
			case "openSystem":
				$("#divCode").fadeIn(100);
			break;

			case "closeSystem":
				$("#divCode").fadeOut(100);
			break;
		};
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://tencode/closeSystem");
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
const clickCode = (data) => {
	$.post("http://tencode/sendCode",JSON.stringify({ code: data }));
};