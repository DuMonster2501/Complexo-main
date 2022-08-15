$('.mainmenu').hide();
window.addEventListener('message',function(event){
    switch(event.data.action){
        case 'showDeath':
            $('.mainmenu').show(700);
        break;

        case 'hideDeath':
            $('.mainmenu').hide(700);
        break;

        case 'updateTimer':
            deathTimer()
        break;
    }


    function deathTimer(){
        $('#timer').text(event.data.deathtimer)
        if (event.data.deathtimer > 0) {
            $('#deadmenu').hide()  
        }else{
            $('#deadmenu').show()  
        }

    }

});