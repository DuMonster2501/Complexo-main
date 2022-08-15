$(document).ready(function(){
	let actionContainer = $("#actionmenu");
	let actionButton = $("#actionbutton");

	window.addEventListener("message",function(event){
		switch(event.data.action){
			case "showMenu":
				requestBank();
				actionButton.fadeIn(100);
				actionContainer.fadeIn(100);
			break;

			case "hideMenu":
				actionButton.fadeOut(100);
				actionContainer.fadeOut(100);
			break;

			case "requestBank":
				requestBank();
			break;

			case "requestFines":
				requestBank();
				requestFines();
			break;

			case "requestInvoices":
				requestBank();
				requestInvoices();
			break;

			case "requestMyInvoices":
				requestBank();
				requestMyInvoices();
			break;

			case "requestMySalarys":
				requestBank();
				requestMySalarys();
			break;

			case "requestInicio":
				requestBank();
				requestInicio();
			break;
		}
	});

	$("#bank-right").load("./inicio.html");

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://bank/bankClose");
		}
	};
});

$('#actionbutton').click(function(e){
	$.post("http://bank/bankClose");
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

const carregarMenu = (name) => {
	return new Promise((resolve) => {
		$("#bank-right").load(name+".html",function(){
			resolve();
		});
	});
}

const requestBank = () => {
	$.post("http://bank/requestBank",JSON.stringify({}),function(data){
		$("#bank-top").html('Bem-vindo Novamente,<br> Seu saldo disponível <white>$' + formatarNumero(data.resultado) +'</white> dólares');
	});
}

const requestFines = () => {
	$.post("http://bank/requestFines",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.resultado.sort((a,b) => (a.id > b.id) ? 1: -1);
		$('#bank-right').html(`
			<div class="title">MULTAS</div>
			<div class="multas">PAGAR SELECIONADA</div>
			${nameList.map((item) => (`
				<div class="format" data-id-key="${item.id}" data-price-key="${item.price}">
					<div class="format-left">${i = i + 1}</div>
					<div class="format-right"><texto>${item.text}</texto><br><b>Valor:</b> $${formatarNumero(item.price)}   -   <b>Aplicado:</b> ${item.nuser_id}   -   <b>Data:</b> ${item.date}</div>
				</div>
			`)).join('')}
		`);
	});
}

$(document).on("click",".multas",debounce(function(){
	let $el = $('.format.active');
	$.post("http://bank/finesPayment",JSON.stringify({
		id: $el.attr('data-id-key'),
		price: $el.attr('data-price-key')
	}));
}));

const requestInvoices = () => {
	$.post("http://bank/requestInvoices",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.resultado.sort((a,b) => (a.id > b.id) ? 1: -1);
		$('#bank-right').html(`
			<div class="title">FATURAS</div>
			<div class="faturas">PAGAR SELECIONADA</div>
			${nameList.map((item) => (`
				<div class="format" data-id-key="${item.id}" data-price-key="${item.price}" data-nuser_id-key="${item.nuser_id}">
					<div class="format-left">${i = i + 1}</div>
					<div class="format-right"><texto>${item.text}</texto><br><b>Valor:</b> $${formatarNumero(item.price)}   -   <b>Aplicado:</b> ${item.name}   -   <b>Data:</b> ${item.date}</div>
				</div>
			`)).join('')}
		`);
	});
}

$(document).on("click",".faturas",debounce(function(){
	let $el = $('.format.active');
	$.post("http://bank/invoicesPayment",JSON.stringify({
		id: $el.attr('data-id-key'),
		price: $el.attr('data-price-key'),
		nuser_id: $el.attr('data-nuser_id-key')
	}));
}));

$(document).on("click",".format",function(){
	let $el = $(this);
	let isActive = $el.hasClass('active');
	$('.format').removeClass('active');
	if(!isActive) $el.addClass('active');
});

