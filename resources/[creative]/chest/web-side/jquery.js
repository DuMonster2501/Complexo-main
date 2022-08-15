let shiftPressed = false;
  
$(() => {
	$(".inventory").hide();

	window.addEventListener("message",function(event){
		switch(event.data.action){
			case "showMenu":
				updateChest();
				$(".inventory").css("display","flex");
			break;

			case "hideMenu":
				$(".inventory").css("display","none");
				$(".ui-tooltip").hide();
			break;

			case "updateChest":
				updateChest();
			break;
		}
	});

	document.onkeydown = data => {
		const key = data.key;
		if (key === "Shift") {
			shiftPressed = true;
		}
	}

	document.onkeyup = data => {
		const key = data.key;
		if (key === "Escape"){
			$.post("http://chest/chestClose",JSON.stringify({}));
		} else if (key === "Shift") {
			shiftPressed = false;
		}
	}
});

const updateDrag = () => {
	$('.populated').draggable({
		helper: 'clone'
	});

	$('.empty').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			if(ui.draggable.parent()[0] == undefined) return;

			const shiftPressed = event.shiftKey;
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;
			
			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
			const target = $(this).data('slot');

			if (itemData.key === undefined || target === undefined) return;

			let amount = 0;
			let itemAmount = parseInt(ui.draggable.data('amount'));

			if (shiftPressed)
				amount = itemAmount;
			else if($(".amount").val() == "" | parseInt($(".amount").val()) <= 0)
				amount = 1;
			else
				amount = parseInt($(".amount").val());

			if(amount > itemAmount)
				amount = itemAmount;

			$('.populated, .empty').off("draggable droppable");

			let clone1 = ui.draggable.clone();
			let slot2 = $(this).data("slot"); 

			if(amount == itemAmount){
				let clone2 = $(this).clone();
				let slot1 = ui.draggable.data("slot");

				$(this).replaceWith(clone1);
				ui.draggable.replaceWith(clone2);
				
				$(clone1).data("slot", slot2);
				$(clone2).data("slot", slot1);
			} else {
				let newAmountOldItem = itemAmount - amount;
				let weight = parseFloat(ui.draggable.data("peso"));
				let newWeightClone1 = (amount*weight).toFixed(2);
				let newWeightOldItem = (newAmountOldItem*weight).toFixed(2);

				ui.draggable.data("amount",newAmountOldItem);

				clone1.data("amount",amount);

				$(this).replaceWith(clone1);
				$(clone1).data("slot",slot2);

				ui.draggable.children(".top").children(".itemAmount").html(formatarNumero(ui.draggable.data("amount")) + "x");
				ui.draggable.children(".top").children(".itemWeight").html(newWeightOldItem);
				
				$(clone1).children(".top").children(".itemAmount").html(formatarNumero(clone1.data("amount")) + "x");
				$(clone1).children(".top").children(".itemWeight").html(newWeightClone1);
			}

			updateDrag();

			if (tInv === "invLeft") {
				if (origin === "invLeft") {
					$.post("http://chest/populateSlot",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt(amount)
					}))

					$('.amount').val("");
				} else if (origin === "invRight") {
					$.post("http://chest/takeItem",JSON.stringify({
						item: itemData.key,
						slot: target,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				}
			} else if ( tInv === "invRight" ) {
				if ( origin === "invLeft" ) {
					$.post("http://chest/storeItem",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				}
			}
		}
	});

	$('.populated').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			if(ui.draggable.parent()[0] == undefined) return;

			const shiftPressed = event.shiftKey;
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;

			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
			const target = $(this).data('slot');

			if (itemData.key === undefined || target === undefined) return;

			let amount = 0;
			let itemAmount = parseInt(ui.draggable.data('amount'));

			if (shiftPressed)
				amount = itemAmount;
			else if($(".amount").val() == "" | parseInt($(".amount").val()) <= 0)
				amount = 1;
			else
				amount = parseInt($(".amount").val());

			if(amount > itemAmount)
				amount = itemAmount;

			$('.populated, .empty, .use').off("draggable droppable");

			if(ui.draggable.data('item-key') == $(this).data('item-key')){
				let newSlotAmount = amount + parseInt($(this).data('amount'));
				let newSlotWeight = ui.draggable.data("peso") * newSlotAmount;

				$(this).data('amount',newSlotAmount);
				$(this).children(".top").children(".itemAmount").html(formatarNumero(newSlotAmount) + "x");
				$(this).children(".top").children(".itemWeight").html(newSlotWeight.toFixed(2));

				if(amount == itemAmount) {
					ui.draggable.replaceWith(`<div class="item empty" data-slot="${ui.draggable.data('slot')}"></div>`);
				} else {
					let newMovedAmount = itemAmount - amount;
					let newMovedWeight = parseFloat(ui.draggable.data("peso")) * newMovedAmount;

					ui.draggable.data('amount',newMovedAmount);
					ui.draggable.children(".top").children(".itemAmount").html(formatarNumero(newMovedAmount) + "x");
					ui.draggable.children(".top").children(".itemWeight").html(newMovedWeight.toFixed(2));
				}
			} else {
				if (origin === "invRight" && tInv === "invLeft") return;

				let clone1 = ui.draggable.clone();
				let clone2 = $(this).clone();

				let slot1 = ui.draggable.data("slot");
				let slot2 = $(this).data("slot");

				ui.draggable.replaceWith(clone2);
				$(this).replaceWith(clone1);

				$(clone1).data("slot",slot2);
				$(clone2).data("slot",slot1);
			}

			updateDrag();


			if ( tInv === "invLeft" ) {
				if (origin === "invLeft"){
					$.post("http://chest/updateSlot",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						target: target,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				} else if (origin === "invRight"){
					$.post("http://chest/sumSlot",JSON.stringify({
						item: itemData.key,
						slot: target,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				}
			} else if ( tInv === "invRight" ) {
				if ( origin === "invLeft" ) {
					$.post("http://chest/storeItem",JSON.stringify({
						item: itemData.key,
						slot: itemData.slot,
						amount: parseInt(amount)
					}));

					$('.amount').val("");
				}
			}
		}
	});
	
	$(".populated").tooltip({
		create: function(event,ui){
			var serial = $(this).attr("data-serial");
			var economy = $(this).attr("data-economy");
			var desc = $(this).attr("data-desc");
			var amounts = $(this).attr("data-amount");
			var name = $(this).attr("data-name-key");
			var weight = $(this).attr("data-peso");
			var tipo = $(this).attr("data-tipo");
			var unity = $(this).attr("data-unity");
			var myLeg = "center top-196";

			if (desc !== "undefined"){
				myLeg = "center top-219";
			}

			$(this).tooltip({
				content: `<item>${name}</item>${desc !== "undefined" ? "<br><description>"+desc+"</description>":""}<br><legenda>${serial !== "undefined" ? "Serial: <r>"+serial+"</r>":"Tipo: <r>"+tipo+"</r>"} <s>|</s> Unitário: <r>${unity !== "undefined" ? unity:"S/L"}</r><br>Peso: <r>${(weight * amounts).toFixed(2)}</r> <s>|</s> Economia: <r>${economy !== "S/V" ? "$"+formatarNumero(economy):economy}</r></legenda>`,
				position: { my: myLeg, at: "center" },
				show: { duration: 10 },
				hide: { duration: 10 }
			})
		}
	});
	
}

