var tickInterval = undefined;
var lastHealth = 999;
var lastArmour = 999;
var lastOxigen = 999;

$(document).ready(() => {
  window.addEventListener("message", function (event) {
    if (event["data"]["progress"] == true) {
      loadTicker(event["data"]["progressTimer"]);
      return;
    }

    if (lastHealth !== event["data"]["health"]) {
      lastHealth = event["data"]["health"];

      if (event["data"]["health"] <= 1) {
        setHealth(0);
      } else {
        setHealth(event["data"]["health"]);
      }
    }

    if (lastArmour !== event["data"]["armour"]) {
      lastArmour = event["data"]["armour"];

      if (event["data"]["armour"] <= 1) {
        $(".armour").css("display", "none");
        setArmour(0);
      } else {
        $(".armour").css("display", "flex");
        setArmour(event["data"]["armour"]);
      }
    }

    if (event["data"]["suit"] == undefined){
			if($(".game-user-info").css("display") === "flex"){
				$(".game-user-info").css("display","none");
			}
		} else {
			if($(".game-user-info").css("display") === "none"){
				$(".game-user-info").css("display","flex");
			}
		}

		if (lastOxigen !== event["data"]["oxigen"]){
			lastOxigen = event["data"]["oxigen"];

			setOxigen(event["data"]["oxigen"]);
		}

    if (event["data"]["talking"] == true) {
      $("#microphone").addClass("active");
    } else {
      $("#microphone").removeClass("active");

      if (event["data"]["voice"] || event["data"]["voice"] == 0) {
        formatVoice(event["data"]["voice"]);
      }
    }

    if (event["data"]["direction"] || event["data"]["street"]) {
      if (event["data"]["direction"] != "" || event["data"]["street"] != "") {
        formatLocale(
          event["data"]["direction"]
            ? `${event["data"]["direction"]} | ${event["data"]["street"]}`
            : `${event["data"]["street"]}`
        );
      }
    }

    formatRadio(event["data"]["radio"]);

    if (event["data"]["vehicle"] && event["data"]["vehicle"] == true) {
      $(".user-info").addClass("vehicle");
      setFuel(parseInt(event["data"]["fuel"]));
      setSpeed(parseInt(event["data"]["speed"]) || 0);

      if (event["data"]["showbelt"] == false){
        if($(".functions").css("display") === "flex"){
          $(".functions").css("display","none");
        }
      } else {
        if($("functions").css("display") === "none"){
          $(".functions").css("display","flex");
        }

        changeBelt(event["data"]["seatbelt"]);
      }
    } else {
      if ($(".user-info").hasClass("vehicle")) {
        $(".user-info").removeClass("vehicle");
      }
    }

    if (event["data"]["screen"] !== undefined){
      if (event["data"]["screen"] == true){
        $("#saltyScreen").fadeIn(100);
      } else {
        $("#saltyScreen").fadeOut(100);
      }
    }

    if (event["data"]["hud"] !== undefined) {
      if (event["data"]["hud"] == true) {
        $("#displayHud").fadeIn(600).css("display", "flex");
      } else {
        $("#displayHud").fadeOut(600)
      }
      return;
    }

    if (event["data"]["movie"] !== undefined) {
      if (event["data"]["movie"] == true) {
        $("#movieTop").fadeIn(500);
        $("#movieBottom").fadeIn(500);
      } else {
        $("#movieTop").fadeOut(500);
        $("#movieBottom").fadeOut(500);
      }
      return;
    }

    if (event["data"]["hood"] !== undefined) {
      if (event["data"]["hood"] == true) {
        $("#hoodDisplay").fadeIn(500);
      } else {
        $("#hoodDisplay").fadeOut(500);
      }
    }
  });

  function loadTicker(time) {
    clearInterval(tickInterval);
    $(".ticker").css("display", "flex");
    $(".bar").css("transition", `all ${time}ms cubic-bezier(0, 0, 0, 0) 0s`);
    setTimeout(() => {$(".bar").css("width", "100%");}, 100);
    tickInterval = setTimeout(() => {
      $(".bar").css("transition", `all 0ms cubic-bezier(0, 0, 0, 0) 0s`);
      $(".bar").css("width", "0%");
      $(".ticker").css("display", "none");
    }, time);
  }

  function formatVoice(voice) {
    $(".voice-volume").removeClass("setup");
    for (i = 0; i <= voice; i++) {
      $(`.voice-volume:nth-child(${i+1})`).addClass("setup");
    }
  }

  function formatLocale(locale) {
    $("#location").css("display", "inherit");
    $("#location").html(`
        <img src="./images/locale.svg" alt="locale-icon">
        <p>${locale}<p>
    `);
  }

  function formatRadio(radio) {
    if (radio && radio !== "") {
      radio = radio.toString().toLowerCase().replace(":", "").replace("mhz", "").trim();
      $("#radio").css("display", "inherit");
      $("#radio").html(`
      <img src="images/radio.svg" alt="locale-icon">
      <p>${radio} MHz<p>
      `);
    } else {
      $("#radio").css("display", "none");
    }
  }

  function changeBelt(validation) {
    if (validation) {
      $(".functions>img").attr("src", "images/belt_active.svg");
    } else {
      $(".functions>img").attr("src", "images/belt.svg");
    }
  }

  function setSpeed(value) {
    $("#speed").html(`${value ? value : 0}`);
  }

  function setFuel(value) {
    $(".fuel-bar").css("width", `${value.toFixed(2)}%`);
  }

  function setOxigen(value) {
    $(".oxigen-bar").css("width", `${value}%`);
  }

  function setHealth(value) {
    var index = value / 10;
    var opacityIndex = (index - Number(index.toString().split(".")[0])).toFixed(
      2
    );
    index = (index - opacityIndex).toFixed();

    const healthBars = $(".health>.bars>.item").toArray();

    healthBars.forEach((bar, i) => {
      if (value == 0) {
        $(bar).css("background-color", `rgba(30, 30, 30, 0.8)`);
      } else {
        if (opacityIndex == 0) {
          if (i < index) {
            $(bar).css("background-color", `rgba(255, 28, 28)`);
          } else if (i >= index) {
            $(bar).css("background-color", `rgba(30, 30, 30, 0.8)`);
          }
        } else {
          if (i == index) {
            $(bar).css(
              "background-color",
              `rgba(255, 28, 28, ${opacityIndex})`
            );
          } else if (i <= index) {
            $(bar).css("background-color", `rgba(255, 28, 28)`);
          } else if (i >= index) {
            $(bar).css("background-color", `rgba(30, 30, 30, 0.8)`);
          }
        }
      }
    });
  }

  function setArmour(value) {
    var index = value / 10;
    var opacityIndex = (index - Number(index.toString().split(".")[0])).toFixed(
      2
    );
    index = (index - opacityIndex).toFixed();

    const healthBars = $(".armour>.bars>.item").toArray().reverse();

    healthBars.forEach((bar, i) => {
      if (value == 0) {
        $(bar).css("background-color", `rgba(30, 30, 30, 0.8)`);
      } else {
        if (opacityIndex == 0) {
          if (i < index) {
            $(bar).css("background-color", `rgba(86, 47, 243)`);
          } else if (i >= index) {
            $(bar).css("background-color", `rgba(30, 30, 30, 0.8)`);
          }
        } else {
          if (i == index) {
            $(bar).css(
              "background-color",
              `rgba(86, 47, 243, ${opacityIndex})`
            );
          } else if (i <= index) {
            $(bar).css("background-color", `rgba(86, 47, 243)`);
          } else if (i >= index) {
            $(bar).css("background-color", `rgba(30, 30, 30, 0.8)`);
          }
        }
      }
    });
  }
});