const requestMyInvoices = () => {
	$.post("http://bank/requestMyInvoices",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.resultado.sort((a,b) => (a.id > b.id) ? 1: -1);
		$('#bank-right').html(`
			<div class="title">MINHAS FATURAS</div>
			${nameList.map((item) => (`
				<div class="format" data-id-key="${item.id}">
					<div class="format-left">${i = i + 1}</div>
					<div class="format-right"><texto>${item.text}</texto><br><b>Valor:</b> $${formatarNumero(item.price)}   -   <b>Aplicado:</b> ${item.name}   -   <b>Data:</b> ${item.date}</div>
				</div>
			`)).join('')}
		`);
	});
}


const requestMySalarys = () => {
	$.post("http://bank/requestMySalarys",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.resultado.sort((a,b) => (a.id > b.id) ? 1: -1);
		$('#bank-right').html(`
			<div class="title">SALARIOS</div>
			<div class="salario">RECEBER O SELECIONADO</div>
			${nameList.map((item) => (`
				<div class="format" data-id-key="${item.id}" data-price-key="${item.price}">
					<div class="format-left">${i = i + 1}</div>
					<div class="format-right"><b>Valor:</b> $${formatarNumero(item.price)}   -   <b>Data:</b> ${item.date}</div>
				</div>
			`)).join('')}
		`);
	});
}

$(document).on("click",".salario",debounce(function(){
	let $el = $('.format.active');
	$.post("http://bank/salaryRecipe",JSON.stringify({
		id: $el.attr('data-id-key'),
		price: $el.attr('data-price-key')
	}));
}));

const requestInicio = () => {
	$('#bank-right').html(`
		<div class="menu-depositar">
			<div class="title-sacar"><b>DEPOSITAR</b><br>Faça um depósito rápido na sua conta bancária.</div>
			<input id="deposito" class="deposito" maxlength="9" spellcheck="false" value="" placeholder="VALOR..">
			<div class="depositar">ENVIAR</div>
		</div>
		<div class="menu-space">
		</div>
		<div class="menu-sacar">
			<div class="title-sacar"><b>SACAR</b><br>Retire rapidamente sua conta bancária.</div>
			<input id="saque" class="saque" maxlength="9" spellcheck="false" value="" placeholder="VALOR..">
			<div class="sacar">SACAR</div>
		</div>
		<div class="menu-space">
		</div>
		<div class="menu-transferir">
			<div class="title-transferir"><b>TRANSFERIR</b><br>Transferencia da sua conta bancária.</div>
			<input id="playerID" class="playerID" type="number" min="0" oninput="validity.valid||(value='')" onKeyPress="if(this.value.length==9) return false;" spellcheck="false" value="" placeholder="ID">
			<input id="transfer" class="transfer" type="number" min="0" oninput="validity.valid||(value='')" onKeyPress="if(this.value.length==9) return false;" spellcheck="false" value="" placeholder="VALOR">
			<div class="transferir">TRANSFERIR</div>
		</div>
	`);
}

/* ----------TRANSFER---------- */
$(document).on("click",".transferir",function(){
	$.post('http://bank/bankTransf', JSON.stringify({
		target: $("#playerID").val(),
		amount: $("#transfer").val()
	}));
	$("#playerID").val('');
	$("#transfer").val('');
});

$(document).on("click",".depositar",debounce(function(){
	let deposito = parseInt($('#deposito').val());
	if(deposito > 0){
		$.post("http://bank/bankDeposit",JSON.stringify({ deposito }));
	}
}));

$(document).on("click",".sacar",debounce(function(){
	let saque = parseInt($('#saque').val());
	if(saque > 0){
		$.post("http://bank/bankWithdraw",JSON.stringify({ saque }));
	}
}));
/* ----------DEBOUNCE---------- */
function debounce(func,immediate){
	var timeout
	return function(){
		var context = this,args = arguments
		var later = function(){
			timeout = null
			if (!immediate) func.apply(context,args)
		}
		var callNow = immediate && !timeout
		clearTimeout(timeout)
		timeout = setTimeout(later,250)
		if (callNow) func.apply(context,args)
	}
}