const colorPicker = (percent) => {
	var colorPercent = "#2e6e4c";

	if (percent >= 100)
		colorPercent = "rgba(255,255,255,0)";

	if (percent >= 51 && percent <= 75)
		colorPercent = "#fcc458";

	if (percent >= 26 && percent <= 50)
		colorPercent = "#fc8a58";

	if (percent <= 25)
		colorPercent = "#fc5858";

	return colorPercent;
}

const updateChest = () => {
	$.post("http://chest/requestChest",JSON.stringify({}),(data) => {
		$("#weightTextLeft").html(`${(data["peso"]).toFixed(2)}   /   ${(data["maxpeso"]).toFixed(2)}`);
		$("#weightTextRight").html(`${(data["peso2"]).toFixed(2)}   /   ${(data["maxpeso2"]).toFixed(2)}`);

		$("#weightBarLeft").html(`<div id="weightContent" style="width: ${data["peso"] / data["maxpeso"] * 100}%"></div>`);
		$("#weightBarRight").html(`<div id="weightContent" style="width: ${data["peso2"] / data["maxpeso2"] * 100}%"></div>`);

		const nameList2 = data.inventario2.sort((a,b) => (a.name > b.name) ? 1: -1);

		$(".invLeft").html("");
		$(".invRight").html("");

		for (let x = 1; x <= 100; x++){
			const slot = x.toString();

			if (data.inventario[slot] !== undefined) {
				const v = data.inventario[slot];
				let actualPercent
				if (v["days"]) {
					const maxDurability = 86400 * v["days"];
					const newDurability = (maxDurability - v["durability"]) / maxDurability;
					actualPercent = newDurability * 100;
				} else {
					actualPercent = v["durability"] * 100;
					if (actualPercent < 5.0) {
						actualPercent = 5.0
					}
				}
				// if (v["desc"] == undefined) { v["desc"] = ""}
				const item = `<div class="item populated" title="" data-unity="${v["unity"]}" data-tipo="${v["tipo"]}" data-desc="${v["desc"] !== "undefined" ? "<br><description>"+v["desc"]+"</description>":""}"  data-economy="${v["economy"]}" data-max="${v["max"]}" data-type="${v["type"]}" data-serial="${v["serial"]}" style="background-image: url('nui://inventory/web-side/images/${v.index}.png'); background-position: center; background-repeat: no-repeat;" data-amount="${v.amount}" data-peso="${v.peso}" data-item-key="${v.key}" data-name-key="${v.name}" data-slot="${slot}"">
					<div class="top">
						<div class="itemWeight">${(v.peso*v.amount).toFixed(2)}</div>
						<div class="itemAmount">${formatarNumero(v.amount)}x</div>
					</div>

					<div class="durability" style="width: ${parseInt(actualPercent)}%; background: ${colorPicker(actualPercent)};"></div>
					<div class="nameItem">${v.name}</div>
				</div>`;

				$(".invLeft").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invLeft").append(item);
			}
		}

		for (let x = 1; x <= 100; x++){
			const slot = x.toString();

			if (nameList2[x-1] !== undefined) {
				const v = nameList2[x-1];
				let actualPercent
				if (v["days"]) {
					const maxDurability = 86400 * v["days"];
					const newDurability = (maxDurability - v["durability"]) / maxDurability;
					actualPercent = newDurability * 100;
				} else {
					actualPercent = v["durability"] * 100;
				}
				const item = `<div class="item populated" title="" data-tipo="${v["tipo"]}" data-desc="${v["desc"] !== "undefined" ? "<br><description>"+v["desc"]+"</description>":""}" data-economy="${v["economy"]}" data-unity="${v["unity"]}" data-max="${v["max"]}" data-type="${v["type"]}" data-serial="${v["serial"]}" style="background-image: url('nui://inventory/web-side/images/${v.index}.png'); background-position: center; background-repeat: no-repeat;" data-amount="${v.amount}" data-peso="${v.peso}" data-item-key="${v.key}" data-name-key="${v.name}" data-slot="${slot}"">
					<div class="top">
						<div class="itemWeight">${(v.peso*v.amount).toFixed(2)}</div>
						<div class="itemAmount">${formatarNumero(v.amount)}x</div>
					</div>

					<div class="durability" style="width: ${parseInt(actualPercent)}%; background: ${colorPicker(actualPercent)};"></div>
					<div class="nameItem">${v.name}</div>
				</div>`;

				$(".invRight").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invRight").append(item);
			}
		}
		updateDrag();
	});
}
/* ----------FORMATARNUMERO---------- */
const formatarNumero = (n) => {
	if (n == undefined) {n = "RODRIGO GATAO"}
	console.log(n)
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--){
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}

function somenteNumeros(e){
	var charCode = e.charCode ? e.charCode : e.keyCode;
	if (charCode != 8 && charCode != 9){
		var max = 9;
		var num = $(".amount").val();

		if ((charCode < 48 || charCode > 57)||(num.length >= max)){
			return false;
		}
	}
}

$(document).ready(function() {
    var ctrlDown = false,
        ctrlKey = 17,
        cmdKey = 91,
        vKey = 86,
        cKey = 67;

    $(document).keydown(function(e) {
        if (e.keyCode == ctrlKey || e.keyCode == cmdKey) ctrlDown = true;
    }).keyup(function(e) {
        if (e.keyCode == ctrlKey || e.keyCode == cmdKey) ctrlDown = false;
    });

    $(".amount").keydown(function(e) {
        if (ctrlDown && (e.keyCode == vKey || e.keyCode == cKey)) return false;
    });
    
    $(document).keydown(function(e) {
        if (ctrlDown && (e.keyCode == cKey)) console.log("Document catch Ctrl+C");
        if (ctrlDown && (e.keyCode == vKey)) console.log("Document catch Ctrl+V");
    });
});