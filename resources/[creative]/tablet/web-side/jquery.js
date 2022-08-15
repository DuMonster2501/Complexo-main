var reversePage = "about";
var selectPage = "rules";
var selectPage = "about";
var selectPage = "races";
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function(){

	rulesPage();

	window.addEventListener("message",function(event){
		switch (event.data.action) {
			case "openSystem":
				$("#mainPage").fadeIn(100);
			break;

			case "closeSystem":
				$("#mainPage").fadeOut(100);
			break;

			case "messageMedia":
				updateMedia(event.data.media,event.data.data,event.data.back)
			break;
		};
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://tablet/closeSystem");
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).on("click","#mainMenu li",function(){
	if (selectPage != reversePage){
		let isActive = $(this).hasClass('active');
		$('#mainMenu li').removeClass('active');
		if (!isActive){
			$(this).addClass('active');
			reversePage = selectPage;
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
const commandsPage = () => {
	selectPage = "commands";

	$('#content').html(`
		<div id='titleContent'>PRINCIPAIS</div>
		<div id='pageDiv'>
			<b>vehs</b> - Lista de seus veículos<br>
			<b>bau</b> - Abrir porta-malas do veículo<br>
			<b>hood</b> - Abrir capô do veículo<br>
			<b>doors</b> - Abrir portas do veículo<br>
			<b>toogle</b> - Entra e sair de serviço<br>
			<b>mascara</b> - Retira e coloca uma máscara<br>
			<b>procurado</b> - Verifica o nível de procurado<br>
			<b>outfit</b> - Gerencia as roupas da residência<br>
			<b>repouso</b> - Verifica seu repouso<br>
			<b>seat</b> - Troca de assento nos veículos<br>
			<b>enter</b> - Para entrar ou comprar uma casa
		</div>
		<div id='pageDiv'>
			<b>wins</b> - Abrir e fechar os vidros do veículo<br>
			<b>revistar</b> - Inspecionar os itens da pessoa<br>
			<b>chapeu x y</b> - Para colocar um chapéu<br>
			<b>oculos x y</b> - Para colocar um óculos<br>
			<b>me</b> - Efetuar um pensamento<br>
			<b>faturas</b> - Cria uma fatura para o cliente<br>
			<b>desmanche</b> - Visualiza a lista do desmanche<br>
			<b>wardrobe</b> - Mostra todos os outfits da casa<br>
			<b>homes</b> - Vizualisa suas residências
		</div>
		<div id='pageDiv'>
			<b>delivery</b> - Inicia o trabalho de entregador (Legal e Ilegal)
			<b>tow</b> - Colocar o veículo na prancha<br>
			<b>vtuning</b> - Verifica tunagens do veículo<br>
			<b>card</b> - Retira uma carta do baralho<br>
			<b>atm</b> - Abre um caixa eletrônico<br>
			<b>limbo</b> - Utilizado quando cair no limbo e morrer<br>
			<b>attachs</b> - Acopla melhorias em armamentos<br>
			<b>trancar</b> - Para trancar e destrancar a residência<br>
			<b>andar x</b> - Alterar o modo de andar
		</div>

		<div id="divContent"></div>

		<div id='titleContent'>BOTÕES DE ATALHO</div>
		<div id='pageDiv'>
			<b>ASPAS</b> - Abrir a mochila<br>
			<b>F9</b> - Abrir o tablet<br>
			<b>F3</b> - Abrir o registro de chamados.<br>
			<b>F6</b> - Cancela qualquer animação ativa<br>
			<b>X</b> - Levanta as mãos
		</div>
		<div id='pageDiv'>
			<b>ARROW UP</b> - Saudação<br>
			<b>ARROW DOWN</b> - Assobiar<br>
			<b>ARROW LEFT</b> - Joia<br>
			<b>ARROW RIGHT</b> - Facepalm<br>
			<b>Z</b> - Liga/Desliga motor do veículo
		</div>
		<div id='pageDiv'>
			<b>HOME</b> - Muda a distancia da fala<br>
			<b>CTRL</b> - Agachar-se<br>
			<b>B</b> - Apontar com o dedo<br>
			<b>L</b> - Tranca/Destranca o veículo
		</div>

		<div id="divContent"></div>

		<div id='titleContent'>ANIMAÇÕES ANDANDO</div>
		<div id='pageDiv'>
			<b>e caixa</b> - Segurar uma caixa na mão<br>
			<b>e cafe</b> - Segurar um copo de café<br>
			<b>e cafe2</b> - Segurar e beber um copo de café<br>
			<b>e anotar</b> - Anotações em uma caderneta<br>
			<b>e binoculos</b> - Para usar um binóculo<br>
			<b>e camera</b> - Para pegar uma câmera fotográfica<br>
			<b>e camera2</b> - Para pegar uma filmadora<br>
			<b>e mapa</b> - Olhar para o mapa da cidade<br>
			<b>e selfie</b> - Pegar o celular para tirar uma selfie<br>
			<b>e selfie2</b> - Pegar o celular para tirar uma selfie<br>
			<b>e chuva</b> - Usar guarda-chuva<br>
			<b>e chuva2</b> - Usar guarda-chuva<br>
			<b>e peace</b> - Saudar a pessoa com um paz e amor<br>
			<b>e lero</b> - Balaçar as mãos<br>
			<b>e beijo</b> - Mandar um beijo<br>
			<b>e pano</b> - Limpa o veículo mais próximo<br>
			<b>e limpar</b> - Limpar a roupa<br>
			<b>e alongar2</b> - Alongar-se<br>
			<b>e cuidar2</b> - Cuidar do paciente<br>
			<b>e verificar</b> - Verificar corpo<br>
			<b>e prebeber3</b> - Segurar bebida<br>
			<b>e bolsa</b> - Segurar bolsa na mão<br>
			<b>e bolsa4</b> - Segurar bolsa na mão<br>
			<b>e nervoso</b> - Ficar nervoso<br>
			<b>e argue</b> - Breve uma descrição do mesmo<br>
			<b>e bird</b> - Breve uma descrição do mesmo<br>
			<b>e blowkiss</b> - Breve uma descrição do mesmo
		</div>
		<div id='pageDiv'>
			<b>e digitar</b> - Digitar no computador de uma mesa<br>
			<b>e postura</b> - Postura com mãos no cinto<br>
			<b>e postura2</b> - Postura com mãos no cinto<br>
			<b>e palmas</b> - Bater palmas<br>
			<b>e palmas2</b> - Bater palmas com entusiasmo<br>
			<b>e palmas3</b> - Bater palmas com entusiasmo<br>
			<b>e palmas4</b> - Bater palmas de forma discreta<br>
			<b>e comer</b> - Comer um x-burguer<br>
			<b>e comer2</b> - Comer um cachorro-quente<br>
			<b>e comer3</b> - Comer uma rosquinha<br>
			<b>e beber</b> - Consumir bebida alcoólica<br>
			<b>e beber2</b> - Consumir bebida energética<br>
			<b>e malicia</b> - Ato provocativo<br>
			<b>e radio</b> - Usar o rádio da policia<br>
			<b>e placa</b> - Segurar uma placa<br>
			<b>e pano2</b> - Limpa o veículo mais próximo<br>
			<b>e galinha</b> - Bater os braços igual galinha<br>
			<b>e bora</b> - Chamar uma pessoa<br>
			<b>e cansado</b> - Estar cansado<br>
			<b>e cuidar3</b> - Cuidar do paciente<br>
			<b>e prebeber</b> - Segurar bebida<br>
			<b>e lixo</b> - Segurar saco de lixo<br>
			<b>e bolsa2</b> - Segurar bolsa na mão<br>
			<b>e clapangry</b> - Breve uma descrição do mesmo<br>
			<b>e comeatmebro</b> - Breve uma descrição do mesmo<br>
			<b>e peace2</b> - Breve uma descrição do mesmo<br>
			<b>e bringiton</b> - Breve uma descrição do mesmo
		</div>
		<div id='pageDiv'>
			<b>e continencia</b> - Prestar continência<br>
			<b>e prancheta</b> - Anotações em uma prancheta<br>
			<b>e ligar</b> - Realizar uma ligação<br>
			<b>e musica</b> - Tocar guitarra<br>
			<b>e musica2</b> - Tocar guitarra<br>
			<b>e musica3</b> - Tocar violão<br>
			<b>e musica4</b> - Tocar violão<br>
			<b>e beber3</b> - Consumir cerveja<br>
			<b>e beber4</b> - Consumir whisky<br>
			<b>e beber5</b> - Consumir cerveja<br>
			<b>e beber6</b> - Consumir cerveja<br>
			<b>e beber7</b> - Consumir água<br>
			<b>e varrer</b> - Varrer o chão<br>
			<b>e placa2</b> - Segurar uma placa<br>
			<b>e placa3</b> - Segurar uma placa<br>
			<b>e amem</b> - Agradecer a deus<br>
			<b>e meleca</b> - Retirar meleca do nariz<br>
			<b>e cuidar</b> - Cuidar do paciente<br>
			<b>e mexer</b> - Mexer no objeto<br>
			<b>e prebeber2</b> - Segurar bebida<br>
			<b>e caixa2</b> - Segurar uma caixa na mão<br>
			<b>e bolsa3</b> - Segurar bolsa na mão<br>
			<b>e radio2</b> - Segurar rádio na mão<br>
			<b>e superhero</b> - Breve uma descrição do mesmo<br>
			<b>e type</b> - Breve uma descrição do mesmo<br>
			<b>e yeah</b> - Breve uma descrição do mesmo
		</div>

		<div id="divContent"></div>

		<div id='titleContent'>ANIMAÇÕES PARADAS</div>
		<div id='pageDiv'>
			<b>e deitar</b> - Deitar com o braço na frente do rostoo<br>
			<b>e deitar2</b> - Deitar de bruços<br>
			<b>e deitar3</b> - Deitar de barriga pra cima<br>
			<b>e deitar4</b> - Deitar de barriga para baixo<br>
			<b>e debrucar</b> - Debruçar num parapeito<br>
			<b>e sexo</b> - Ato sexual<br>
			<b>e sexo2</b> - Ato sexual<br>
			<b>e sexo3</b> - Ato sexual<br>
			<b>e sexo4</b> - Ato sexual<br>
			<b>e sexo5</b> - Ato sexual<br>
			<b>e sexo6</b> - Ato sexual<br>
			<b>e dancar</b> - Dançar ( total de 258 )<br>
			<b>e trotar</b> - Performar um trote parado<br>
			<b>e sentar</b> - Sentar em uma cadeira/banco<br>
			<b>e sentar2</b> - Sentar no chão<br>
			<b>e sentar3</b> - Sentar no chão<br>
			<b>e fumar4</b> - Fumar<br>
			<b>e tragar</b> - Tragar cigarro não convencional<br>
			<b>e malhar</b> - Performar musculação com uma barra<br>
			<b>e malhar2</b> - Performar musculação com uma barra alta<br>
			<b>e martelo</b> - Martelar<br>
			<b>e pescar</b> - Usar uma vara de pesca<br>
			<b>e chill</b> - Breve uma descrição do mesmo<br>
			<b>e crawl</b> - Breve uma descrição do mesmo<br>
			<b>e flip</b> - Breve uma descrição do mesmo<br>
			<b>e flip2</b> - Breve uma descrição do mesmo<br>
			<b>e inspect</b> - Breve uma descrição do mesmo
		</div>
		<div id='pageDiv'>
			<b>e sentar4</b> - Sentar no chão<br>
			<b>e striper</b> - Posar como uma striper<br>
			<b>e escutar</b> - Escutar através da parede/porta<br>
			<b>e alongar</b> - Alongar-se<br>
			<b>e dj</b> - Agir como um DJ<br>
			<b>e rock</b> - Tocar um guitarra invisível<br>
			<b>e rock2</b> - Fazer o símbolo do rock com as mãos<br>
			<b>e abracar</b> - Abraçar<br>
			<b>e abracar2</b> - Abraçar<br>
			<b>e peitos</b> - Realçar os peitos<br>
			<b>e espernear</b> - Espernear no chão<br>
			<b>e arrumar</b> - Pegar e arrumar coisas do chão<br>
			<b>e bebado</b> - Cair e levantar algumas vezes no chão<br>
			<b>e bebado2</b> - Levantar do chão<br>
			<b>e bebado3</b> - Levantar do chão<br>
			<b>e yoga</b> - Performar yoga<br>
			<b>e pescar2</b> - Usar uma vara de pesca<br>
			<b>e procurar</b> - Agachar-se no chão para procurar<br>
			<b>e sinalizar</b> - Usar um sinalizador<br>
			<b>e soprador</b> - Usar um soprador<br>
			<b>e mecanico</b> - Deitar-se no chão e mexer no motor<br>
			<b>e morrer</b> - Fingir de morto<br>
			<b>e passout</b> - Breve uma descrição do mesmo<br>
			<b>e prone</b> - Breve uma descrição do mesmo<br>
			<b>e sentar7</b> - Breve uma descrição do mesmo<br>
			<b>e sitchair</b> - Breve uma descrição do mesmo
		</div>
		<div id='pageDiv'>
			<b>e abdominal</b> - Performar abdominais<br>
			<b>e bixa</b> - Posar como uma striper<br>
			<b>e britadeira</b> - Usar um britadeira<br>
			<b>e cerveja</b> - Beber cerveja<br>
			<b>e churrasco</b> - Usar uma churrasqueira<br>
			<b>e consertar</b> - Pega o massarico na mão<br>
			<b>e dormir</b> - Deitar para dormir<br>
			<b>e ajoelhar</b> - Ajoelha no chão<br>
			<b>e dormir2</b> - Deitar para dormir<br>
			<b>e dormir2</b> - Deitar para dormir<br>
			<b>e flexao</b> - Performar flexões<br>
			<b>e esquentar</b> - Esquentar as mãos<br>
			<b>e fumar</b> - Fumar (masculino)<br>
			<b>e fumar2</b> - Fumar (feminino)<br>
			<b>e fumar3</b> - Fumar<br>
			<b>e mecanico3</b> - Apoiar-se na frente do veículo<br>
			<b>e beijar</b> - Beijar<br>
			<b>e estatua</b> - Performar uma estátua<br>
			<b>e encostar</b> - Encostar-se<br>
			<b>e plantar</b> - Agachar-se no chão<br>
			<b>e mecanico2</b> - Apoiar-se na frente do veículo<br>
			<b>e sitchair2</b> - Breve uma descrição do mesmo<br>
			<b>e sitchair3</b> - Breve uma descrição do mesmo<br>
			<b>e sitchair4</b> - Breve uma descrição do mesmo<br>
			<b>e sitchair5</b> - Breve uma descrição do mesmo<br>
			<b>e meditate</b> - Breve uma descrição do mesmo
		</div>

		<div id="divContent"></div>

		<div id='titleContent'>POLÍCIA / PARAMÉDICO</div>
		<div id='pageDiv'>
			<b>placa</b> - Mostra a placa do veículo mais próximo<br>
			<b>multar</b> - Aplicar multa no ID destinado<br>
			<b>rg x</b> - X é o número do passaporte da pessoa<br>
			<b>rmascara</b> - Retirar a mascara da pessoa próxima<br>
			<b>rchapeu</b> - Retirar o chapéu da pessoa próxima<br>
			<b>re</b> - Reanimar a pessoa em coma<br>
			<b>cv x</b> - X é o número do assento do veículo
		</div>
		<div id='pageDiv'>
			<b>preset x</b> - Muda a roupa com base no número<br>
			<b>cuff</b> - Algema uma pessoa<br>
			<b>invadir</b> - Invade residencias<br>
			<b>defusar</b> - Defusar a bomba do veículo<br>
			<b>sangramento</b> - Estanca o sangramento do paciente<br>
			<b>diagnostico</b> - Vizualiza o diagnostico da pessoa<br>
			<b>setrepose x</b> - X é o número de minutos de repouso
		</div>
		<div id='pageDiv'>
			<b>detido</b> - Deixa o veículo na detenção<br>
			<b>pr</b> - Chat de conversa dos policiais<br>
			<b>hr</b> - Chat de conversa dos paramédicos<br>
			<b>tratamento</b> - Inicia o tratamento no paciente<br>
			<b>prender</b> - Envia uma pessoa para a prisão<br>
			<b>rprender</b> - Diminui a pena de uma pessoa<br>
			<b>rv</b> - Remover a pessoa do veículo
		</div>
	`);
};
/* ---------------------------------------------------------------------------------------------------------------- */
const rulesPage = () => {
	selectPage = "rules";

	$('#content').html(`
		<div id='titleContent'>ANTI-ROLEPLAY</div>
		<div id='pageContent'>
			<b>1:</b> Proibido chamar um serviço através do celular e efetuar qualquer atividade ilegal contra o mesmo.<br>
			<b>2:</b> Reféns não podem ter envolvimento com os sequestradores, pense bem antes de iniciar um sequestro.<br>
			<b>3:</b> Após ser reanimado não volte para ação, efetua sua retirada do local imediatamente.<br>
			<b>4:</b> A utilização do <s>voip</s> não pode ser utilizado para dialogar assuntos que não tem ha ver com o roleplay.<br>
			<b>5:</b> Durante uma ação caso ocorra do seu jogo crashar, é <s>obrigatório</s> voltar e continuar a história.<br>
			<b>6:</b> Não pode sequestrar uma pessoa e obriga-lá a efetuar transferências bancárias em troca de sua vida.<br>
			<b>7:</b> Na utilização de mascaras <s>não é possível</s> efetuar o reconhecimento por voz.<br>
			<b>8:</b> Policiais em serviço <s>não podem</s> ter seus pertences subtraídos.<br>
			<b>9:</b> Após nocauteado, <s>você não pode apertar o E</s>, enquanto ter pessoas próximas a você aguarde a finalização do roleplay.<br>
			<b>10:</b> Você não pode pegar uma pessoa nocauteada, reanima-la e obriga-la a passar informação, rouba-la e qualquer outra ação.<br>
			<b>11:</b> Ao adentrar em um cenário de suicídio tenha a certeza absoluta que ao cometer o mesmo seu personagem é excluído.<br>
			<b>12:</b> Veículos alugados não podem ser utilizados para atividades ilegais.<br>
			<b>13:</b> Policiais e sequestradores não podem abrir fogo até que o refém esteja em segurança.<br>
			<b>14:</b> Após ganhar ações contra policiais, você não pode chamar os paramédicos, utilize o <s>Hospital Clandestino</s>.<br>
			<b>15:</b> Após ser nocauteado propositalmente por outra pessoa, você esquece de todo o ocorrido automaticamente.<br>
			<b>16:</b> Roubo de viaturas policiais só podem ser feitas após um roubo automatizado ( Caixa Eletrônico e afins ).<br>
			<b>17:</b> Durante qualquer tipo de ação com envolvimento da policia é extremamente proibido o uso qualquer tipo de chapéu.<br>
			<b>18:</b> Qualquer tipo de ação que não sejam programadas como <s>bancos</s> e afins, o máximo é de <s>5 participantes</s>.<br>
			<b>19:</b> Os grupos criados na cidade tem o limite máximo de <s>10 participantes</s> por grupo.
		</div>

		<div id="divContent"></div>

		<div id='titleContent'>POLÍCIA / PARAMÉDICO</div>
		<div id='pageContent'>
			<b>1:</b> Qualquer tipo de corrupção dentro da corporação é <s>extremamente proibido</s>.<br>
			<b>2:</b> Viaturas não podem ser utilizadas fora de serviço ou dar carona a outras pessoas.
		</div>

		<div id="divContent"></div>

		<div id='titleContent'>CAIXA ELETRÔNICO / CAIXA REGISTRADORA</div>
		<div id='pageContent'>
			<b>1:</b> Máximo <s>2 assaltantes</s> e <s>4 policiais</s>.<br>
			<b>2:</b> Durante o confronto os policiais só podem utilizar <s>cassetete</s>/<s>taser</s> e os assaltantes <s>arma branca</s>.
		</div>

		<div id="divContent"></div>

		<div id='titleContent'>LOJA DE DEPARTAMENTO</div>
		<div id='pageContent'>
			<b>1:</b> Máximo <s>4</s> assaltantes e <s>5</s> policiais.<br>
			<b>2:</b> Obrigatório a utilização de uma arma de fogo.
		</div>

		<div id="divContent"></div>

		<div id='titleContent'>LOJA DE ARMAS</div>
		<div id='pageContent'>
			<b>1:</b> Máximo <s>3</s> assaltantes e <s>4</s> policiais.<br>
			<b>2:</b> Obrigatório a utilização de uma arma de fogo.
		</div>

		<div id="divContent"></div>

		<div id='titleContent'>JOALHERIA / BANCO FLEECA</div>
		<div id='pageContent'>
			<b>1:</b> Máximo <s>4</s> assaltantes e <s>6</s> policiais.<br>
			<b>2:</b> Obrigatório a utilização de uma arma de fogo.
		</div>

		<div id="divContent"></div>

		<div id='titleContent'>BARBEARIA</div>
		<div id='pageContent'>
			<b>1:</b> Máximo <s>2</s> assaltantes e <s>3</s> policiais.<br>
			<b>2:</b> Nao obrigatório a utilização de uma arma de fogo.
		</div>

		<div id="divContent"></div>

		<div id='titleContent'>CORRIDAS CLANDESTINAS</div>
		<div id='pageContent'>
			<b>1:</b> Durante a corrida os policiais só podem utilizar cassetete/taser e os corredores arma branca.<br>
			<b>2:</b> Policiais podem utilizar armas de fogo caso o corredor apreenda fuga a pé e venha um terceiro para busca-lo.
		</div>
	`);
};
/* ---------------------------------------------------------------------------------------------------------------- */
const bichoPage = () => {
	selectPage = "bicho";

	$('#content').html(`
	<div id='titleContent'>PRINCIPAIS</div>
		<div id='pageDiv'>
		<b>1</b> - Avestruz<br>
		<b>2</b> - Águia<br>
		<b>3</b> - Burro<br>
		<b>4</b> - Borboleta<br>
		<b>5</b> - Cachorro<br>
		<b>6</b> - Cabra<br>
		<b>7</b> - Carneiro<br>
		<b>8</b> - Camelo<br>
		<b>9</b> - Cobra<br>
		<b>10</b> - Coelho<br>
		<b>11</b> - Cavalo<br>
		<b>12</b> - Elefante<br>
		<b>13</b> - Galo<br>
		</div>
		<div id='pageDiv'>
		<b>14</b> - Gato<br>
		<b>15</b> - Jacaré<br>
		<b>16</b> - Leão<br>
		<b>17</b> - Macaco<br>
		<b>18</b> - Porco<br>
		<b>19</b> - Pavão<br>
		<b>20</b> - Peru<br>
		<b>21</b> - Touro<br>
		<b>22</b> - Tigre<br>
		<b>23</b> - Urso<br>
		<b>24</b> - Veado<br>
		<b>25</b> - Vaca<br>
		</div>
	`);
};
/* ---------------------------------------------------------------------------------------------------------------- */
const penalPage = () => {
	selectPage = "penal";

	$('#content').html(`
		<div id='penalTitle01'>CRIMES</div>
		<div id='penalTitle02'>SERVIÇOS</div>
		<div id='penalTitle03'>MULTAS</div>
		<div id='penalTitle04'>OBSERVAÇÕES</div>

		<div id='penalContent01' class='black'>Ameaça</div>
		<div id='penalContent02' class='black'>10</div>
		<div id='penalContent03' class='black'>$3.000</div>
		<div id='penalContent04' class='black'>Ameaçar alguém por palavra, escrito ou gesto.</div>

		<div id='penalContent01' class='white'>Assalto a Cívil</div>
		<div id='penalContent02' class='white'>30</div>
		<div id='penalContent03' class='white'>$15.000</div>
		<div id='penalContent04' class='white'>Subtrair posses alheias, para si ou para outrem, mediante grave ameaça ou violência.</div>

		<div id='penalContent01' class='black'>Associação criminosa</div>
		<div id='penalContent02' class='black'>10</div>
		<div id='penalContent03' class='black'>$3.000</div>
		<div id='penalContent04' class='black'>Associarem-se 3 ou mais pessoas, para fim específico de cometer crimes.</div>

		<div id='penalContent01' class='white'>Corridas ilegais</div>
		<div id='penalContent02' class='white'>20</div>
		<div id='penalContent03' class='white'>$5.000</div>
		<div id='penalContent04' class='white'>Participar de corridas clandestinas.</div>

		<div id='penalContent01' class='black'>Conspiração</div>
		<div id='penalContent02' class='black'>15</div>
		<div id='penalContent03' class='black'>0</div>
		<div id='penalContent04' class='black'>Planejar atividade ilegal.</div>

		<div id='penalContent01' class='white'>Corrupção</div>
		<div id='penalContent02' class='white'>120</div>
		<div id='penalContent03' class='white'>$80.000</div>
		<div id='penalContent04' class='white'>Solicitar, receber, obter ou utilizar para si ou para outrem, diretamente ou indiretamente.</div>

		<div id='penalContent01' class='black'>Comportamento Indisciplinar</div>
		<div id='penalContent02' class='black'>0</div>
		<div id='penalContent03' class='black'>$25.000</div>
		<div id='penalContent04' class='black'>Se comportar indevidamente com base no seu emprego.</div>

		<div id='penalContent01' class='white'>Dano ao Patrimônio</div>
		<div id='penalContent02' class='white'>0</div>
		<div id='penalContent03' class='white'>$4.000</div>
		<div id='penalContent04' class='white'>Danificar o bem de outra pessoa ou do estado.</div>

		<div id='penalContent01' class='black'>Denuncia caluniosa</div>
		<div id='penalContent02' class='black'>10</div>
		<div id='penalContent03' class='black'>$2.500</div>
		<div id='penalContent04' class='black'>Dar causa à instauração de investigação policial de processo judicial.</div>

		<div id='penalContent01' class='white'>Desacato</div>
		<div id='penalContent02' class='white'>15 + 5</div>
		<div id='penalContent03' class='white'>$10.000</div>
		<div id='penalContent04' class='white'>Desacatar funcionário público no exercício de sua função ou em razão dela.</div>

		<div id='penalContent01' class='black'>Desobediência</div>
		<div id='penalContent02' class='black'>15 + 5</div>
		<div id='penalContent03' class='black'>$5.000</div>
		<div id='penalContent04' class='black'>Desobedecer ordem de funcionário público.</div>

		<div id='penalContent01' class='white'>Dinheiro Ilícito</div>
		<div id='penalContent02' class='white'>10</div>
		<div id='penalContent03' class='white'>0</div>
		<div id='penalContent04' class='white'>Em roubos de grande porte a pena é dobrada.</div>

		<div id='penalContent01' class='black'>Estelionato</div>
		<div id='penalContent02' class='black'>15</div>
		<div id='penalContent03' class='black'>$3.000</div>
		<div id='penalContent04' class='black'>Obter para si ou para outrem vantagem ilícita em prejuízo alheio.</div>

		<div id='penalContent01' class='white'>Extorsão</div>
		<div id='penalContent02' class='white'>20</div>
		<div id='penalContent03' class='white'>$3.000</div>
		<div id='penalContent04' class='white'>Obrigar a tomar um determinado comportamento por meio de ameaça ou violência.</div>

		<div id='penalContent01' class='black'>Falsa Identidade</div>
		<div id='penalContent02' class='black'>5</div>
		<div id='penalContent03' class='black'>$4.000</div>
		<div id='penalContent04' class='black'>Atribuir-se ou atribuir a terceiro para obter vantagem em proveito próprio ou alheio.</div>

		<div id='penalContent01' class='white'>Falsidade ideologica</div>
		<div id='penalContent02' class='white'>10</div>
		<div id='penalContent03' class='white'>$2.000</div>
		<div id='penalContent04' class='white'>Atribuir à si ou a terceiros falsa identidade para obter vantagem em proveito alheio.</div>

		<div id='penalContent01' class='black'>Falso testemunho</div>
		<div id='penalContent02' class='black'>10</div>
		<div id='penalContent03' class='black'>$2.500</div>
		<div id='penalContent04' class='black'>Fazer afirmação falsa, negar ou calar a verdade.</div>

		<div id='penalContent01' class='white'>Fraude</div>
		<div id='penalContent02' class='white'>12</div>
		<div id='penalContent03' class='white'>$2.000</div>
		<div id='penalContent04' class='white'>Mentorar ou participar de esquema ilícito ou de má-fé visando obter vantagens.</div>

		<div id='penalContent01' class='black'>Fuga</div>
		<div id='penalContent02' class='black'>10</div>
		<div id='penalContent03' class='black'>$2.000</div>
		<div id='penalContent04' class='black'>Evadir-se da polícia.</div>

		<div id='penalContent01' class='white'>Furto</div>
		<div id='penalContent02' class='white'>12</div>
		<div id='penalContent03' class='white'>$2.000</div>
		<div id='penalContent04' class='white'>Subtrair, para si ou para outrem coisa móvel alheia.</div>

		<div id='penalContent01' class='black'>Injúria</div>
		<div id='penalContent02' class='black'>10</div>
		<div id='penalContent03' class='black'>$2.000</div>
		<div id='penalContent04' class='black'>Injuriar alguém, ofendendo-lhe a dignidade ou o decoro.</div>

		<div id='penalContent01' class='white'>Invasão</div>
		<div id='penalContent02' class='white'>15</div>
		<div id='penalContent03' class='white'>$2.000</div>
		<div id='penalContent04' class='white'>Invadir áreas privadas, ou públicas de acesso restrito.</div>

		<div id='penalContent01' class='black'>Latrocínio</div>
		<div id='penalContent02' class='black'>35</div>
		<div id='penalContent03' class='black'>$6.000</div>
		<div id='penalContent04' class='black'>Roubo seguido de morte.</div>

		<div id='penalContent01' class='white'>Lesão corporal</div>
		<div id='penalContent02' class='white'>10</div>
		<div id='penalContent03' class='white'>$2.000</div>
		<div id='penalContent04' class='white'>Ofender a integridade corporal ou a saúde de outrem.</div>

		<div id='penalContent01' class='black'>Multas não pagas</div>
		<div id='penalContent02' class='black'>4 / $1.000</div>
		<div id='penalContent03' class='black'>0</div>
		<div id='penalContent04' class='black'>Multas com atrasao de 24 horas no pagamento.</div>

		<div id='penalContent01' class='white'>Objetos roubados</div>
		<div id='penalContent02' class='white'>10</div>
		<div id='penalContent03' class='white'>$2.00</div>
		<div id='penalContent04' class='white'>Objetos subtraidos através de roubos.</div>

		<div id='penalContent01' class='black'>Obstrução da justiça</div>
		<div id='penalContent02' class='black'>15</div>
		<div id='penalContent03' class='black'>$2.000</div>
		<div id='penalContent04' class='black'>Cometer o impedimento ou qualquer forma que atrapalhe a investigação.</div>

		<div id='penalContent01' class='white'>Ocultação Facial</div>
		<div id='penalContent02' class='white'>10</div>
		<div id='penalContent03' class='white'>$25.000</div>
		<div id='penalContent04' class='white'>Utilização de adornos ou acessórios que ocultem totalmente ou parcialmente a face.</div>

		<div id='penalContent01' class='black'>Omissão de socorro</div>
		<div id='penalContent02' class='black'>10</div>
		<div id='penalContent03' class='black'>$2.000</div>
		<div id='penalContent04' class='black'>Deixar de prestar assistência, quando possível fazê-lo sem risco pessoal ou ferida.</div>

		<div id='penalContent01' class='white'>Perseguição</div>
		<div id='penalContent02' class='white'>20</div>
		<div id='penalContent03' class='white'>0</div>
		<div id='penalContent04' class='white'>Seguir alguém, perseguir ou qualquer coisa do genero.</div>

		<div id='penalContent01' class='black'>Porte/Posse ilegal de armas classe 1</div>
		<div id='penalContent02' class='black'>10</div>
		<div id='penalContent03' class='black'>$2.000</div>
		<div id='penalContent04' class='black'>Porte / Posse ilegal de armas semi-automáticas.</div>

		<div id='penalContent01' class='white'>Porte/Posse ilegal de armas classe 2</div>
		<div id='penalContent02' class='white'>15</div>
		<div id='penalContent03' class='white'>$3.000</div>
		<div id='penalContent04' class='white'>Porte / Posse ilegal de armas automáticas.</div>

		<div id='penalContent01' class='black'>Produtos Ilícitos</div>
		<div id='penalContent02' class='black'>10</div>
		<div id='penalContent03' class='black'>$2.000</div>
		<div id='penalContent04' class='black'>Produto adquirido por roubos ou utilizado para crimes.</div>

		<div id='penalContent01' class='white'>Receptação</div>
		<div id='penalContent02' class='white'>10</div>
		<div id='penalContent03' class='white'>0</div>
		<div id='penalContent04' class='white'>Receptar, em proveito próprio ou alheio, coisa que se saiba ser produto de crime.</div>

		<div id='penalContent01' class='black'>Resistência</div>
		<div id='penalContent02' class='black'>15</div>
		<div id='penalContent03' class='black'>0</div>
		<div id='penalContent04' class='black'>Opor-se à execução de ato legal, mediante violência ou ameaça ao funcionário.</div>

		<div id='penalContent01' class='white'>Roubo</div>
		<div id='penalContent02' class='white'>15</div>
		<div id='penalContent03' class='white'>$3.000</div>
		<div id='penalContent04' class='white'>Subtrair posses alheias, para si ou para outrem, mediante grave ameaça ou violência.</div>

		<div id='penalContent01' class='black'>Roupas policiais</div>
		<div id='penalContent02' class='black'>0</div>
		<div id='penalContent03' class='black'>$5.000</div>
		<div id='penalContent04' class='black'>Utilizar qualquer utilitário exclusivo policial.</div>

		<div id='penalContent01' class='white'>Sequestro</div>
		<div id='penalContent02' class='white'>20</div>
		<div id='penalContent03' class='white'>$3.000</div>
		<div id='penalContent04' class='white'>Privar alguém de sua liberdade mediante sequestro ou cárcere privado.</div>

		<div id='penalContent01' class='black'>Suborno</div>
		<div id='penalContent02' class='black'>15</div>
		<div id='penalContent03' class='black'>$3.000</div>
		<div id='penalContent04' class='black'>Oferecer ou prometer vantagem indevida a funcionário público.</div>

		<div id='penalContent01' class='white'>Tentativa / Homicídio</div>
		<div id='penalContent02' class='white'>20 + 5</div>
		<div id='penalContent03' class='white'>$5.000</div>
		<div id='penalContent04' class='white'>Quando o suspeito quis o resultado e assumiu o risco de produzí-lo.</div>

		<div id='penalContent01' class='black'>Tentativa / Homicídio Oficial</div>
		<div id='penalContent02' class='black'>25 + 5</div>
		<div id='penalContent03' class='black'>$7.500</div>
		<div id='penalContent04' class='black'>Quando o suspeito quis o resultado e assumiu o risco de produzí-lo em um oficial do governo.</div>

		<div id='penalContent01' class='white'>Terrorismo</div>
		<div id='penalContent02' class='white'>50</div>
		<div id='penalContent03' class='white'>$10.000</div>
		<div id='penalContent04' class='white'>Cuja violência ilegítima passa a denominar-se terror.</div>

		<div id='penalContent01' class='black'>Tráfico</div>
		<div id='penalContent02' class='black'>1</div>
		<div id='penalContent03' class='black'>0</div>
		<div id='penalContent04' class='black'>Para cada 2 <s>Joints</s> ou <s>Weeds</s> possuídos.</div>

		<div id="divContent"></div>

		<div id='penalTitle01'>INFRAÇÕES</div>
		<div id='penalTitle02'>SERVIÇOS</div>
		<div id='penalTitle03'>MULTAS</div>
		<div id='penalTitle04'>OBSERVAÇÕES</div>

		<div id='penalContent01' class='white'>Alta velocidade</div>
		<div id='penalContent02' class='white'>0</div>
		<div id='penalContent03' class='white'>$2.000</div>
		<div id='penalContent04' class='white'>Aumenta $300 dólares a cada 10mph.</div>

		<div id='penalContent01' class='black'>Direção imprudente</div>
		<div id='penalContent02' class='black'>0</div>
		<div id='penalContent03' class='black'>$2.500</div>
		<div id='penalContent04' class='black'>Conduta imprudente no transito utilizando um caminhão ou ônibus.</div>

		<div id='penalContent01' class='white'>Direção perigosa</div>
		<div id='penalContent02' class='white'>0</div>
		<div id='penalContent03' class='white'>$2.000</div>
		<div id='penalContent04' class='white'>Uso negligente ou imprudente de um veículo.</div>

		<div id='penalContent01' class='black'>Estacionar em local proibido</div>
		<div id='penalContent02' class='black'>0</div>
		<div id='penalContent03' class='black'>$2.000</div>
		<div id='penalContent04' class='black'>Deixar o veículo em local indevido.</div>

		<div id='penalContent01' class='white'>Pousar em local proibido ou sem designação</div>
		<div id='penalContent02' class='white'>0</div>
		<div id='penalContent03' class='white'>$25.000</div>
		<div id='penalContent04' class='white'>Pousar veículos aéreos fora de locais adequados e seguros.</div>

		<div id='penalContent01' class='black'>Veículo abandonado</div>
		<div id='penalContent02' class='black'>0</div>
		<div id='penalContent03' class='black'>$2.000</div>
		<div id='penalContent04' class='black'>Abandonar veículo em local indevido.</div>

		<div id="divContent"></div>

		<div id='titleContent'>OBSERVAÇÕES GERAIS</div>
		<div id='pageContent'>
			<b>1:</b> Posse legal de drogas é até 5 unidades, passando da quantidade legal o mesmo é indiciado pelo crime de Tráfico.<br>
			<b>2:</b> Veículos são apreendidos quando o condutor ou passageiro atenta contra a vida de um cidadão utilizando uma arma de fogo ou quando o veículo é jogado dentro do mar propositalmente.<br>
			<b>3:</b> Cada serviço pode ser convertido em $2.000 dólares, crimes que atentam contra a vida de outro cidadão não estão sujeitas a fiança.<br>
			<b>4:</b> Não há crime de cumplicidade, as pessoas que colaboram diretamente ou indiretamente para o crime receberão a mesma pena.<br>
			<b>5:</b> Conversas entre suspeitos e advogados são confidenciais, dê uma distância respeitosa para que os mesmos conversem sem interrupções.<br>
			<b>6:</b> Limite de velocidade dentro da cidade é de <b>60 mph</b>, veículos de grande porte o limite de velocidade é de <s>40mph</s>.
		</div>
	`);
};
/* ----------ABOUT---------- */
const aboutPage = () => {
	selectPage = "about";

	$.post("http://tablet/requestAbout",JSON.stringify({}),(data) => {

		$("#content").html(`
			<div id="titleContent">SOBRE</div>
			<div id="aboutInfos">
				<b>Nome:</b> <span id="aboutResult">${data.infos[0]}</span><br>
				<b>Passaporte:</b> <span id="aboutResult">${data.infos[1]}</span><br>
				<b>Telefone:</b> <span id="aboutResult">${data.infos[4]}</span><br>
				<b>Identidade:</b> <span id="aboutResult">${data.infos[5]}</span><br>
				<b>Saldo Bancário:</b> <span id="aboutResult">$${format(data.infos[2])}</span><br>
				<b>Gemas:</b> <span id="aboutResult">${format(data.infos[3])}</span><br>
				<b>Obs: Seu PIX é o seu Passaporte.</b><br>
			</div>

			<div id="animalGame">
			<b>JOGO DO BICHO</b><br>
			Você pode apostar uma vez em cada bicho disponível.<br>
			<input id="gameValue" class="gameValue" type="number" spellcheck="false" onKeyPress="if(this.value.length==9) return false;" value="" placeholder="VALOR..">
			<input id="gameAnimal" class="gameValue" type="number" spellcheck="false" onKeyPress="if(this.value.length==1) return false;" value="" placeholder="BICHO..">
			<div id="gameSubmit"><i class="material-icons done">VAI</i></div>

			<div id="gameLegends">
				<div id="gameCollum">
					<b>1:</b> Camelo<br>
					<b>2:</b> Pavão<br>
					<b>3:</b> Elefante
				</div>
				<div id="gameCollum">
					<b>4:</b> Coelho<br>
					<b>5:</b> Burro<br>
					<b>6:</b> Gato
				</div>
				<div id="gameCollum">
					<b>7:</b> Galo<br>
					<b>8:</b> Tigre<br>
					<b>9:</b> Rato
				</div>
			</div>
		</div>
		

			<div id="pix">
			<b>PIX</b><br>
			Transferencia rápida via PIX.<br>
			<input id="pixValue" class="pixValue" type="number" spellcheck="false" onKeyPress="if(this.value.length==9) return false;" value="" placeholder="VALOR">
			<input id="pixTarget" class="pixValue" spellcheck="false" onKeyPress="if(this.value.length==9) return false;" value="" placeholder="PIX">
			<div id="pixSubmit"><i class="material-icons done">PIX</i></div>
			</div>
	`);
});
};
/* ----------GAMESUBMIT---------- */
$(document).on("click","#gameSubmit",function(e){
	let value = parseInt($("#gameValue").val());
	let animal = parseInt($("#gameAnimal").val());

	if (value > 0 && animal > 0){
		$.post("http://tablet/inputGame",JSON.stringify({ value: value, animal: animal }));
	}
	$("#gameValue").val('')
	$("#gameAnimal").val('')
});
/* ----------PIXSUBMIT---------- */
$(document).on("click","#pixSubmit",function(e){
	let value = parseInt($("#pixValue").val());
	let target = parseInt($("#pixTarget").val());

	if (value > 0 && target > 0){
		$.post("http://tablet/inputPix",JSON.stringify({ value: value, target: target }));
	}
	$("#pixValue").val('')
	$("#pixTarget").val('')
});
/* ---------------------------------------------------------------------------------------------------------------- */
const racesPage = (raceId) => {
	selectPage = "races";

	if (raceId == undefined){
		raceId = 1;
	}

	$("#content").html(`
		<div id="raceBar">
			<li id="circuits" data-id="1" ${raceId == 1 ? "class=active":""}>01</li>
			<li id="circuits" data-id="2" ${raceId == 2 ? "class=active":""}>02</li>
			<li id="circuits" data-id="3" ${raceId == 3 ? "class=active":""}>03</li>
			<li id="circuits" data-id="4" ${raceId == 4 ? "class=active":""}>04</li>
			<li id="circuits" data-id="5" ${raceId == 5 ? "class=active":""}>05</li>
			<li id="circuits" data-id="6" ${raceId == 6 ? "class=active":""}>06</li>
			<li id="circuits" data-id="7" ${raceId == 7 ? "class=active":""}>07</li>
			<li id="circuits" data-id="8" ${raceId == 8 ? "class=active":""}>08</li>
			<li id="circuits" data-id="9" ${raceId == 9 ? "class=active":""}>09</li>
			<li id="circuits" data-id="10" ${raceId == 10 ? "class=active":""}>10</li>
			<li id="circuits" data-id="11" ${raceId == 11 ? "class=active":""}>11</li>
			<li id="circuits" data-id="12" ${raceId == 12 ? "class=active":""}>12</li>
			<li id="circuits" data-id="13" ${raceId == 13 ? "class=active":""}>13</li>
			<li id="circuits" data-id="14" ${raceId == 14 ? "class=active":""}>14</li>
			<li id="circuits" data-id="15" ${raceId == 15 ? "class=active":""}>15</li>
			<li id="circuits" data-id="16" ${raceId == 16 ? "class=active":""}>16</li>
		</div>

		<div id="raceContent"></div>
	`);

	$.post("http://tablet/requestRanking",JSON.stringify({ id: raceId }),(data) => {
		let position = 0;

		$.each(data,(k,v) => {
			$('#raceContent').append(`
				<div id="raceLine">
					<div class="racePosition">${position = position + 1}</div>
					<div class="raceName">${v["lastname"]} ${(position == 1 || position == 2 || position == 3) ? "<img src=\"images/"+position+".png\">":""}</div>
					<div class="raceVehicle">${v["vehicle"]}</div>
					<div class="racePoints">${v["date2"]}</div>
					<div class="raceDate">${v["date"]}</div>
				</div>
			`);
		});
	});
};
/* ----------CLICKRACES---------- */
$(document).on("click","#circuits",function(e){
	racesPage(e["target"]["dataset"]["id"]);
});
/* ---------------------------------------------------------------------------------------------------------------- */
var benMode = "Carros"
var benSearch = "alphabetic"

const searchTypePage = (mode) => {
	benSearch = mode;
	benefactor(benMode);
}
/* ---------------------------------------------------------------------------------------------------------------- */
const benefactor = (mode) => {
	benMode = mode;
	selectPage = "benefactor";
	$("#content").html(`
		<div id="raceBar">
		<li id="benefactor" data-id="Carros" ${mode == "Carros" ? "class=active":""}>CARROS</li>
		<li id="benefactor" data-id="Motos" ${mode == "Motos" ? "class=active":""}>MOTOS</li>
		<li id="benefactor" data-id="Aluguel" ${mode == "Aluguel" ? "class=active":""}>ALUGUEL</li>
		<li id="benefactor" data-id="Servicos" ${mode == "Servicos" ? "class=active":""}>SERVIÇOS</li>
		<li id="benefactor" data-id="Possuidos" ${mode == "Possuidos" ? "class=active":""}>POSSUÍDOS</li>
		</div>

		<div id="contentVehicles">
			<div id="titleVehicles">${mode}</div>
			<div id="typeSearch"><span onclick="searchTypePage('alphabetic');">Ordem Alfabética</span> / <span onclick="searchTypePage('crescent');">Valor Crescente</span></div>
			<div id="pageVehicles"></div>
		</div>
	`);

	$.post(`http://tablet/request`+ mode,JSON.stringify({}),(data) => {
		let i = 0;
		if (benSearch == "alphabetic"){
			var nameList = data.veiculos.sort((a,b) => (a["name"] > b["name"]) ? 1: -1);
		} else {
			var nameList = data.veiculos.sort((a,b) => (a["price"] > b["price"]) ? 1: -1);
		}

		if (mode !== "Possuidos"){
			$("#pageVehicles").html(`
				${nameList.map((item) => (`<span>
					<left>
						${item["name"]}<br>
						<b>Valor:</b> ${mode == "Aluguel" ? format(item["price"])+" Gemas":"$"+format(item["price"])}<br>
						<b>Taxa:</b> $${format(item["tax"])}<br>
						<b>Porta-Malas:</b> ${format(item["chest"])}Kg
					</left>
					<right>
						${mode == "Aluguel"?"<div id=\"benefactorRental\"data-name="+item["k"]+">ALUGAR</div>":"<div id=\"benefactorBuy\" data-name="+item["k"]+">COMPRAR</div>"}
						<div id="benefactorDrive" data-name="${item["k"]}">TESTAR</div>
					</right>
				</span>`)).join('')}
			`);
		} else {
			$("#pageVehicles").html(`
				${nameList.map((item) => (`<span>
					<left>
						${item["name"]}<br>
						<b>Valor:</b> ${mode == "Aluguel" ? format(item["price"])+" Gemas":"$"+format(item["price"])}<br>
						<b>Porta-Malas:</b> ${format(item["chest"])}Kg
					</left>
					<right>
						<div id="benefactorSell" data-name="${item["k"]}">VENDER</div>
						<div id="benefactorTax" data-name="${item["k"]}">PAGAR</div>
					</right>
				</span>`)).join('')}
			`);
		}
	});
};
/* ----------BENEFACTOR---------- */
$(document).on("click","#benefactor",function(e){ benefactor(e["target"]["dataset"]["id"]);
});
/* ----------BENEFACTORBUY---------- */
$(document).on("click","#benefactorBuy",function(e){
	$.post("http://tablet/buyDealer",JSON.stringify({name: e["target"]["dataset"]["name"]}));
	benefactor("Carros");
});
/* ----------BENEFACTORRENTAL---------- */
$(document).on("click","#benefactorRental",function(e){
	$.post("http://tablet/buyDealer",JSON.stringify({name: e["target"]["dataset"]["name"]}));
	benefactor('Carros');
});
/* ----------BENEFACTORSELL---------- */
$(document).on("click","#benefactorSell",function(e){
	$.post("http://tablet/sellDealer",JSON.stringify({name: e["target"]["dataset"]["name"]}));
	$.post("http://tablet/closeSystem");
	benefactor('Carros');
});
/* ----------BENEFACTORTAX---------- */
$(document).on("click","#benefactorTax",function(e){
	$.post("http://tablet/requestTax",JSON.stringify({ name: e["target"]["dataset"]["name"] }));
	benefactor('Carros');
});
/* ----------BENEFACTORDRIVE---------- */
$(document).on("click","#benefactorDrive",function(e){
	$.post("http://tablet/requestDrive",JSON.stringify({ name: e["target"]["dataset"]["name"] }));
	benefactor('Carros');
	$.post("http://tablet/closeSystem");
});
/* ----------FORMAT---------- */
const format = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}