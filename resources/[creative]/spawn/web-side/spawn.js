$(document).ready(() => {
  window.addEventListener("message", function (event) {
		switch (event["data"]["action"]) {
			case "openSystem":
				$("#charPage").css("display", "flex");
				generateSelect();
				break;

			case "closeSystem":
				$("#charPage").css("display", "none");
				break;

			case "openSpawn":
				$("#charSpawn").css("display", "flex");
				break;

			case "closeNew":
				$("#charPage").css("display", "none");
				$("#charRegister").css("display", "none");
				break;

			case "closeSpawn":
				$("#charSpawn").css("display", "none");
				break;
		};
	});

  $('.change').on('click', function () {
    if ($(this).attr('data-group') === 'gender') {
      $('.male, .female').removeClass('active');
      $(this).addClass('active');
    } else {
      $('.north, .south').removeClass('active');
      $(this).addClass('active');
    }
  });

  function generateSelect() {
    $.post("http://spawn/generateDisplay", JSON.stringify({}), (data) => {

      let screenCode = '';
      var characterList = data["result"].sort((a, b) => (a["id"] > b["id"]) ? 1 : -1);

      characterList.forEach((char) => {
        screenCode += `
          <div class="person-area">
            <div class="person-info">
              <div class="primary-data">
                <p>${char['name']}</p>
              </div>
              <div class="secondary-data">
                <div class="info-block">
                  <p>Passaporte</p>
                  <p>#${char['id']}</p>
                </div>
                <div class="info-block">
                  <p>Nacionalidade</p>
                  <p>${char['nationality']}</p>
                </div>
              </div>
              <div class="button-area">
                <div class="selection-button" data-id="${char['id']}">
                  <p>SELECIONAR</p>
                  <div class="go-img">
                    <svg viewBox="0 0 12 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path
                        d="M10.9333 8.2L1.6 1.2C0.940764 0.705573 0 1.17595 0 2V16C0 16.824 0.940764 17.2944 1.6 16.8L10.9333 9.8C11.4667 9.4 11.4667 8.6 10.9333 8.2Z"
                        fill="white" />
                    </svg>
                  </div>
                </div>
              </div>
            </div>
          </div>
        `;
      });

      for (i = characterList.length; i < 3; i++) {
        screenCode += `
          <div class="person-area">
            <div class="create-data">
              <div class="title-info">
                <div class="title-icon">
                  <svg viewBox="0 0 24 27" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M10.4399 13.6783C14.101 13.6781 15.4183 10.0124 15.7631 7.00123C16.1879 3.29181 14.4337 0.5 10.4399 0.5C6.44647 0.5 4.69143 3.2916 5.11657 7.00123C5.46175 10.0124 6.77865 13.6786 10.4399 13.6783Z" fill="white"/>
                    <path d="M18.4452 15.2042C18.563 15.2042 18.68 15.2078 18.7962 15.2142C18.622 14.9657 18.4204 14.7465 18.1844 14.5703C17.4809 14.0452 16.5698 13.8729 15.7643 13.5564C15.3722 13.4024 15.0212 13.2494 14.6916 13.0753C13.5792 14.2952 12.1286 14.9333 10.4393 14.9335C8.75065 14.9335 7.30017 14.2953 6.18791 13.0753C5.85832 13.2495 5.50715 13.4024 5.11515 13.5564C4.3097 13.873 3.39864 14.0452 2.69511 14.5703C1.47847 15.4783 1.16405 17.5212 0.917003 18.9146C0.713124 20.0649 0.576156 21.2388 0.536179 22.4072C0.505209 23.3122 0.952052 23.4391 1.7092 23.7123C2.65722 24.0542 3.63608 24.3081 4.62153 24.5161C6.52468 24.918 8.4864 25.2269 10.4397 25.2407C11.3861 25.2339 12.3345 25.1576 13.2772 25.0353C12.5792 24.0239 12.1698 22.7988 12.1698 21.4797C12.1698 18.0193 14.9849 15.2042 18.4452 15.2042Z" fill="white"/>
                    <path d="M18.4452 16.4594C15.6726 16.4594 13.4248 18.7071 13.4248 21.4797C13.4248 24.2523 15.6725 26.5 18.4452 26.5C21.2178 26.5 23.4655 24.2523 23.4655 21.4797C23.4655 18.7071 21.2177 16.4594 18.4452 16.4594ZM20.6416 22.341H19.3065V23.676C19.3065 24.1517 18.9209 24.5374 18.4452 24.5374C17.9695 24.5374 17.5838 24.1517 17.5838 23.676V22.341H16.2488C15.7731 22.341 15.3874 21.9554 15.3874 21.4796C15.3874 21.0039 15.773 20.6182 16.2488 20.6182H17.5838V19.2832C17.5838 18.8075 17.9695 18.4218 18.4452 18.4218C18.9209 18.4218 19.3065 18.8075 19.3065 19.2832V20.6182H20.6416C21.1173 20.6182 21.503 21.0039 21.503 21.4796C21.5029 21.9554 21.1173 22.341 20.6416 22.341Z" fill="white"/>
                    </svg>
                </div>
                <div class="title-text">
                  <p>NOVO PERSONAGEM</p>
                </div>
              </div>
              <div class="mid-info">
                <p>Você consegue criar um novo personagem clicando no botão abaixo.</p>
              </div>
              <div class="button-area">
                <div class="create-button">
                  <p>NOVO PERSONAGEM</p>
                  <div class="go-img">
                    <svg viewBox="0 0 12 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path
                        d="M10.9333 8.2L1.6 1.2C0.940764 0.705573 0 1.17595 0 2V16C0 16.824 0.940764 17.2944 1.6 16.8L10.9333 9.8C11.4667 9.4 11.4667 8.6 10.9333 8.2Z"
                        fill="white" />
                    </svg>
                  </div>
                </div>
              </div>
            </div>
          </div>
        `;
      }

      $('.selection-grid-box').html(screenCode);
    });
  }
});

$(document).on("click",".selection-button",function(e){
	$.post("http://spawn/characterChosen",JSON.stringify({ id: parseInt(e["currentTarget"]["dataset"]["id"]) }));
	$("#charPage").css("display","none");
});

$(document).on("click",".create-button",function(e){
	$("#charPage").fadeOut("100").css("display","none");
	$("#charRegister").fadeIn("100").css("display","flex");
});

$(document).on("click",".return-button",function(e){
	$("#charPage").fadeIn("100").css("display","flex");
	$("#charRegister").fadeOut("100").css("display","none");
});

$(document).on("click", ".spawn-button", function (e) {
  let hashCode = parseInt(e["currentTarget"]["dataset"]["hash"]);
  
  if (hashCode === 4) {
    hashCode = "spawn";
  }

	$.post("http://spawn/spawnChosen", JSON.stringify({
		hash: hashCode
	}));
});

$(document).on("click",".submit-button",function(e){
	var nome = $("#name").val();
	var sobrenome = $("#lastname").val();
	var sexo = $(".change.male.active, .change.female.active").attr("data-value");
	var nationality = $(".change.north.active, .change.south.active").attr("data-value");

	if (nome != "" && sobrenome != ""){

		if (sexo == "M"){ sexo = "Masculino" } else { sexo = "Feminino" }
		if (nationality == "S"){ nationality = "Sul" } else { nationality = "Norte" }
		$.post("http://spawn/newCharacter",JSON.stringify({ name: nome, name2: sobrenome, sex: sexo, nationality: nationality }));
	}
});