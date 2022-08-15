$(document).ready(function(){
	window.addEventListener("message",function(event){
		switch(event["data"]["action"]){
			case "show":
				$("#body").css("display","flex");
				requestBank();
			break;

			case "hide":
				$("#body").css("display","none");
			
			break;
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://atm/close");
		}
	};
});

const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}

/* ----------REQUESTBANK---------- */
const requestBank = () => {
	$.post("http://atm/saldodoBanco",JSON.stringify({}),function(data){
		$("#money").html(`Saldo: <b>$${formatarNumero(data.valorfinal)} </b> dólares`);
	});
}

/* ----------DEPOSIT---------- */
$(document).on("click","#deposit",function(){
	let value = parseInt($('#value').val());
	if(value > 0){
		$.post("http://atm/deposit",JSON.stringify({ value }));
		$("#transferId").val('');
		$("#value").val("");
	}
});
/* ----------WITHDRAW---------- */
$(document).on("click","#withdraw",function(){
	let value = parseInt($('#value').val());
	if(value > 0){
		$.post("http://atm/withdraw",JSON.stringify({ value }));
		$("#transferId").val('');
		$("#value").val("");
	}
});
/* ----------TRANSFER---------- */
$(document).on("click","#transfer",function(){
	$.post('http://atm/HandleTransfer', JSON.stringify({
		target: $("#transferId").val(),
		amount: $("#value").val()
	}));
	$.post("http://atm/close");
	$("#transferId").val('');
	$("#value").val('');
});