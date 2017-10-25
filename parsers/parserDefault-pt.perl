#!/usr/bin/env perl
package Parser;

use strict;#<ignore-line>
binmode STDIN, ':utf8';#<ignore-line>
binmode STDOUT, ':utf8';#<ignore-line>
binmode STDERR, ':utf8';#<ignore-line>
use utf8;#<ignore-line>
  
# Pipe
my $pipe = !defined (caller);#<ignore-line>   
  
#fronteira de frase:
my $Border="SENT";#<string>

#identificar nomes de dependencias lexicais (idiomaticas)
my $DepLex = "^<\$|^>\$|lex\$";#<string>

#string com todos os atributos:
my $b2 = "[^ _<>]*";#<string>

my $a2 = "\\_<${b2}>";##<string>todos os atributos
my $l =  "\\_<${b2}";##<string>atributos parte esquerda
my $r =  "${b2}>";##<string>atributos parte direita


###########################GENERATED CODE BY COMPI#############################################

######################################## POS TAGS ########################################
my $ADJ = "ADJ_[0-9]+";#<string>
my $NOUN = "NOUN_[0-9]+";#<string>
my $PRP = "PRP_[0-9]+";#<string>
my $ADV = "ADV_[0-9]+";#<string>
my $CARD = "CARD_[0-9]+";#<string>
my $CONJ = "CONJ_[0-9]+";#<string>
my $DET = "DET_[0-9]+";#<string>
my $PRO = "PRO_[0-9]+";#<string>
my $VERB = "VERB_[0-9]+";#<string>
my $I = "I_[0-9]+";#<string>
my $DATE = "DATE_[0-9]+";#<string>
my $POS = "POS_[0-9]+";#<string>
my $PCLE = "PCLE_[0-9]+";#<string>
my $EX = "EX_[0-9]+";#<string>
my $Fc = "Fc_[0-9]+";#<string>
my $Fg = "Fg_[0-9]+";#<string>
my $Fz = "Fz_[0-9]+";#<string>
my $Fe = "Fe_[0-9]+";#<string>
my $Fd = "Fd_[0-9]+";#<string>
my $Fx = "Fx_[0-9]+";#<string>
my $Fpa = "Fpa_[0-9]+";#<string>
my $Fpt = "Fpt_[0-9]+";#<string>
my $Fca = "Fca_[0-9]+";#<string>
my $Fct = "Fct_[0-9]+";#<string>
my $Fra = "Fra_[0-9]+";#<string>
my $Frc = "Frc_[0-9]+";#<string>
my $SENT = "SENT_[0-9]+";#<string>
my $NP = "NOUN_[0-9]+$a2|PRP_[0-9]+${l}nomin:yes${r}|VERB_[0-9]+${l}nomin:yes${r}";#<string>
my $NOMINAL = "NOUN_[0-9]+$a2|PRP_[0-9]+${l}nomin:yes${r}|VERB_[0-9]+${l}nomin:yes${r}|CONJ_[0-9]+${l}coord:noun${r}";#<string>
my $NOUNCOORD = "CARD_[0-9]+$a2|DATE_[0-9]+$a2|NOUN_[0-9]+$a2|CONJ_[0-9]+${l}coord:noun${r}";#<string>
my $NOUNSINGLE = "CARD_[0-9]+$a2|DATE_[0-9]+$a2|NOUN_[0-9]+";#<string>
my $NPCOORD = "CONJ_[0-9]+${l}coord:np${r}|NOUN_[0-9]+${l}type:P${r}";#<string>
my $X = "[A-Z]+_[0-9]+";#<string>
my $NOTVERB = "[^V][^E]+_[0-9]+";#<string>
my $PUNCT = "F[a-z]+_[0-9]+";#<string>



#################################### LEXICAL CLASSES #####################################
my $Quant  = "(?:very\|more\|less\|least\|most\|quite\|as\|muy\|mucho\|bastante\|bien\|casi\|tan\|muy\|bem\|ben\|menos\|poco\|mui\|moi\|muito\|tão\|más\|mais\|máis\|pouco\|peu\|assez\|plus\|moins\|aussi\|)";#<string>
my $CCord  = "(?:and\|or\|nor\|y\|ni\|e\|nin\|nem\|et\|o\|ou\|)";#<string>
my $Partitive  = "(?:de\|of\|)";#<string>
my $PrepLocs  = "(?:a\|de\|por\|par\|by\|to\|)";#<string>
my $PrepRA  = "(?:de\|com\|con\|sobre\|sem\|sen\|sin\|entre\|of\|with\|about\|without\|between\|on\|avec\|sûr\|)";#<string>
my $PrepMA  = "(?:hasta\|até\|hacia\|desde\|em\|en\|para\|since\|until\|at\|in\|for\|to\|jusqu\'\|depuis\|pour\|dans\|)";#<string>
my $cliticopers  = "(?:lo\|la\|los\|las\|le\|les\|nos\|os\|me\|te\|se\|Lo\|La\|Las\|Le\|Les\|Nos\|Me\|Te\|Se\|lle\|lles\|lhe\|lhes\|Lles\|Lhes\|Lle\|Lhe\|che\|ches\|Che\|Ches\|o\|O\|a\|A\|os\|Os\|as\|As\|him\|her\|me\|us\|you\|them\|lui\|leur\|leurs\|)";#<string>
my $cliticoind  = "(?:le\|les\|nos\|me\|te\|Le\|Les\|Nos\|Me\|Te\|)";#<string>
my $PROperssuj = "(?:yo\|tú\|usted\|él\|ella\|nosotros\|vosotros\|ellos\|ellas\|ustedes\|eu\|ti\|tu\|vostede\|você\|ele\|ela\|nós\|vós\|eles\|elas\|vostedes\|vocês\|eles\|elas\|you\|i\|we\|they\|he\|she\|je\|il\|elle\|ils\|elles\|nous\|vous\|)";#<string>
my $PROsujgz = "(?:eu\|ti\|tu\|vostede\|você\|el\|ele\|ela\|nós\|vós\|eles\|elas\|vostedes\|vocês\|eles\|elas\|)";#<string>
my $VModalEN  = "(?:can\|cannot\|should\|must\|shall\|will\|would\|may\|might\|)";#<string>
my $VModalES   = "(?:poder\|deber\|)";#<string>
my $Vpass  = "(?:ser\|be\|être\|)";#<string>
my $Vaux  = "(?:haber\|haver\|ter\|have\|avoir\|)";#<string>
my $NincSp  = "(?:alusión\|comentario\|referencia\|llamamiento\|mención\|observación\|declaración\|propuesta\|pregunta\|)";#<string>
my $NincExp  = "(?:afecto\|alegría\|amparo\|angustia\|ánimo\|cariño\|cobardía\|comprensión\|consuelo\|corte\|daño\|disgusto\|duda\|escándalo\|fobia\|gana\|gracias\|gusto\|inquietud\|)";#<string>
my $PTa  = "(?:aceder\|acostumar\|acudir\|adaptar\|comprometer\|chegar\|cheirar\|dar\|dedicar\|equivaler\|ir\|olhar\|negar\|pertencer\|recorrer\|referir\|regressar\|renunciar\|subir\|sustrair\|unir\|vincular\|voltar\|acostumbrar\|llegar\|oler\|mirar\|pertenecer\|recurrir\|sustraer\|volver\|)";#<string>
my $AdvTemp  = "(?:hoje\|ontem\|amanhã\|hoy\|ayer\|mañana\|hoxe\|onte\|)";#<string>
my $VSrefleja  = "(?:acabar\|esgotar\|apontar\|espalhar\|desencadear\|filtrar\|importar\|informar\|produzir\|quebrar\|)";#<string>
my $VSind  = "(?:agradar\|apaixonar\|apetecer\|assombrar\|desagradar\|encantar\|estranhar\|faltar\|interessar\|)";#<string>
my $VS  = "(?:decorrer\|afirmar\|abundar\|aflorar\|agradar\|habitar\|aparecer\|apaixonar\|arder\|bastar\|bramir\|brilhar\|brotar\|caber\|cessar\|circular\|começar\|comparecer\|concluir\|afluir\|constar\|contrastar\|concordar\|coalhar\|dançar\|desfilar\|gastar\|doer\|começar\|estourar\|existir\|faltar\|fascinar\|chatear\|figurar\|finalizar\|fracassar\|gostar\|encher\|escusar\|imperar\|intervir\|bater\|interceder\|ocorrer\|parecer\|perdurar\|predominar\|\|particularizar\|ranger\|reinar\|replicar\|rebentar\|rugir\|sentenciar\|sobrar\|sobrevir\|sobreviver\|soar\|suceder\|surgir\|tremer\|cruzar\|transcorrer\|urgir\|)";#<string>
my $SubcatIND  = "(?:dar\|agradar\|parecer\|fazer\|dizer\|perguntar\|pedir\|passar\|pôr\|ocorrer\|atribuir\|falar\|oferecer\|contar\|entregar\|atirar\|importar\|interessar\|deixar\|tirar\|servir\|tocar\|encantar\|prestar\|escrever\|dirigir\|dedicar\|corresponder\|explicar\|permitir\|acrescentar\|presentear\|ensinar\|sorrir\|devolver\|enviar\|apresentar\|contribuir\|dever\|exigir\|levar\|permanecer\|faltar\|abrir\|impor\|ter\|ir\|propor\|pagar\|comunicar\|ordenar\|conceder\|tirar\|mandar\|custar\|mostrar\|agregar\|escapar\|chegar\|vir\|atribuir\|outorgar\|cair\|negar\|trazer\|ver\|meter\|recordar\|tender\|dever\|vender\|causar\|aplicar\|pegar\|cerrar\|expor\|agradecer\|consultar\|responder\|encarregar\|render\|comprar\|imprimir\|ocultar\|sair\|demonstrar\|tomar\|expor\|cortar\|diminuir\|confessar\|assegurar\|confiar\|ser\|concordar\|encontrar\|agradar\|gritar\|perder\|recomendar\|impedir\|roubar\|chamar\|atribuir\|entrar\|facilitar\|prometer\|solicitar\|pegar\|caber\|furtar\|advertir\|proporcionar\|bastar\|comentar\|conferir\|doer\|estranhar\|produzir\|adjudicar\|evitar\|avisar\|brindar\|supor\|indicar\|arrebatar\|bater\|cantar\|valer\|esquecer\|referir\|prender\|suplicar\|arengar\|imputar\|revelar\|surpreender\|aconselhar\|buscar\|plantar\|reclamar\|repetir\|invejar\|replicar\|levantar\|perdoar\|relatar\|sugerir\|guardar\|reprovar\|afectar\|procurar\|dever\|arengar\|furtar\|)";#<string>
my $SubcatA  = "(?:acceder\|aproximar\|acertar\|acostumar\|acudir\|adaptar\|afetar\|aferrar\|aficionar\|afiliar\|ajustar\|aludir\|apelar\|apostar\|apressar\|aproximar\|emprestar\|jogar\|asistir\|assomar\|atender\|atinar\|atrever\|avenir\|comprometer\|conduzir\|contribuir\|corresponder\|dever\|dedicar\|dirigir\|dispor\|enfrentar\|equivaler\|expor\|induzir\|convitar\|ir\|limitar\|chegar\|mudar\|negar\|obrigar\|cheirar\|opor\|pertencer\|precipitar\|proceder\|recorrer\|referir\|regresar\|remontar\|renunciar\|resignar\|resistir\|submeter\|subir\|sumar\|subtrair\|tender\|trasladar\|unir\|vincular\|volver\|ir\|ligar\|levar\|volver\|venir\|chegar\|sair\|referir\|dirigir\|atrever\|dedicar\|obrigar\|dar\|passar\|pertencer\|dispor\|asistir\|subir\|acudir\|responder\|regressar\|ajudar\|olhar\|convidar\|jogar\|assomar\|negar\|limitar\|sentar\|renunciar\|baixar\|enfrentar\|aprender\|lançar\|afetar\|conduzir\|entrar\|chamar\|tender\|esperar\|correr\|decidir\|reducir\|destinar\|corresponder\|fazer\|submeter\|aludir\|entregar\|unir\|dever\|contribuir\|resistir\|arrojar\|mandar\|cheirar\|recorrer\|acompanhar\|opor\|acostumar\|acceder\|cair\|aplicar\|estar\|aproximar\|lançar\|trasladar\|trair\|proceder\|apressar\|pôr\|condenar\|ensinar\|ficar\|enviar\|adaptar\|ajustar\|tirar\|expor\|incorporar\|escapar\|sacar\|atender\|forçar\|animar\|marchar\|acertar\|devolver\|agarrar\|aspirar\|presentar\|saltar\|retirar\|extender\|ascender\|comprometer\|parar\|remeter\|agarrar\|abraçar\|resignar\|apostar\|pegar\|contestar\|seguir\|aproximar\|prestar\|elevar\|obedecer\|conciliar\|largar\|ceder\|sumar\|precipitar\|viajar\|preferir\|avançar\|remontar\|apontar\|equivaler\|abrir\|mover\|inclinar\|subtrair\|acolher\|concernir\|impulsar\|deslocar\|abandonar\|induzir\|assemelhar\|dobrar\|subjazer\|atender\|sujeitar\|impor\|sobrepor\|transportar\|adequar\|empurrar\|instar\|deixar\|encaminhar\|encontrar\|transmitir\|declarar\|equiparar\|viver\|incitar\|sobreviver\|colocar\|sonar\|pagar\|autorizar\|aguardar\|oferecer\|reintegrar\|arrastar\|levantar\|tocar\|mudar\|arriscar\|cerrar\|traduzir\|descer\|provar\|retornar\|aficionar\|sucumbir\|concurrer\|consagrar\|convocar\|dobrar\|atinar\|comparar\|anticipar\|comparecer\|vincular\|apelar\|tender\|cruzar\|cambiar\|exortar\|achar\|afiliar\|atar\|preparar\|resolver\|associar\|optar\|saber\|meter\|baixar\|dizer\|sacrificar\|assinalar\|empestar\|instalar\|partir\|resvalar\|retroceder\|alcançar\|relegar\|aventurar\|denunciar\|fugir\|antepor\|cooperar\|ligar\|sentir\|subordinar\|cingir\|faltar\|impelir\|misturar\|subordinar\|figurar\|)";#<string>
my $SubcatDE  = "(?:gostar\|falar\|tratar\|sair\|dar\|tirar\|acordar\|vir\|fazer\|saber\|passar\|entrar\|servir\|cambiar\|depender\|ocupar\|ir\|separar\|separar\|carecer\|dispor\|acusar\|afastar\|pensar\|encargar\|fugir\|aitrar\|convencer\|esquecer\|tirar\|preencher\|baixar\|levantar\|librar\|ligar\|despedir\|gozar\|retirar\|pender\|tomar\|duvidar\|informar\|provenir\|pensar\|rir\|escapar\|pegar\|encolher\|ficar\|queixar\|namorar\|vestir\|entender\|autorizar\|desprender\|desfrutar\|extrair\|surgir\|descer\|proceder\|nascer\|viver\|regressar\|trair\|receber\|arrancar\|alegrar\|brotar\|prescindir\|derivar\|volver\|descer\|defender\|retirar\|equivar\|necessitar\|esperar\|salvar\|preocupar\|partir\|aproveitar\|despojar\|participar\|mover\|distinguir\|deixar\|desaparecer\|presumir\|levar\|envergonhar\|liberar\|percatar\|cansar\|marchar\|saltar\|privar\|cair\|emergir\|cobrir\|fiar\|aprender\|abster\|apropriar\|cerciorar\|arrepender\|perder\|desconfiar\|herdar\|apagar\|custar\|desligar\|alimentar\|repor\|desviar\|distar\|prover\|resgatar\|subir\|abusar\|cuidar\|conhecer\|contar\|isolar\|chorar\|equivocar\|deduzir\|disfarçar\|distrair\|excluir\|avisar\|descolar\|dotar\|suspeitar\|apropriar\|apear\|armar\|ignorar\|diferenciar\|emanar\|preservar\|recolher\|agarrar\|desfazer\|extranhar\|persuadir\|constar\|valer\|assegurar\|cruzar\|desistir\|vingar\|pender\|diferir\|renegar\|resultar\|surprender\|proteger\|vaciar\|alardear\|cargar\|desembaraçar\|mudar\|expulsar\|elevar\|impregnar\|limpar\|bastar\|compor\|despertar\|absolver\|obter\|predicar\|matricular\|descargar\|extender\|assombrar\|escorrer\|apiadar\|assustar\|querer\|alçar\|arrojar\|comportar\|evadir\|protestar\|recuperar\|desvincular\|esconder\|examinar\|jactar\|redimir\|aborrecer\|adolecer\|escrever\|rodear\|disuadir\|começar\|fartar\|suspeitar\|seguir\|conversar\|trasladar\|exigir\|acompanhar\|curar\|beneficiar\|ser\|abster\|abusar\|acordar\|acusar\|apropriar\|isolar\|alegrar\|separar\|apiadar\|autorizar\|apropriar\|envergonhar\|evitar\|carecer\|cerciorar\|convencer\|depender\|derivar\|desconfiar\|desembaraçar\|ignorar\|despojar\|lançar\|diferenciar\|diferir\|disfarçar\|desfrutar\|duvidar\|namorar\|encargar\|encolher\|entrar\|extrair\|fiar\|gozar\|conversar\|escapar\|libertar\|livrar\|ocupar\|partir\|percatar\|prescindir\|presumir\|privar\|provenir\|sair\|separar\|tratar\|vestir\|)";#<string>
my $SubcatEM  = "(?:falar\|entrar\|pensar\|converter\|estar\|meter\|viver\|por\|encontrar\|ficar\|deixar\|sentar\|cair\|crer\|participar\|afixar\|tardar\|consistir\|passar\|insistir\|apoiar\|confiar\|nascer\|introduzir\|figurar\|residir\|transformar\|ir\|encerrar\|achar\|instalar\|permanecer\|reparar\|colocar\|situar\|afundar\|intervir\|atirar\|incluir\|refugir\|guardar\|empenhar\|sentir\|centrar\|esconder\|coincidir\|cravar\|concentrar\|sair\|esforçar\|conduzir\|basear\|despertar\|vir\|penetrar\|envolver\|caber\|mirar\|refletir\|ingressar\|viajar\|acenturar\|flutuar\|inscrver\|beijar\|depositar\|distinguir\|seguir\|manter\|influir\|sumergir\|tomar\|cifrar\|sumir\|golpear\|duvidar\|posar\|habitar\|girar\|reconhecer\|fundar\|montar\|escarafunchar\|incorrer\|interessar\|obstinar\|trabalhar\|inclinar\|matricular\|dividir\|veranear\|actuar\|manifestar\|tirar\|mediar\|ocupar\|oscilar\|colar\|empregar\|reinar\|trair\|acabar\|inverter\|incidir\|infiltrar\|internar\|acomodar\|colaborar\|interpor\|irromper\|integrar\|precipitar\|descansar\|fazer\|prender\|provocar\|encarnar\|plantar\|inspirar\|parar\|fundir\|assentar\|culminar\|cavber\|repercutir\|segurar\|molestar\|localizar\|expressar\|repartir\|concordar\|delegar\|admitir\|volver\|andar\|jazer\|comprazer\|citar\|mandar\|tender\|vacilar\|traduzir\|vaziar\|concretar\|ler\|tombar\|especializar\|gastar\|recriar\|virar\|teimar\|demorar\|inserir\|projetar\|afundar\|enredar\|fincar\|profundir\|degenerar\|trocar\|eleger\|implantar\|cagar\|esgaravatar\|agolpar\|distribuir\|establecer\|investigar\|reclinar\|redundar\|tirar\|servir\|abandonar\|constituir\|distinguir\|entreter\|estourar\|localizar\|resolver\|mergulhar\|causar\|equivocar\|iluminar\|estimar\|persistir\|sonhar\|recuar\|materializar\|sobrevivir\|reinstalar\|sepultar\|tocar\|transfigurar\|proteger\|imprimir\|induzir\|sustentar\|vegetar\|acodar\|descargar\|governar\|levar\|embalar\|albergar\|construir\|existir\|gravar\|fanar\|moderar\|reafirmar\|afirmar\|alojar\|pender\|cruzar\|derramar\|extender\|iniciar\|recair\|surgir\|acodar\|afundar\|apoiar\|assentar\|basear\|cair\|centrar\|colar\|comprazer\|concentrar\|confiar\|consistir\|converter\|desembocar\|dividir\|teimar\|empenhar\|encarnar\|encerrar\|entrar\|envolver\|esconder\|esforçar\|especializar\|afixar\|flutuar\|fundir\|remexer\|incidir\|incorrer\|infiltrar\|influir\|ingressar\|inscrever\|insistir\|instalar\|internar\|introduzir\|irromper\|materializar\|matricular\|meter\|nascer\|obstinar\|oscilar\|participar\|penetrar\|plantificar\|aprofundar\|irromper\|consistir\|inclinar\|recriar\|refugir\|reparar\|repercutir\|residir\|sentar\|situar\|sonhar\|sumergir\|sumir\|demorar\|transformar\|tombar\|veranear\|mergulhar\|)";#<string>
my $SubcatCOM  = "(?:conversar\|contar\|encontrar\|relacionar\|ter\|ficar\|casar\|acabar\|coincidir\|dar\|comparar\|bastar\|acostar\|identificar\|passar\|tratar\|sonhar\|viver\|lutar\|reunir\|compartilhar\|estar\|confundir\|encontrar\|poder\|cobrir\|enfrentar\|cruzar\|misturar\|romper\|tapar\|entrevistar\|sair\|conversar\|conformar\|concorrer\|conviver\|comentar\|contrastar\|ameaçar\|começar\|fazer\|cumprir\|seguir\|bater\|chocar\|lutar\|discutir\|andar\|comunicar\|carregar\|atentar\|unir\|guardar\|lançar\|encher\|vestir\|negociar\|enfadar\|combinar\|entender\|colaborar\|desfrutar\|estrelar\|falar\|fundir\|dançar\|continuar\|comentar\|encarar\|contactar\|reconciliar\|terminar\|despertar\|divertir\|dotar\|concluir\|meter\|revoltar\|conectar\|defender\|protestar\|volver\|arremeter\|suceder\|tocar\|competir\|alterar\|enlaçar\|golpear\|apoiar\|acordar\|sentir\|comprometer\|entusiasmar\|acompanhar\|comungar\|envolver\|acasalar\|dirigir\|vir\|mandar\|aborrecer\|substituir\|associar\|concordar\|consultar\|esfregar\|intercambiar\|alçar\|combinar\|corresponder\|permanecer\|enrolar\|atrever\|combater\|contentar\|insistir\|tirar\|simpatizar\|culminar\|complementar\|completar\|gozar\|associar\|atentar\|bastar\|coincidir\|colaborar\|comparar\|conectar\|conformar\|confundir\|conversar\|conviver\|encarar\|enlaçar\|entrevistar\|identificar\|misturar\|revelar\|conciliar\|relacionar\|sonhar\|bater\|encontrar\|)";#<string>
my $SubcatPOR  = "(?:passar\|entrar\|ir\|preguntar\|dar\|sair\|optar\|passear\|andar\|interessar\|lutar\|vir\|começar\|sentir\|preocupar\|cambiar\|substituir\|meter\|olhar\|subir\|esforçar\|seguir\|chorar\|agarrar\|pegar\|pôr\|tirar\|pugnar\|pagar\|guiar\|cair\|inclinar\|decidir\|viver\|caracterizar\|valer\|estender\|julgar\|advogar\|felicitar\|protestar\|lançar\|rezar\|deambular\|velar\|tomar\|assomar\|colar\|cruzar\|ficar\|estar\|vaguear\|volver\|circular\|apostar\|trepar\|percorrer\|multiplicar\|brindar\|escorrer\|arrojar\|atravessar\|trair\|substituir\|viajar\|temer\|pronunciar\|lutar\|rondar\|caber\|distinguir\|faltar\|sacar\|advogar\|brindar\|caracterizar\|vaguear\|lutar\|optar\|pugnar\|vagar\|velar\|)";#<string>
my $SubcatPARA  = "(?:voltar\|ir\|olhar\|dirigir\|avançar\|correr\|caminhar\|encaminhar\|sair\|atrair\|orientar\|sentir\|inclinar\|desviar\|vir\|empurrar\|tender\|andar\|assinalar\|lançar\|atirar\|levar\|arrastar\|deslocar\|partir\|levantar\|conduzir\|fugir\|apontar\|cruzar\|saltar\|encaminhar\|)";#<string>
my $SubcatSOBRE  = "(?:abalanzar\|)";#<string>
my $SubcatImpers  = "(?:ter\|fazer\|tratar\|bastar\|ser\|chover\|ir\|dar\|nevar\|cheirar\|anoitecer\|amanhecer\|parecer\|escurecer\|doer\|pôr\|)";#<string>
my $SubcatBitr  = "(?:dar\|fazer\|pedir\|pôr\|dizer\|perguntar\|oferecer\|atirar\|atribuir\|deixar\|retirar\|contar\|prestar\|dedicar\|contribuir\|dever\|explicar\|permitir\|levar\|ter\|devolver\|entregar\|exigir\|abrir\|dirigir\|passar\|impor\|enviar\|propor\|tirar\|dar\|presentar\|conceder\|adicionar\|negar\|trair\|outorgar\|recordar\|remeter\|custar\|dever\|ensinar\|assignar\|comunicar\|arrancar\|pagar\|render\|agregar\|ceder\|meter\|mandar\|tomar\|assegurar\|cerrar\|ver\|imprimir\|cortar\|encontrar\|chamar\|causar\|confessar\|mostrar\|restar\|comprar\|demonstrar\|ordenar\|tender\|roubar\|pegar\|proporcionar\|plantear\|solicitar\|agradecer\|escrever\|expor\|impedir\|produzir\|conferir\|arrebatar\|perder\|prometer\|facilitar\|evitar\|invejar\|indicar\|esconder\|avisar\|referir\|vender\|levantar\|advertir\|encarregar\|perdoar\|recomendar\|revelar\|buscar\|relatar\|reprovar\|)";#<string>
my $SubcatTr  = "(?:abandonar\|abarcar\|abonar\|abordar\|abrigar\|abrir\|apertar\|absorver\|acariciar\|acarretar\|habitar\|accionar\|espreitar\|acelerar\|acentuar\|aceitar\|esclarecer\|acolher\|acometer\|aconselhar\|acreditar\|acumular\|avançar\|adivinar\|administrar\|admirar\|admitir\|adoptar\|adorar\|adquirir\|advertir\|afiar\|afirmar\|aflouxar\|afrontar\|agitar\|agradecer\|agredir\|aguardar\|aguçar\|poupar\|alargar\|albergar\|alcançar\|alegar\|encorajar\|aligeirar\|alijar\|alisar\|aliviar\|alugar\|alterar\|alçar\|ampliar\|analisar\|ansiar\|anotar\|anular\|anunciar\|apaziguar\|apagar\|fingir\|aplacar\|esmagar\|adiar\|aplicar\|bater\|contribuir\|apreciar\|aprender\|apresar\|apertar\|aproveitar\|apunhalar\|argumentar\|armar\|arrancar\|arrasar\|arrastar\|arrebatar\|fixar\|arrogar\|articular\|assaltar\|assegurar\|assinar\|assimilar\|aspirar\|assumir\|atacar\|atalhar\|atrair\|apanhar\|atravessar\|atribuir\|aumentar\|autorizar\|aventurar\|descobrir\|avivar\|beijar\|varrer\|bater\|beber\|abençoar\|brandir\|bloquear\|beirar\|excluir\|buscar\|calar\|calcular\|calentar\|calçar\|captar\|carregar\|causar\|casar\|celebrar\|cingir\|cerrar\|citar\|cravar\|cobrar\|cozinhar\|pegar\|combinar\|cometer\|compartilhar\|compensar\|completar\|complicar\|compor\|comprar\|compreender\|comprovar\|comunicar\|conceber\|conceder\|condicionar\|confeccionar\|confessar\|confirmar\|conjeturar\|conhecer\|conquistar\|conseguir\|conservar\|considerar\|consolidar\|constatar\|constituir\|construir\|consultar\|consumar\|contar\|contemplar\|conter\|contrair\|contratar\|controlar\|convocar\|copiar\|coroar\|corroborar\|cortar\|custar\|criar\|crer\|criticar\|cruzar\|cobrir\|culminar\|cultivar\|cumplir\|cursar\|magoar\|dar\|decidir\|declarar\|decretar\|deduzir\|defender\|processar\|demonstrar\|denotar\|denunciar\|deplorar\|depositar\|derrubar\|derrotar\|desfazer\|desativar\|desatar\|superar\|desqualificar\|descarregar\|descartar\|descentralizar\|decifrar\|despendurar\|renegar\|recuar\|descrever\|descobrir\|desdenhar\|desejar\|descartar\|desempenhar\|desenterrar\|desfazer\|designar\|negar\|ignorar\|terminar\|decolar\|desocupar\|desperdiçar\|desdobrar\|desprezar\|destacar\|destapar\|desterrar\|destroçar\|destruir\|revelar\|desviar\|detectar\|determinar\|detestar\|devolver\|devorar\|desenhar\|ditar\|difundir\|elucidar\|dirimir\|esconder\|dissipar\|dissolver\|disputar\|distinguir\|divisar\|dobrar\|dominar\|durar\|tirar\|efectuar\|executar\|exercer\|elaborar\|escolher\|elevar\|eliminar\|louvar\|evitar\|embarcar\|emitir\|empregar\|empreender\|empurrar\|empunhar\|arvorar\|encarecer\|encarnar\|canalizar\|acender\|encontrar\|encobrir\|endireitar\|enfileirar\|focar\|enxugar\|enriquecer\|ensinar\|entabular\|entoar\|entorpecer\|transportar\|entreabrir\|entregar\|entrever\|enumerar\|enviar\|erradicar\|esboçar\|escalar\|escamotear\|esclarecer\|escolher\|escrever\|escrutinar\|escutar\|esgrimir\|espantar\|esperar\|esquivar\|estabelecer\|estimar\|estimular\|estipular\|estirar\|estreitar\|estrear\|estragar\|estudar\|avaliar\|evitar\|evocar\|exaltar\|examinar\|excluir\|excusar\|exibir\|exigir\|expelir\|experimentar\|explicar\|explorar\|expressar\|extender\|fabricar\|facilitar\|favorecer\|financiar\|fingir\|firmar\|promover\|forjar\|formar\|formular\|fortalecer\|forçar\|franquear\|esfregar\|franzir\|fumar\|fundar\|fundir\|ganhar\|garantir\|gastar\|generar\|gerir\|golpear\|guardar\|habitar\|fazer\|folhear\|humedecer\|ignorar\|iluminar\|ilustrar\|imaginar\|imitar\|transmitir\|impedir\|implantar\|implicar\|impor\|imprimir\|improvisar\|impulsar\|inaugurar\|incendiar\|incluir\|iniciar\|aumentar\|investigar\|indicar\|inferir\|infundir\|ingerir\|iniciar\|insinuar\|inspeccionar\|inspirar\|tentar\|intercambiar\|interpretar\|intuir\|invadir\|inventar\|investir\|investigar\|invocar\|envolver\|puxar\|juntar\|jurar\|justificar\|julgar\|inclinar\|lamentar\|lamber\|lançar\|lavar\|ler\|amarrar\|limar\|limpar\|liquidar\|preencher\|levar\|localizar\|conseguir\|brilhar\|maldizer\|mandar\|manejar\|manifestar\|manter\|marcar\|mascar\|mastigar\|matizar\|medir\|melhorar\|mencionar\|mentar\|merecer\|minar\|modernizar\|modificar\|morder\|mostrar\|motivar\|narrar\|necessitar\|negociar\|neutralizar\|nomear\|notar\|nublar\|observar\|obter\|ocultar\|odiar\|oferecer\|ouvir\|esquecer\|achar\|oprimir\|ordenar\|organizar\|observar\|outorgar\|sofrer\|pagar\|saborear\|aplaudir\|palpar\|pedir\|pegar\|pensar\|perceber\|perder\|perfeiçoar\|permitir\|persuadir\|pesar\|picar\|pintar\|pisar\|calcar\|passar\|planear\|plantar\|plantear\|pesar\|pôr\|possuir\|postergar\|postular\|praticar\|precisar\|predizer\|preferir\|perguntar\|prender\|preparar\|presenciar\|pressentir\|preservar\|presidir\|pressionar\|prestar\|pretender\|prever\|provar\|proclamar\|procurar\|proferir\|professar\|proibir\|prolongar\|prometer\|promover\|promover\|pronunciar\|propagar\|propiciar\|propinar\|propor\|proporcionar\|defender\|prosseguir\|provocar\|publicar\|pulsar\|quebrar\|queimar\|querer\|quitar\|coçar\|rasgar\|rastrear\|ratificar\|raciocinar\|realizar\|reiniciar\|baixar\|ultrapassar\|recolher\|prescrever\|rejeitar\|receber\|reclamar\|recuperar\|colectar\|recomendar\|reestabelecer\|reconhecer\|reconsiderar\|reconstruir\|recordar\|recorrer\|recortar\|recuperar\|escrever\|redobrar\|reduzir\|reflexar\|reformar\|reforçar\|oferecer\|registrar\|regular\|evitar\|reiterar\|reivindicar\|relatar\|reler\|rematar\|rememorar\|remover\|renovar\|repartir\|repassar\|repetir\|repor\|representar\|reprimir\|reprovar\|reprovar\|reproduzir\|requerer\|ressaltar\|resgatar\|reservar\|resolver\|respeitar\|reestabelecer\|restar\|restaurar\|esfregar\|resumir\|retomar\|atrasar\|revelar\|revisar\|reviver\|roubar\|rodear\|rogar\|romper\|roçar\|ruminar\|saber\|saborear\|tirar\|sacrificar\|sacudir\|salvaguardar\|salvar\|satisfazer\|apoiar\|seguir\|seleccionar\|semear\|assinalar\|serrar\|servir\|significar\|simular\|solicitar\|solucionar\|sonhar\|suportar\|sorver\|sortear\|suspeitar\|segurar\|sublinhar\|sofrer\|sugerir\|sujeitar\|fornecer\|superar\|suplantar\|supor\|suprimir\|suscitar\|suspender\|sustentar\|substituir\|tapar\|trautear\|temer\|ter\|tentar\|terminar\|tocar\|tolerar\|tomar\|torcer\|trair\|tragar\|transmitir\|transportar\|transferir\|traçar\|usar\|utilizar\|esvaziar\|valer\|avaliar\|velar\|vencer\|vender\|ver\|verificar\|visitar\|vislumbrar\|voltar\|vomitar\|comer\|abrir\|)";#<string>
my $SubcatAtr  = "(?:acabar\|actuar\|amanhecer\|andar\|apetecer\|aparecer\|cair\|considerar\|continuar\|custar\|crer\|dar\|declarar\|definir\|deixar\|exercer\|encontrar\|erigir\|estar\|fazer\|encontrar\|imaginar\|ingressar\|ir\|chamar\|levar\|manifestar\|manter\|meter\|mostrar\|nascer\|parecer\|passar\|permanecer\|pôr\|prosseguir\|ficar\|resultar\|revelar\|saber\|sair\|seguir\|sentir\|ser\|sonhar\|ter\|terminar\|tirar\|titular\|tornar\|trabalhar\|transcorrer\|vir\|ver\|viver\|volver\|jazer\|)";#<string>
my $SubcatODirAtr  = "(?:ter\|deixar\|fazer\|ver\|pôr\|chamar\|considerar\|levar\|manter\|sentir\|tomar\|ouvir\|qualificar\|encontrar\|crer\|dar\|imaginar\|trair\|estimar\|passar\|entender\|volver\|julgar\|definir\|conceber\|utilizar\|declarar\|olhar\|colocar\|escutar\|encontrar\|denominar\|conhecer\|conservar\|reconhecer\|rasurar\|identificar\|tratar\|aceitar\|pegar\|)";#<string>
my $SubcatClaus  = "(?:saber\|crer\|querer\|dizer\|pensar\|ver\|perguntar\|tentar\|recordar\|permitir\|conseguir\|decidir\|desejar\|pretender\|fazer\|assegurar\|esperar\|pedir\|explicar\|compreender\|conseguir\|preferir\|necessitar\|supor\|sentir\|afirmar\|considerar\|ter\|entender\|impedir\|contar\|procurar\|reconhecer\|temer\|advertir\|assinalar\|deixar\|ouvir\|indicar\|propor\|comprovar\|descobrir\|imaginar\|declarar\|confessar\|demonstrar\|adicionar\|jurar\|admitir\|prometer\|significar\|anunciar\|suspeitar\|evitar\|aceitar\|mirar\|fingir\|observar\|contestar\|notar\|esquecer\|mostrar\|manifestar\|negar\|comentar\|mandar\|suster\|encontrar\|responder\|ordenar\|estimar\|precisar\|ignorar\|exigir\|achar\|rogar\|sonhar\|lamentar\|merecer\|dar\|agregar\|confirmar\|averiguar\|ensinar\|adivinhar\|esclarecer\|aconselhar\|comunicar\|sugerir\|prever\|sublinhar\|repetir\|conhecer\|deduzir\|destacar\|intuir\|informar\|revelar\|figurar\|gritar\|perdoar\|pôr\|resolver\|experimentar\|avisar\|proibir\|recomendar\|durar\|agradecer\|determinar\|apontar\|criticar\|acordar\|calcular\|solicitar\|julgar\|reiterar\|reprovar\|simular\|estudar\|replicar\|tolerar\|insinuar\|oferecer\|argumentar\|ostentar\|estabelecer\|perceber\|verificar\|buscar\|pressentir\|referir\|escrever\|aproveitar\|alegar\|ler\|ameaçar\|denunciar\|garantir\|desconhecer\|escutar\|implicar\|justificar\|odiar\|repor\|consentir\|reclamar\|dignar\|falar\|conceber\|servir\|apreciar\|adiantar\|contemplar\|eleger\|excluir\|reflexionar\|suplicar\|presumir\|precisar\|evitar\|dispor\|recusar\|notificar\|exibir\|requerer\|concluir\|estipular\|)";#<string>


####################################END CODE BY COMPI################################################


my $i=0;#<integer>
my $listTags="";#<string>
my $seq="";#<string>
my $info;#<string>

my @Token=();#<list><string>
my @Tag=();#<list><string>
my @Lemma=();#<list><string>
my @Attributes=();#<list><string>
my @ATTR=();#<list><map><string>
my %ATTR_lemma=();#<map><string>
my %TagStr=();#<map><integer>
my %IDF=();#<map><string>
my %Ordenar=();#<map><integer>

sub parse{
	my $lines = $_[0];#<ref><list><string>
	my @saida=();#<list><string>

	## -a por defeito
	my $flag = "-a"; #<string>

	##flag -a=analisador -c=corrector
	if(@_>1 && $_[1]){
		$flag = $_[1];
	}

	my $j=0;#<integer>
	foreach my $line (@{$lines}) {
		chop($line);

		(my $token, $info) = split(" ", $line);#<string>

		###Convertimos caracteres significativos na sintaxe de DepPattern em tags especiais
		if ($token =~ /:/) {
			ConvertChar ('\:', "Fd");
		}
		if ($token =~ /\|/) {
			ConvertChar ('\|', "Fz");
		}
		if ($token =~ /\>/) {
			ConvertChar ('\>', "Fz1");
		}
		if ($token =~ /\</) {
			ConvertChar ('\<', "Fz2");
		}

		my %Exp=();#<map><string>

		##organizamos a informacao de cada token:
		if ($info ne "") {
			my @info = split ('\|', $info);#<array><string>
			for ($i=0;$i<=$#info;$i++) {
				if ($info[$i] ne "") {
					my($attrib, $value) = split (':', $info[$i]);#<string>
					$Exp{$attrib} = $value ;
				}
			}
		}

		##construimos os vectores da oracao
		if ($Exp{"tag"} ne $Border) {
			$Token[$j] = $token ;
			if ($info ne "") {
				$Lemma[$j] = $Exp{"lemma"};
				$Tag[$j] = $Exp{"tag"} ;
				$Attributes[$j] = "";
				foreach my $at (sort keys %Exp) {
					if ($at ne "tag"){
						$Attributes[$j] .= "$at:$Exp{$at}|"; 
						$ATTR[$j] = {} if (!defined $ATTR[$j]);
						$ATTR[$j]{$at} = $Exp{$at} ;
					}
				}
			}
			$j++;
			#print STDERR "$j\r";
		} elsif ($Exp{"tag"} eq $Border) {
			$Token[$j] = $token;
			$Lemma[$j] = $Exp{"lemma"};
			$Tag[$j] = $Exp{"tag"} ;
			$Attributes[$j] = "";
			foreach my $at (sort keys %Exp) {
				if ($at ne "tag"){
					$Attributes[$j] .= "$at:$Exp{$at}|";
					$ATTR[$j] = {} if (!defined $ATTR[$j]);
					$ATTR[$j]{$at} = $Exp{$at};
				}
			}

			##construimos os strings com a lista de tags-atributos e os token-tags da oraçao
			for ($i=0;$i<=$#Token;$i++) {
				ReConvertChar ('\:', "Fd", $i);
				ReConvertChar ('\|', "Fz", $i);
				ReConvertChar ('\>', "Fz1", $i);
				ReConvertChar ('\<', "Fz2", $i);

				$listTags .= "$Tag[$i]_${i}_<$Attributes[$i]>";
				$seq .= "$Token[$i]_$Tag[$i]_${i}_<$Attributes[$i]>" . " ";

			}##fim do for

			my $STOP=0;#<boolean>
			#$iteration=0;
			while (!$STOP) {
				my $ListInit = $listTags;#<string>
				#$iteration++;
				#print STDERR "$iteration\n";

				my @temp;#<array><string>
				my $Rel;#<string>
###########################BEGIN GRAMMAR#############################################
				{#<function>
					# Single: VERB
					# Add: nomin:no
					@temp = ($listTags =~ /($VERB$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)/$1/g;
					Add("Head","nomin:no",\@temp);

					# Single: [NOUN] [Fc]? CONJ<lemma:que> [NOUN] [VERB]
					# Corr: tag:PRO, type:R
					@temp = ($listTags =~ /(?:$NOUN$a2)(?:$Fc$a2)?($CONJ${l}lemma:que\|${r})(?:$NOUN$a2)(?:$VERB$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)?($CONJ${l}lemma:que\|${r})($NOUN$a2)($VERB$a2)/$1$2$3$4$5/g;
					Corr("Head","tag:PRO,type:R",\@temp);

					# Single: [X]? NOUN<lemma:$AdvTemp>
					# Corr: tag:ADV
					@temp = ($listTags =~ /(?:$X$a2)?($NOUN${l}lemma:$AdvTemp\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($X$a2)?($NOUN${l}lemma:$AdvTemp\|${r})/$1$2/g;
					Corr("Head","tag:ADV",\@temp);

					# Single: VERB<lemma:determinar|dar&mode:P> [NOUN<type:C>]
					# Corr: tag:ADJ
					@temp = ($listTags =~ /($VERB${l}lemma:(?:determinar|dar)\|${b2}mode:P\|${r})(?:$NOUN${l}type:C\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:determinar|dar)\|${b2}mode:P\|${r})($NOUN${l}type:C\|${r})/$1$2/g;
					Corr("Head","tag:ADJ",\@temp);

					# Single: VERB<token:[Ff]ui|[Ff]oi|[Ff]omos|[Ff]oram|[Ff]oste|[Ff]osse|[Ff]ossem> [X<token:a>] [NOUN<type:P>]
					# Corr: lemma:ir
					@temp = ($listTags =~ /($VERB${l}token:(?:[Ff]ui|[Ff]oi|[Ff]omos|[Ff]oram|[Ff]oste|[Ff]osse|[Ff]ossem)\|${r})(?:$X${l}token:a\|${r})(?:$NOUN${l}type:P\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}token:(?:[Ff]ui|[Ff]oi|[Ff]omos|[Ff]oram|[Ff]oste|[Ff]osse|[Ff]ossem)\|${r})($X${l}token:a\|${r})($NOUN${l}type:P\|${r})/$1$2$3/g;
					Corr("Head","lemma:ir",\@temp);

					# Single: VERB<token:[Ff]ui|[Ff]oi|[Ff]omos|[Ff]oram|[Ff]oste|[Ff]osse|[Ff]ossem> [PRP<lemma:a>]
					# Corr: lemma:ir
					@temp = ($listTags =~ /($VERB${l}token:(?:[Ff]ui|[Ff]oi|[Ff]omos|[Ff]oram|[Ff]oste|[Ff]osse|[Ff]ossem)\|${r})(?:$PRP${l}lemma:a\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}token:(?:[Ff]ui|[Ff]oi|[Ff]omos|[Ff]oram|[Ff]oste|[Ff]osse|[Ff]ossem)\|${r})($PRP${l}lemma:a\|${r})/$1$2/g;
					Corr("Head","lemma:ir",\@temp);

					# Single: VERB<token:[Ff]ui|[Ff]oi|[Ff]omos|[Ff]oram|[Ff]oste|[Ff]osse|[Ff]ossem> [PRO<lemma:se>]
					# Corr: lemma:ir
					@temp = ($listTags =~ /($VERB${l}token:(?:[Ff]ui|[Ff]oi|[Ff]omos|[Ff]oram|[Ff]oste|[Ff]osse|[Ff]ossem)\|${r})(?:$PRO${l}lemma:se\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}token:(?:[Ff]ui|[Ff]oi|[Ff]omos|[Ff]oram|[Ff]oste|[Ff]osse|[Ff]ossem)\|${r})($PRO${l}lemma:se\|${r})/$1$2/g;
					Corr("Head","lemma:ir",\@temp);

					# Single: X<token:–> [X]
					# Corr: tag:Fe
					@temp = ($listTags =~ /($X${l}token:–\|${r})(?:$X$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($X${l}token:–\|${r})($X$a2)/$1$2/g;
					Corr("Head","tag:Fe",\@temp);

					# Single: [X<lemma:este>] X<lemma:segunda-feira|terça-feira|quarta-feira|quinta-feira|sexta-feira|sábado|domingo>
					# Corr: tag:DATE
					@temp = ($listTags =~ /(?:$X${l}lemma:este\|${r})($X${l}lemma:(?:segunda-feira|terça-feira|quarta-feira|quinta-feira|sexta-feira|sábado|domingo)\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($X${l}lemma:este\|${r})($X${l}lemma:(?:segunda-feira|terça-feira|quarta-feira|quinta-feira|sexta-feira|sábado|domingo)\|${r})/$1$2/g;
					Corr("Head","tag:DATE",\@temp);

					# Single: [VERB|NOUN] ADV<lemma:como>|PRO<lemma:como>
					# Corr: tag:CONJ
					# PunctR: X Fz|Fe|Frc
					@temp = ($listTags =~ /(?:$VERB$a2|$NOUN$a2)($ADV${l}lemma:como\|${r}|$PRO${l}lemma:como\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$NOUN$a2)($ADV${l}lemma:como\|${r}|$PRO${l}lemma:como\|${r})/$1$2/g;
					Corr("Head","tag:CONJ",\@temp);

					# PunctL: Fz|Fe|Fra X
					@temp = ($listTags =~ /($Fz$a2|$Fe$a2|$Fra$a2)($X$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fz$a2|$Fe$a2|$Fra$a2)($X$a2)/$2/g;

					# >: VERB<lemma:tener|ter|haber|haver|take|have> NOUN<number:S> [PRP]
					@temp = ($listTags =~ /($VERB${l}lemma:(?:tener|ter|haber|haver|take|have)\|${r})($NOUN${l}number:S\|${r})(?:$PRP$a2)/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:tener|ter|haber|haver|take|have)\|${r})($NOUN${l}number:S\|${r})($PRP$a2)/$1$3/g;
					LEX();

					# >: VERB<lemma:be|ser> ADJ [PRP]
					@temp = ($listTags =~ /($VERB${l}lemma:(?:be|ser)\|${r})($ADJ$a2)(?:$PRP$a2)/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:be|ser)\|${r})($ADJ$a2)($PRP$a2)/$1$3/g;
					LEX();

					# <: [VERB<lemma:ser|tornar|converter|be|become>] ADV<lemma:$Quant> ADJ [CONJ|PRO<lemma:que|como>]
					# NEXT
					# >: VERB<lemma:ser|tornar|converter|be|become> [ADV<lemma:$Quant>] ADJ [CONJ|PRO<lemma:que|como>]
					# NEXT
					# >: VERB<lemma:ser|tornar|converter|be|become>  [ADV<lemma:$Quant>] [ADJ] CONJ|PRO<lemma:que|como>
					@temp = ($listTags =~ /(?:$VERB${l}lemma:(?:ser|tornar|converter|be|become)\|${r})($ADV${l}lemma:$Quant\|${r})($ADJ$a2)(?:$CONJ$a2|$PRO${l}lemma:(?:que|como)\|${r})/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}lemma:(?:ser|tornar|converter|be|become)\|${r})(?:$ADV${l}lemma:$Quant\|${r})($ADJ$a2)(?:$CONJ$a2|$PRO${l}lemma:(?:que|como)\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}lemma:(?:ser|tornar|converter|be|become)\|${r})(?:$ADV${l}lemma:$Quant\|${r})(?:$ADJ$a2)($CONJ$a2|$PRO${l}lemma:(?:que|como)\|${r})/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:ser|tornar|converter|be|become)\|${r})($ADV${l}lemma:$Quant\|${r})($ADJ$a2)($CONJ$a2|$PRO${l}lemma:(?:que|como)\|${r})/$1/g;
					LEX();

					# <: ADV<lemma:antes|depois> PRP<lemma:de> [ADV<lemma:ontem|amanhã>]
					# NEXT
					# <: [ADV<lemma:antes|depois>] PRP<lemma:de> ADV<lemma:ontem|amanhã>
					@temp = ($listTags =~ /($ADV${l}lemma:(?:antes|depois)\|${r})($PRP${l}lemma:de\|${r})(?:$ADV${l}lemma:(?:ontem|amanhã)\|${r})/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV${l}lemma:(?:antes|depois)\|${r})($PRP${l}lemma:de\|${r})($ADV${l}lemma:(?:ontem|amanhã)\|${r})/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}lemma:(?:antes|depois)\|${r})($PRP${l}lemma:de\|${r})($ADV${l}lemma:(?:ontem|amanhã)\|${r})/$3/g;
					LEX();

					# <: X<token:[Aa]> X<lemma:partir> [PRP<lemma:de>]
					# NEXT
					# <: [X<token:[Aa]>] X<lemma:partir> PRP<lemma:de>
					@temp = ($listTags =~ /($X${l}token:[Aa]\|${r})($X${l}lemma:partir\|${r})(?:$PRP${l}lemma:de\|${r})/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$X${l}token:[Aa]\|${r})($X${l}lemma:partir\|${r})($PRP${l}lemma:de\|${r})/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					$listTags =~ s/($X${l}token:[Aa]\|${r})($X${l}lemma:partir\|${r})($PRP${l}lemma:de\|${r})/$3/g;
					LEX();

					# <: PRP<lemma:de> X<lemma:manhã|tarde|noite>
					# Add: tag:ADV
					@temp = ($listTags =~ /($PRP${l}lemma:de\|${r})($X${l}lemma:(?:manhã|tarde|noite)\|${r})/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					$listTags =~ s/($PRP${l}lemma:de\|${r})($X${l}lemma:(?:manhã|tarde|noite)\|${r})/$2/g;
					LEX();
					Add("DepHead_lex","tag:ADV",\@temp);

					# <: X<lemma:momento|minuto|segundo|hora|dia|mês|ano|semana|século> X<lemma:antes|depois>
					# Add: tag:DATE
					@temp = ($listTags =~ /($X${l}lemma:(?:momento|minuto|segundo|hora|dia|mês|ano|semana|século)\|${r})($X${l}lemma:(?:antes|depois)\|${r})/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					$listTags =~ s/($X${l}lemma:(?:momento|minuto|segundo|hora|dia|mês|ano|semana|século)\|${r})($X${l}lemma:(?:antes|depois)\|${r})/$2/g;
					LEX();
					Add("DepHead_lex","tag:DATE",\@temp);

					# >: X<lemma:segunda-feira|terça-feira|quarta-feira|quinta-feira|sexta-feira|sábado|domingo> Fc [DATE]
					# NEXT
					# <: X<lemma:segunda-feira|terça-feira|quarta-feira|quinta-feira|sexta-feira|sábado|domingo> [Fc]? DATE
					@temp = ($listTags =~ /($X${l}lemma:(?:segunda-feira|terça-feira|quarta-feira|quinta-feira|sexta-feira|sábado|domingo)\|${r})($Fc$a2)(?:$DATE$a2)/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					@temp = ($listTags =~ /($X${l}lemma:(?:segunda-feira|terça-feira|quarta-feira|quinta-feira|sexta-feira|sábado|domingo)\|${r})(?:$Fc$a2)?($DATE$a2)/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					$listTags =~ s/($X${l}lemma:(?:segunda-feira|terça-feira|quarta-feira|quinta-feira|sexta-feira|sábado|domingo)\|${r})($Fc$a2)?($DATE$a2)/$3/g;
					LEX();

					# CoordL: ADV [Fc] [ADV] CONJ<(type:C)|(lemma:$CCord)> [ADV]
					# NEXT
					# PunctL: [ADV] Fc [ADV] CONJ<(type:C)|(lemma:$CCord)> [ADV]
					# Recursivity: 10
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADV$a2)(?:$Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADV$a2)($Fc$a2)(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2)($Fc$a2)($ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a2)/$3$4$5/g;

					# CoordL: [Fc]? ADV CONJ<(type:C)|(lemma:$CCord)> [ADV]
					# NEXT
					# CoordR: [Fc]? [ADV] CONJ<(type:C)|(lemma:$CCord)> ADV
					# Add: coord:adv
					@temp = ($listTags =~ /(?:$Fc$a2)?($ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($ADV$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a2)/$1$3/g;
					Add("HeadDep","coord:adv",\@temp);

					# PunctL: Fc CONJ<coord:adv>
					@temp = ($listTags =~ /($Fc$a2)($CONJ${l}coord:adv\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($CONJ${l}coord:adv\|${r})/$2/g;

					# AdjnL: ADV<lemma:$Quant> ADV|ADJ
					@temp = ($listTags =~ /($ADV${l}lemma:$Quant\|${r})($ADV$a2|$ADJ$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}lemma:$Quant\|${r})($ADV$a2|$ADJ$a2)/$2/g;

					# AdjnL: ADV<lemma:[Mm]ais\@de> [DET]? CARD|NOUN
					@temp = ($listTags =~ /($ADV${l}lemma:[Mm]ais\@de\|${r})(?:$DET$a2)?($CARD$a2|$NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}lemma:[Mm]ais\@de\|${r})($DET$a2)?($CARD$a2|$NOUN$a2)/$2$3/g;

					# PunctL: [ADJ] Fc ADJ [NOUN]
					# NEXT
					# AdjnL: ADJ [Fc] ADJ [NOUN]
					# Recursivity: 5
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($NOUN$a2)/$3$4/g;
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($NOUN$a2)/$3$4/g;
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($NOUN$a2)/$3$4/g;
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($NOUN$a2)/$3$4/g;
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($NOUN$a2)/$3$4/g;
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)($ADJ$a2)(?:$NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($NOUN$a2)/$3$4/g;

					# CoordL: ADJ [Fc] [ADJ] CONJ<(type:C)|(lemma:$CCord)> [ADJ]
					# NEXT
					# PunctL: [ADJ] Fc [ADJ] CONJ<(type:C)|(lemma:$CCord)> [ADJ]
					# Recursivity: 10
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a2)/$3$4$5/g;
					@temp = ($listTags =~ /($ADJ$a2)(?:$Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$ADJ$a2)($Fc$a2)(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2)($Fc$a2)($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a2)/$3$4$5/g;

					# CoordL: [Fc]? ADJ CONJ<(type:C)|(lemma:$CCord)> [ADJ]
					# NEXT
					# CoordR: [Fc]? [ADJ] CONJ<(type:C)|(lemma:$CCord)> ADJ
					# Add: coord:adj
					# Inherit: gender, number
					@temp = ($listTags =~ /(?:$Fc$a2)?($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($ADJ$a2)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a2)/$1$3/g;
					Inherit("HeadDep","gender,number",\@temp);
					Add("HeadDep","coord:adj",\@temp);

					# PunctL: Fc CONJ<coord:adj>
					@temp = ($listTags =~ /($Fc$a2)($CONJ${l}coord:adj\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($CONJ${l}coord:adj\|${r})/$2/g;

					# AdjnL: ADJ|CONJ<coord:adj>|CARD [ADV]? NOUN
					# Agreement: gender, number
					# Recursivity: 1
					@temp = ($listTags =~ /($ADJ$a2|$CONJ${l}coord:adj\|${r}|$CARD$a2)(?:$ADV$a2)?($NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"gender,number",\@temp);
					$listTags =~ s/($ADJ${l}concord:1${r}|$CONJ${l}concord:1${b2}coord:adj\|${r}|$CARD${l}concord:1${r})($ADV$a2)?($NOUN${l}concord:1${r})/$2$3/g;
					$listTags =~ s/concord:[01]\|//g;
					@temp = ($listTags =~ /($ADJ$a2|$CONJ${l}coord:adj\|${r}|$CARD$a2)(?:$ADV$a2)?($NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"gender,number",\@temp);
					$listTags =~ s/($ADJ${l}concord:1${r}|$CONJ${l}concord:1${b2}coord:adj\|${r}|$CARD${l}concord:1${r})($ADV$a2)?($NOUN${l}concord:1${r})/$2$3/g;
					$listTags =~ s/concord:[01]\|//g;

					# AdjnR: NOUN [ADV]? ADJ|CONJ<coord:adj>
					# Agreement: gender, number
					# Recursivity: 1
					@temp = ($listTags =~ /($NOUN$a2)(?:$ADV$a2)?($ADJ$a2|$CONJ${l}coord:adj\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"gender,number",\@temp);
					$listTags =~ s/($NOUN${l}concord:1${r})($ADV$a2)?($ADJ${l}concord:1${r}|$CONJ${l}concord:1${b2}coord:adj\|${r})/$1$2/g;
					$listTags =~ s/concord:[01]\|//g;
					@temp = ($listTags =~ /($NOUN$a2)(?:$ADV$a2)?($ADJ$a2|$CONJ${l}coord:adj\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"gender,number",\@temp);
					$listTags =~ s/($NOUN${l}concord:1${r})($ADV$a2)?($ADJ${l}concord:1${r}|$CONJ${l}concord:1${b2}coord:adj\|${r})/$1$2/g;
					$listTags =~ s/concord:[01]\|//g;

					# AdjnR: NOUN  ADJ|CONJ<coord:adj>
					# Agreement: gender, number
					@temp = ($listTags =~ /($NOUN$a2)($ADJ$a2|$CONJ${l}coord:adj\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"gender,number",\@temp);
					$listTags =~ s/($NOUN${l}concord:1${r})($ADJ${l}concord:1${r}|$CONJ${l}concord:1${b2}coord:adj\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;

					# AdjnR:  NOUN NOUN
					# Recursivity: 1
					@temp = ($listTags =~ /($NOUN$a2)($NOUN$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($NOUN$a2)/$1/g;
					@temp = ($listTags =~ /($NOUN$a2)($NOUN$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($NOUN$a2)/$1/g;

					# AdjnL: CARD NOUN
					@temp = ($listTags =~ /($CARD$a2)($NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($CARD$a2)($NOUN$a2)/$2/g;

					# Single: [DET] ADJ [PRP]
					# Corr: tag:NOUN
					@temp = ($listTags =~ /(?:$DET$a2)($ADJ$a2)(?:$PRP$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($ADJ$a2)($PRP$a2)/$1$2$3/g;
					Corr("Head","tag:NOUN",\@temp);

					# SpecL: DET DET|PRO<type:X> [NOUN]
					# NEXT
					# SpecL: [DET] DET|PRO<type:X> NOUN
					@temp = ($listTags =~ /($DET$a2)($DET$a2|$PRO${l}type:X\|${r})(?:$NOUN$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$DET$a2)($DET$a2|$PRO${l}type:X\|${r})($NOUN$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($DET$a2|$PRO${l}type:X\|${r})($NOUN$a2)/$3/g;

					# SpecL: DET<type:I> DET<type:A> [PRO<type:R>]
					@temp = ($listTags =~ /($DET${l}type:I\|${r})($DET${l}type:A\|${r})(?:$PRO${l}type:R\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET${l}type:I\|${r})($DET${l}type:A\|${r})($PRO${l}type:R\|${r})/$2$3/g;

					# AdjnL: [DET] VERB<mode:P> NOUN
					# NEXT
					# SpecL: DET [VERB<mode:P>] NOUN
					@temp = ($listTags =~ /(?:$DET$a2)($VERB${l}mode:P\|${r})($NOUN$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($DET$a2)(?:$VERB${l}mode:P\|${r})($NOUN$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($VERB${l}mode:P\|${r})($NOUN$a2)/$3/g;

					# SpecL: DET CARD|DATE
					@temp = ($listTags =~ /($DET$a2)($CARD$a2|$DATE$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($CARD$a2|$DATE$a2)/$2/g;

					# SpecL: DET NOUN
					@temp = ($listTags =~ /($DET$a2)($NOUN$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET$a2)($NOUN$a2)/$2/g;

					# SpecL: DET<type:A> PRO<type:X>
					@temp = ($listTags =~ /($DET${l}type:A\|${r})($PRO${l}type:X\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET${l}type:A\|${r})($PRO${l}type:X\|${r})/$2/g;

					# SpecL: DET<type:[AD]>|PRO<type:D> PRO<type:[RW]>
					# Add: sust:yes
					# Inherit: number, person
					@temp = ($listTags =~ /($DET${l}type:[AD]\|${r}|$PRO${l}type:D\|${r})($PRO${l}type:[RW]\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET${l}type:[AD]\|${r}|$PRO${l}type:D\|${r})($PRO${l}type:[RW]\|${r})/$2/g;
					Inherit("DepHead","number,person",\@temp);
					Add("DepHead","sust:yes",\@temp);

					# Single: [PRP] PRO<sust:yes>
					# Add: sust:no
					@temp = ($listTags =~ /(?:$PRP$a2)($PRO${l}sust:yes\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($PRO${l}sust:yes\|${r})/$1$2/g;
					Add("Head","sust:no",\@temp);

					# SpecL: DET<type:[AD]>|PRO<type:D> PRP<lemma:de> [NOUNSINGLE|PRO<type:D|P|I|X>]
					# Add: nomin:yes
					# Inherit: number, person
					@temp = ($listTags =~ /($DET${l}type:[AD]\|${r}|$PRO${l}type:D\|${r})($PRP${l}lemma:de\|${r})(?:$NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($DET${l}type:[AD]\|${r}|$PRO${l}type:D\|${r})($PRP${l}lemma:de\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$2$3/g;
					Inherit("DepHead","number,person",\@temp);
					Add("DepHead","nomin:yes",\@temp);

					# ClitL: PRO<lemma:se> VERB
					# Add: se:yes
					# Uniq
					@temp = ($listTags =~ /($PRO${l}lemma:se\|${r})($VERB$a2)/g);
					$Rel =  "ClitL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}lemma:se\|${r})($VERB$a2)/$2/g;
					Add("DepHead","se:yes",\@temp);

					# ClitR: VERB PRO<lemma:se>
					# Add: se:yes
					# Uniq
					@temp = ($listTags =~ /($VERB$a2)($PRO${l}lemma:se\|${r})/g);
					$Rel =  "ClitR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRO${l}lemma:se\|${r})/$1/g;
					Add("HeadDep","se:yes",\@temp);

					# ClitL: PRO<token:$cliticoind> VERB
					# Add: ind:yes
					# Uniq
					@temp = ($listTags =~ /($PRO${l}token:$cliticoind\|${r})($VERB$a2)/g);
					$Rel =  "ClitL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}token:$cliticoind\|${r})($VERB$a2)/$2/g;
					Add("DepHead","ind:yes",\@temp);

					# ClitR: VERB PRO<token:$cliticoind>
					# Add: ind:yes
					# Uniq
					@temp = ($listTags =~ /($VERB$a2)($PRO${l}token:$cliticoind\|${r})/g);
					$Rel =  "ClitR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRO${l}token:$cliticoind\|${r})/$1/g;
					Add("HeadDep","ind:yes",\@temp);

					# ClitL: PRO<token:$cliticopers> VERB
					# Recursivity: 1
					@temp = ($listTags =~ /($PRO${l}token:$cliticopers\|${r})($VERB$a2)/g);
					$Rel =  "ClitL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}token:$cliticopers\|${r})($VERB$a2)/$2/g;
					@temp = ($listTags =~ /($PRO${l}token:$cliticopers\|${r})($VERB$a2)/g);
					$Rel =  "ClitL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}token:$cliticopers\|${r})($VERB$a2)/$2/g;

					# ClitR: VERB PRO<token:$cliticopers>
					# Recursivity: 1
					@temp = ($listTags =~ /($VERB$a2)($PRO${l}token:$cliticopers\|${r})/g);
					$Rel =  "ClitR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRO${l}token:$cliticopers\|${r})/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($PRO${l}token:$cliticopers\|${r})/g);
					$Rel =  "ClitR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRO${l}token:$cliticopers\|${r})/$1/g;

					# VSpecL: VERB<lemma:ser> [ADV]? VERB<mode:P>
					# Add: voice:passive
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:ser\|${r})(?:$ADV$a2)?($VERB${l}mode:P\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:ser\|${r})($ADV$a2)?($VERB${l}mode:P\|${r})/$2$3/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);
					Add("DepHead","voice:passive",\@temp);

					# VSpecL: VERB<token:[Ff]ui|[Ff]oi|[Ff]omos|[Ff]oram|[Ff]oste|[Ff]osse|[Ff]ossem> [ADV]? VERB<mode:P>
					# Add: voice:passive
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}token:(?:[Ff]ui|[Ff]oi|[Ff]omos|[Ff]oram|[Ff]oste|[Ff]osse|[Ff]ossem)\|${r})(?:$ADV$a2)?($VERB${l}mode:P\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}token:(?:[Ff]ui|[Ff]oi|[Ff]omos|[Ff]oram|[Ff]oste|[Ff]osse|[Ff]ossem)\|${r})($ADV$a2)?($VERB${l}mode:P\|${r})/$2$3/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);
					Add("DepHead","voice:passive",\@temp);

					# VSpecL: VERB<(type:A)|(lemma:ter|haver|haber|avoir|have)> [ADV]? VERB<mode:P>
					# Add: type:perfect
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}type:A\|${r}|$VERB${l}lemma:(?:ter|haver|haber|avoir|have)\|${r})(?:$ADV$a2)?($VERB${l}mode:P\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}type:A\|${r}|$VERB${l}lemma:(?:ter|haver|haber|avoir|have)\|${r})($ADV$a2)?($VERB${l}mode:P\|${r})/$2$3/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);
					Add("DepHead","type:perfect",\@temp);

					# VSpecL: VERB<lemma:$VModalES> [ADV]? VERB<mode:N>
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:$VModalES\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$VModalES\|${r})($ADV$a2)?($VERB${l}mode:N\|${r})/$2$3/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

					# VSpecLocL: VERB<lemma:ter|haver> [ADV]? PRP<lemma:de>|CONJ<lemma:que&type:S> [ADV]? VERB<mode:N>
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:(?:ter|haver)\|${r})(?:$ADV$a2)?($PRP${l}lemma:de\|${r}|$CONJ${l}lemma:que\|${b2}type:S\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "VSpecLocL";
					DepRelHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:ter|haver)\|${r})($ADV$a2)?($PRP${l}lemma:de\|${r}|$CONJ${l}lemma:que\|${b2}type:S\|${r})($ADV$a2)?($VERB${l}mode:N\|${r})/$2$4$5/g;
					Inherit("DepRelHead","mode,person,tense,number",\@temp);

					# VSpecLocL: VERB<lemma:comezar|acabar|finalizar|terminar|passar|estar> [ADV]? PRP<lemma:$PrepLocs> [ADV]? VERB<mode:N>
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:(?:comezar|acabar|finalizar|terminar|passar|estar)\|${r})(?:$ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "VSpecLocL";
					DepRelHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:comezar|acabar|finalizar|terminar|passar|estar)\|${r})($ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r})($ADV$a2)?($VERB${l}mode:N\|${r})/$2$4$5/g;
					Inherit("DepRelHead","mode,person,tense,number",\@temp);

					# VSpecL: VERB<lemma:ir|vir|ser> [ADV]?  VERB<mode:N>
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:(?:ir|vir|ser)\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:ir|vir|ser)\|${r})($ADV$a2)?($VERB${l}mode:N\|${r})/$2$3/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

					# VSpecL: VERB<lemma:estar> [ADV]? VERB<mode:G>
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:estar\|${r})(?:$ADV$a2)?($VERB${l}mode:G\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:estar\|${r})($ADV$a2)?($VERB${l}mode:G\|${r})/$2$3/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

					# PunctL: [ADV<pos:0>] Fc VERB
					# NEXT
					# AdjnL: ADV<pos:0> [Fc] VERB
					@temp = ($listTags =~ /(?:$ADV${l}pos:0\|${r})($Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($ADV${l}pos:0\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV${l}pos:0\|${r})($Fc$a2)($VERB$a2)/$3/g;

					# PunctR:  VERB [Fc] [ADV] Fc
					# NEXT
					# PunctR: VERB Fc [ADV] [Fc]
					# NEXT
					# AdjnR: VERB [Fc] ADV [Fc]
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$ADV$a2)($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$ADV$a2)(?:$Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($ADV$a2)(?:$Fc$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($ADV$a2)($Fc$a2)/$1/g;

					# PunctL: Fc [ADV] [Fc] VERB
					# NEXT
					# PunctL: [Fc] [ADV] Fc VERB
					# NEXT
					# AdjnL: [Fc] ADV [Fc] VERB
					@temp = ($listTags =~ /($Fc$a2)(?:$ADV$a2)(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$ADV$a2)($Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)($ADV$a2)(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($ADV$a2)($Fc$a2)($VERB$a2)/$4/g;

					}
{#<function>
					# AdjnR: VERB [NOUN|PRO<type:D|P|I|X>]? ADV|CONJ<coord:adv>
					# Recursivity: 1
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2|$CONJ${l}coord:adv\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2|$CONJ${l}coord:adv\|${r})/$1$2/g;
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2|$CONJ${l}coord:adv\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUN$a2|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a2|$CONJ${l}coord:adv\|${r})/$1$2/g;

					# AdjnL:  ADV|CONJ<coord:adv>  VERB
					# Recursivity: 1
					@temp = ($listTags =~ /($ADV$a2|$CONJ${l}coord:adv\|${r})($VERB$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2|$CONJ${l}coord:adv\|${r})($VERB$a2)/$2/g;
					@temp = ($listTags =~ /($ADV$a2|$CONJ${l}coord:adv\|${r})($VERB$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($ADV$a2|$CONJ${l}coord:adv\|${r})($VERB$a2)/$2/g;

					# TermR: PRP NOUN [Fc] [PRP] [NOUN] [CONJ<lemma:$CCord>] [PRP] [NOUN]
					# NEXT
					# CoordL: PRP [NOUN] [Fc] [PRP] [NOUN] CONJ<lemma:$CCord> [PRP] [NOUN]
					# NEXT
					# PunctL: [PRP] [NOUN] Fc [PRP] [NOUN] CONJ<lemma:$CCord> [PRP] [NOUN]
					# Recursivity: 3
					@temp = ($listTags =~ /($PRP$a2)($NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$CONJ${l}lemma:$CCord\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUN$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUN$a2)($Fc$a2)($PRP$a2)($NOUN$a2)($CONJ${l}lemma:$CCord\|${r})($PRP$a2)($NOUN$a2)/$4$5$6$7$8/g;
					@temp = ($listTags =~ /($PRP$a2)($NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$CONJ${l}lemma:$CCord\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUN$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUN$a2)($Fc$a2)($PRP$a2)($NOUN$a2)($CONJ${l}lemma:$CCord\|${r})($PRP$a2)($NOUN$a2)/$4$5$6$7$8/g;
					@temp = ($listTags =~ /($PRP$a2)($NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$CONJ${l}lemma:$CCord\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUN$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUN$a2)($Fc$a2)($PRP$a2)($NOUN$a2)($CONJ${l}lemma:$CCord\|${r})($PRP$a2)($NOUN$a2)/$4$5$6$7$8/g;
					@temp = ($listTags =~ /($PRP$a2)($NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)(?:$CONJ${l}lemma:$CCord\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)(?:$NOUN$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$NOUN$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUN$a2)($Fc$a2)($PRP$a2)($NOUN$a2)($CONJ${l}lemma:$CCord\|${r})($PRP$a2)($NOUN$a2)/$4$5$6$7$8/g;

					# CoordL: [Fc]? PRP [NOUN] CONJ<lemma:$CCord> [PRP] [NOUN]
					# NEXT
					# TermR: [Fc]? [PRP] [NOUN] [CONJ<lemma:$CCord>] PRP NOUN
					# NEXT
					# TermR: [Fc]? PRP NOUN [CONJ<lemma:$CCord>] [PRP] [NOUN]
					# NEXT
					# CoordR: [Fc]? [PRP] [NOUN] CONJ<lemma:$CCord> PRP [NOUN]
					# Add: coord:cprep
					@temp = ($listTags =~ /(?:$Fc$a2)?($PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$PRP$a2)(?:$NOUN$a2)(?:$CONJ${l}lemma:$CCord\|${r})($PRP$a2)($NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?($PRP$a2)($NOUN$a2)(?:$CONJ${l}lemma:$CCord\|${r})(?:$PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$PRP$a2)(?:$NOUN$a2)($CONJ${l}lemma:$CCord\|${r})($PRP$a2)(?:$NOUN$a2)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($PRP$a2)($NOUN$a2)($CONJ${l}lemma:$CCord\|${r})($PRP$a2)($NOUN$a2)/$1$4/g;
					Add("HeadDep","coord:cprep",\@temp);

					# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7$8$9/g;

					# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7/g;

					# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;

					# CprepR: [NOUNSINGLE] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNSINGLE$a2)(?:$PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP$a2)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3/g;

					# CprepR: NOUN<type:C> PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUNSINGLE PRP<lemma:de> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7$8$9/g;

					# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUNSINGLE PRP<lemma:de> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7/g;

					# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUNSINGLE PRP<lemma:de> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNSINGLE$a2)(?:$PRP$a2)(?:$NOUNSINGLE$a2)(?:$PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;

					# CprepR: [NOUNSINGLE] [PRP] NOUNSINGLE PRP<lemma:de> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /(?:$NOUNSINGLE$a2)(?:$PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP$a2)($NOUNSINGLE$a2)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3/g;

					# CprepR: NOUNSINGLE PRP<lemma:de> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($NOUNSINGLE$a2)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNSINGLE$a2)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# CprepR: X<lemma:uno>|PRO<type:[DI]> PRP NOUNSINGLE|PRO<type:D|P|I|X>
					# Add: tag:PRO
					@temp = ($listTags =~ /($X${l}lemma:uno\|${r}|$PRO${l}type:[DI]\|${r})($PRP$a2)($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($X${l}lemma:uno\|${r}|$PRO${l}type:[DI]\|${r})($PRP$a2)($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
					Add("HeadRelDep","tag:PRO",\@temp);

					# CprepR: NOUN ADV<lemma:como>|PRP<lemma:como>|CONJ<lemma:como> NOUN
					@temp = ($listTags =~ /($NOUN$a2)($ADV${l}lemma:como\|${r}|$PRP${l}lemma:como\|${r}|$CONJ${l}lemma:como\|${r})($NOUN$a2)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($ADV${l}lemma:como\|${r}|$PRP${l}lemma:como\|${r}|$CONJ${l}lemma:como\|${r})($NOUN$a2)/$1/g;

					# CircR: VERB ADV<lemma:como>|PRP<lemma:como>|CONJ<lemma:como> NOUN
					@temp = ($listTags =~ /($VERB$a2)($ADV${l}lemma:como\|${r}|$PRP${l}lemma:como\|${r}|$CONJ${l}lemma:como\|${r})($NOUN$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($ADV${l}lemma:como\|${r}|$PRP${l}lemma:como\|${r}|$CONJ${l}lemma:como\|${r})($NOUN$a2)/$1/g;

					# TermR: PRP<nomin:yes> NOUNSINGLE|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($PRP${l}nomin:yes\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($PRP${l}nomin:yes\|${r})($NOUNSINGLE$a2|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# CoordL: NP [Fc] [NP] CONJ<(type:C)|(lemma:$CCord)> [NP]
					# NEXT
					# PunctL: [NP] Fc [NP] CONJ<(type:C)|(lemma:$CCord)> [NP]
					# Recursivity: 10
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;

					# CoordL: [Fc]? NP CONJ<(type:C)|(lemma:$CCord)> [NP]
					# NEXT
					# CoordR: [Fc]? [NP] CONJ<(type:C)|(lemma:$CCord)> NP
					# Add: coord:noun
					@temp = ($listTags =~ /(?:$Fc$a2)?($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$1$3/g;
					Add("HeadDep","coord:noun",\@temp);

					# PunctL: Fc CONJ<coord:noun>
					@temp = ($listTags =~ /($Fc$a2)($CONJ${l}coord:noun\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($CONJ${l}coord:noun\|${r})/$2/g;

					# CprepR: ADJ|ADV|DATE PRP NOUNCOORD|PRO<type:D|P|I|X|>
					@temp = ($listTags =~ /($ADJ$a2|$ADV$a2|$DATE$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X|)\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2|$ADV$a2|$DATE$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X|)\|${r})/$1/g;

					# CprepR: ADJ|ADV|DATE PRP VERB<mode:N>
					# NoUniq
					@temp = ($listTags =~ /($ADJ$a2|$ADV$a2|$DATE$a2)($PRP$a2)($VERB${l}mode:N\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2|$ADV$a2|$DATE$a2)($PRP$a2)($VERB${l}mode:N\|${r})/$1$2$3/g;

					# DobjR: VERB [Fc] [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] [Fc] NOUNCOORD|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "DobjR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc|Fpa|Fca NOUNCOORD|CARD|ADJ|PRO<type:D|P|I|X> [Fc|Fpt|Fct]
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] NOUNCOORD|CARD|ADJ|PRO<type:D|P|I|X> Fc|Fpt|Fct
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] NOUNCOORD|CARD|ADJ|PRO<type:D|P|I|X> [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)($NOUNCOORD|$CARD$a2|$ADJ$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)($NOUNCOORD|$CARD$a2|$ADJ$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)($NOUNCOORD|$CARD$a2|$ADJ$a2|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)($NOUNCOORD|$CARD$a2|$ADJ$a2|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpt$a2|$Fct$a2)/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc|Fpa|Fca [PRP] NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] [PRP] NOUNCOORD|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
					# NEXT
					# CprepR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] PRP NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)(?:$PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)(?:$PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|$Fct$a2)/$1/g;

					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] VERB<mode:P> [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [Fc|Fpt|Fct]
					# NoUniq
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)($VERB${l}mode:P\|${r})(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)($VERB${l}mode:P\|${r})($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($X$a2)?($Fc$a2|$Fpt$a2|$Fct$a2)/$1$2$3$4$5$6$7$8$9$10$11$12$13$14/g;

					# Single: [VERB<lemma:$SubcatClaus>]  [PRP<lemma:a>] [NOUNCOORD|PRO<type:D|P|I|X>] PRO<type:R>  [NOUNCOORD|PRO<type:D|P|I|X>]?  [VERB<mode:[^PNG]>]
					# Corr: tag:CONJ, type:S
					@temp = ($listTags =~ /(?:$VERB${l}lemma:$SubcatClaus\|${r})(?:$PRP${l}lemma:a\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRO${l}type:R\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?(?:$VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatClaus\|${r})($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRO${l}type:R\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($VERB${l}mode:[^PNG]\|${r})/$1$2$3$4$5$6/g;
					Corr("Head","tag:CONJ,type:S",\@temp);

					# Single: [VERB<lemma:$SubcatClaus>]  [ADJ] PRO<type:R>  [NOUNCOORD|PRO<type:D|P|I|X>]?  [VERB<mode:[^PNG]>]
					# Corr: tag:CONJ, type:S
					@temp = ($listTags =~ /(?:$VERB${l}lemma:$SubcatClaus\|${r})(?:$ADJ$a2)($PRO${l}type:R\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?(?:$VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatClaus\|${r})($ADJ$a2)($PRO${l}type:R\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($VERB${l}mode:[^PNG]\|${r})/$1$2$3$4$5/g;
					Corr("Head","tag:CONJ,type:S",\@temp);

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>|PRO<lemma:que|quem>] [NOUNCOORD|PRO<type:D|P|I|X>]  VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc] [PRO<type:R|W>|PRO<lemma:que|quem>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>   Fc
					# NEXT
					# DobjL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W>|PRO<lemma:que|quem> [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>|PRO<lemma:que|quem>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>    [Fc]?
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "DobjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1$2$3$4$5$6/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>|PRO<lemma:que|quem>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? [PRO<type:R|W>|PRO<lemma:que|quem>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# SubjL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W>|PRO<lemma:que|quem> VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>|PRO<lemma:que|quem>] VERB|CONJ<coord:verb>  [Fc]?
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1$2$3$4$5/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRP] [PRO<type:R|W>|PRO<lemma:que|quem>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?  [PRP] [PRO<type:R|W>|PRO<lemma:que|quem>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# CircL: [NOUNCOORD|PRO<type:D|P|I|X>]  [Fc]? PRP PRO<type:R|W>|PRO<lemma:que|quem> VERB|CONJ<coord:verb> [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRP] [PRO<type:R|W>|PRO<lemma:que|quem>] VERB|CONJ<coord:verb> [Fc]?
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1$2$3$4$5$6/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRP] [PRO<type:R|W>|PRO<lemma:que|quem>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?  [PRP] [PRO<type:R|W>|PRO<lemma:que|quem>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# CircL: [NOUNCOORD|PRO<type:D|P|I|X>]  [Fc]? PRP PRO<type:R|W>|PRO<lemma:que|quem> [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb> [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRP] [PRO<type:R|W>|PRO<lemma:que|quem>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb> [Fc]?
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1$2$3$4$5$6$7/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc VERB<mode:[GP]>|CONJ<coord:verb>
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X>  [Fc]? VERB<mode:[GP]>|CONJ<coord:verb>
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/$1$2$3/g;

					# CircR: VERB<mode:P> [NOUNCOORD|PRO<type:D|P|I|X>] PRP<lemma:por|by> NOUNCOORD|PRO<type:D|P|I|X>|ADV
					@temp = ($listTags =~ /($VERB${l}mode:P\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:(?:por|by)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$ADV$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}mode:P\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:(?:por|by)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$ADV$a2)/$1$2/g;

					# PunctR: VERB Fc [NOUNCOORD|PRO<type:D|P|I|X>] [PRP<lemma:$PrepMA>] [CARD|DATE]
					# NEXT
					# CircR: VERB [Fc]? [NOUNCOORD|PRO<type:D|P|I|X>] PRP<lemma:$PrepMA> CARD|DATE
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP${l}lemma:$PrepMA\|${r})(?:$CARD$a2|$DATE$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:$PrepMA\|${r})($CARD$a2|$DATE$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)?($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:$PrepMA\|${r})($CARD$a2|$DATE$a2)/$1$3/g;

					# PunctR: VERB Fc [PRP] [DATE]
					# NEXT
					# CircR: VERB [Fc]? PRP DATE
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$DATE$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)?($PRP$a2)($DATE$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)?($PRP$a2)($DATE$a2)/$1/g;

					# PunctL: [PRP] [DATE] Fc VERB
					# NEXT
					# CircL: PRP DATE [Fc]? VERB
					@temp = ($listTags =~ /(?:$PRP$a2)(?:$DATE$a2)($Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP$a2)($DATE$a2)(?:$Fc$a2)?($VERB$a2)/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($DATE$a2)($Fc$a2)?($VERB$a2)/$4/g;

					# PunctR: VERB Fc [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]
					# NEXT
					# PunctR: VERB [Fc] [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] Fc
					# NEXT
					# CircR: VERB [Fc] PRP NOUNCOORD|PRO<type:D|P|I|X> [Fc]
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/$1/g;

					# CprepR: CARD PRP<lemma:de|entre|sobre|of|about|between> NOUNCOORD|PRO
					@temp = ($listTags =~ /($CARD$a2)($PRP${l}lemma:(?:de|entre|sobre|of|about|between)\|${r})($NOUNCOORD|$PRO$a2)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($CARD$a2)($PRP${l}lemma:(?:de|entre|sobre|of|about|between)\|${r})($NOUNCOORD|$PRO$a2)/$1/g;

					# CprepR: PRO<type:P> PRP<lemma:de|of> NOUNCOORD|PRO
					@temp = ($listTags =~ /($PRO${l}type:P\|${r})($PRP${l}lemma:(?:de|of)\|${r})($NOUNCOORD|$PRO$a2)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}type:P\|${r})($PRP${l}lemma:(?:de|of)\|${r})($NOUNCOORD|$PRO$a2)/$1/g;

					# CprepR: NOUNCOORD [PRP] [PRO<type:D|P|I|X>] PRP NOUNCOORD|ADV
					# NEXT
					# CprepR: NOUNCOORD PRP PRO<type:D|P|I|X> [PRP] [NOUNCOORD|ADV]
					@temp = ($listTags =~ /($NOUNCOORD)(?:$PRP$a2)(?:$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($NOUNCOORD|$ADV$a2)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD)($PRP$a2)($PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP$a2)(?:$NOUNCOORD|$ADV$a2)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD)($PRP$a2)($PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($NOUNCOORD|$ADV$a2)/$1/g;

					# PrepR: VERB [NOUNCOORD|PRO<type:D|P|I|X>] CONJ<coord:cprep>
					@temp = ($listTags =~ /($VERB$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($CONJ${l}coord:cprep\|${r})/g);
					$Rel =  "PrepR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($CONJ${l}coord:cprep\|${r})/$1$2/g;

					# PrepR: NOUNCOORD|PRO<type:D|P|I|X> CONJ<coord:cprep>
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($CONJ${l}coord:cprep\|${r})/g);
					$Rel =  "PrepR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($CONJ${l}coord:cprep\|${r})/$1/g;

					# SubjL: PRO<sust:yes>  VERB
					# Add: nomin:yes adsubj:yes
					# Inherit: number, person
					@temp = ($listTags =~ /($PRO${l}sust:yes\|${r})($VERB$a2)/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}sust:yes\|${r})($VERB$a2)/$2/g;
					Inherit("DepHead","number,person",\@temp);
					Add("DepHead","nomin:yes,adsubj:yes",\@temp);

					# SubjL: [PRO<sust:yes>] NOUNCOORD|PRO<type:D|P|I|X> VERB
					# Add: adsubj:yes
					# NEXT
					# DobjL: PRO<sust:yes> [NOUNCOORD|PRO<type:D|P|I|X>] VERB
					# Add: nomin:yes
					# Inherit: number, person
					@temp = ($listTags =~ /(?:$PRO${l}sust:yes\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					Add("DepHead","adsubj:yes",\@temp);
					@temp = ($listTags =~ /($PRO${l}sust:yes\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/g);
					$Rel =  "DobjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}sust:yes\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/$3/g;
					Inherit("DepHead","number,person",\@temp);
					Add("DepHead","nomin:yes",\@temp);

					# SubjR: VERB<lemma:$VS> NOUNCOORD|PRO<type:D|P|I|X>
					# Agr: number, person
					# Add: adsubj:yes
					@temp = ($listTags =~ /($VERB${l}lemma:$VS\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}lemma:$VS\|${r})($NOUNCOORD|$PRO${l}concord:1${b2}type:(?:D|P|I|X)\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;
					Add("HeadDep","adsubj:yes",\@temp);

					# SubjR: VERB<se:yes&lemma:$VSrefleja> NOUNCOORD|PRO<type:D|P|I|X>
					# Agr: number, person
					# Add: adsubj:yes
					@temp = ($listTags =~ /($VERB${l}lemma:$VSrefleja\|${b2}se:yes\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}lemma:$VSrefleja\|${b2}se:yes\|${r})($NOUNCOORD|$PRO${l}concord:1${b2}type:(?:D|P|I|X)\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;
					Add("HeadDep","adsubj:yes",\@temp);

					# SubjR: VERB<ind:yes&lemma:$VSind> NOUNCOORD|PRO<type:D|P|I|X>
					# Agr: number, person
					# Add: adsubj:yes
					@temp = ($listTags =~ /($VERB${l}ind:yes\|${b2}lemma:$VSind\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}ind:yes\|${b2}lemma:$VSind\|${r})($NOUNCOORD|$PRO${l}concord:1${b2}type:(?:D|P|I|X)\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;
					Add("HeadDep","adsubj:yes",\@temp);

					# AtrR: VERB<lemma:ser> NOUNCOORD|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB${l}lemma:ser\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "AtrR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:ser\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# AtrR: VERB ADJ|CONJ<coord:adj>
					@temp = ($listTags =~ /($VERB$a2)($ADJ$a2|$CONJ${l}coord:adj\|${r})/g);
					$Rel =  "AtrR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($ADJ$a2|$CONJ${l}coord:adj\|${r})/$1/g;

					# DobjR: VERB CARD|NOUN|CONJ<coord:noun>|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB$a2)($CARD$a2|$NOUN$a2|$CONJ${l}coord:noun\|${r}|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "DobjR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CARD$a2|$NOUN$a2|$CONJ${l}coord:noun\|${r}|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# IobjR: VERB<lemma:($SubcatIND)|(SubcatBitr)>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:a> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatIND\|${r}|$VERB${l}SubcatBitr\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "IobjR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatIND\|${r}|$VERB${l}SubcatBitr\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatA>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:a> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatA\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatA\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatEM>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:em> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatEM\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:em\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatEM\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:em\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatDE>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:de> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatDE\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:de\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatDE\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:de\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatCOM>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:com> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatCOM\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:com\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatCOM\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:com\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatPOR>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:por> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatPOR\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:por\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatPOR\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:por\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatPARA>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:para> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatPARA\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:para\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatPARA\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:para\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatSOBRE>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:sobre> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatSOBRE\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:sobre\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatSOBRE\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:sobre\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					}
{#<function>
					# CoordL: NP [Fc] [NP] CONJ<(type:C)|(lemma:$CCord)> [NP]
					# NEXT
					# PunctL: [NP] Fc [NP] CONJ<(type:C)|(lemma:$CCord)> [NP]
					# Recursivity: 5
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;

					# CoordL: [Fc]? NP CONJ<(type:C)|(lemma:$CCord)> [NP]
					# NEXT
					# CoordR: [Fc]? [NP] CONJ<(type:C)|(lemma:$CCord)> NP
					# Add: coord:noun
					@temp = ($listTags =~ /(?:$Fc$a2)?($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$1$3/g;
					Add("HeadDep","coord:noun",\@temp);

					# PunctL: Fc CONJ<coord:noun>
					@temp = ($listTags =~ /($Fc$a2)($CONJ${l}coord:noun\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($CONJ${l}coord:noun\|${r})/$2/g;

					# CoordL: VERB<nomin:no> [Fc] [VERB<nomin:no>] CONJ<(type:C)|(lemma:$CCord)> [VERB<nomin:no>]
					# NEXT
					# PunctL: [VERB<nomin:no>] Fc [VERB<nomin:no>] CONJ<(type:C)|(lemma:$CCord)> [VERB<nomin:no>]
					# Recursivity: 5
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;

					# CoordL: [Fc]? VERB<nomin:no> CONJ<(type:C)|(lemma:$CCord)> [VERB<nomin:no>]
					# NEXT
					# CoordR: [Fc]? [VERB<nomin:no>] CONJ<(type:C)|(lemma:$CCord)> VERB<nomin:no>
					# Add: coord:verb
					# Inherit: mode, tense
					@temp = ($listTags =~ /(?:$Fc$a2)?($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$1$3/g;
					Inherit("HeadDep","mode,tense",\@temp);
					Add("HeadDep","coord:verb",\@temp);

					# PunctL: Fc CONJ<coord:verb>
					@temp = ($listTags =~ /($Fc$a2)($CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($CONJ${l}coord:verb\|${r})/$2/g;

					# CircR: VERB<voice:passive> [X]? [X]? [X]? [X]? PRP<lemma:por> NOUNCOORD|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB${l}voice:passive\|${r})(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?(?:$X$a2)?($PRP${l}lemma:por\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}voice:passive\|${r})($X$a2)?($X$a2)?($X$a2)?($X$a2)?($PRP${l}lemma:por\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;

					# CircR: [VERB|CONJ<coord:verb>] [PRP] VERB|CONJ<coord:verb> [PRP] [CARD|NOUNCOORD|PRO<type:D|P|I|X>] PRP CARD|NOUNCOORD|PRO<type:D|P|I|X>
					# Recursivity: 1
					@temp = ($listTags =~ /(?:$VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)(?:$CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;
					@temp = ($listTags =~ /(?:$VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)(?:$CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;

					# CircR: [VERB|CONJ<coord:verb>] [PRP] VERB|CONJ<coord:verb> PRP CARD|NOUNCOORD|PRO<type:D|P|I|X>
					# NEXT
					# CircR: VERB|CONJ<coord:verb> PRP VERB|CONJ<coord:verb> [PRP] [CARD|NOUNCOORD|PRO<type:D|P|I|X>]
					@temp = ($listTags =~ /(?:$VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)(?:$CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($CARD$a2|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# CircR: VERB|CONJ<coord:verb>  PRP VERB<mode:[^PG]>|ADV|CARD
					# Recursivity: 1
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB${l}mode:[^PG]\|${r}|$ADV$a2|$CARD$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB${l}mode:[^PG]\|${r}|$ADV$a2|$CARD$a2)/$1/g;
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB${l}mode:[^PG]\|${r}|$ADV$a2|$CARD$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($VERB${l}mode:[^PG]\|${r}|$ADV$a2|$CARD$a2)/$1/g;

					# SpecL: [VERB|CONJ<coord:verb>]  [PRP] DET<type:A>  VERB<mode:N>|ADV|CARD
					# NEXT
					# CircR: VERB|CONJ<coord:verb>  PRP  [DET<type:A>] VERB<mode:N>|ADV|CARD
					# Recursivity: 1
					@temp = ($listTags =~ /(?:$VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)($DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a2|$CARD$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)(?:$DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a2|$CARD$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a2|$CARD$a2)/$1/g;
					@temp = ($listTags =~ /(?:$VERB$a2|$CONJ${l}coord:verb\|${r})(?:$PRP$a2)($DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a2|$CARD$a2)/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)(?:$DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a2|$CARD$a2)/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a2|$CARD$a2)/$1/g;

					# CircR: VERB|CONJ<coord:verb> PRP NOUNCOORD|PRO<type:D|P|I|X>
					# Recursivity: 1
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
					@temp = ($listTags =~ /($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2|$CONJ${l}coord:verb\|${r})($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# PunctR: VERB Fc [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?
					# NEXT
					# PunctR: VERB [Fc] [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] Fc
					# NEXT
					# CircR: VERB [Fc] PRP NOUNCOORD|PRO<type:D|P|I|X> [Fc]?
					# Recursivity:1
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?/$1/g;
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?/$1/g;

					# PunctL: [PRP<pos:0>] [NOUNCOORD|PRO<type:D|P|I|X>] Fc  VERB|CONJ<coord:verb>
					# NEXT
					# CircL: PRP<pos:0> NOUNCOORD|PRO<type:D|P|I|X> [Fc]?  VERB|CONJ<coord:verb>
					@temp = ($listTags =~ /(?:$PRP${l}pos:0\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP${l}pos:0\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP${l}pos:0\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB$a2|$CONJ${l}coord:verb\|${r})/$4/g;

					# PunctL: Fc [PRP] [NOUNCOORD|PRO<type:D|P|I|X> ] [Fc]?  VERB|CONJ<coord:verb>
					# NEXT
					# PunctL: [Fc]? [PRP] [NOUNCOORD|PRO<type:D|P|I|X> ] Fc  VERB|CONJ<coord:verb>
					# NEXT
					# CircL: [Fc]? PRP NOUNCOORD|PRO<type:D|P|I|X>  [Fc]?  VERB|CONJ<coord:verb>
					# Recursivity:1
					@temp = ($listTags =~ /($Fc$a2)(?:$PRP$a2)([NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(])(?:$Fc$a2)?($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$PRP$a2)([NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(])($Fc$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB$a2|$CONJ${l}coord:verb\|${r})/$5/g;
					@temp = ($listTags =~ /($Fc$a2)(?:$PRP$a2)([NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(])(?:$Fc$a2)?($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$PRP$a2)([NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(])($Fc$a2)($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB$a2|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB$a2|$CONJ${l}coord:verb\|${r})/$5/g;

					# AtrR: VERB<lemma:$SubcatAtr>  VERB<mode:[PNG]>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatAtr\|${r})($VERB${l}mode:[PNG]\|${r})/g);
					$Rel =  "AtrR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatAtr\|${r})($VERB${l}mode:[PNG]\|${r})/$1/g;

					# Circ2R: VERB VERB<mode:[GP]>
					@temp = ($listTags =~ /($VERB$a2)($VERB${l}mode:[GP]\|${r})/g);
					$Rel =  "Circ2R";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($VERB${l}mode:[GP]\|${r})/$1/g;

					# SubjR: VERB<lemma:$VS> VERB<mode:N>
					# Agr: number, person
					# Add: adsubj:yes
					@temp = ($listTags =~ /($VERB${l}lemma:$VS\|${r})($VERB${l}mode:N\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}lemma:$VS\|${r})($VERB${l}concord:1${b2}mode:N\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;
					Add("HeadDep","adsubj:yes",\@temp);

					# SubjR: VERB<se:yes&lemma:$VSrefleja> VERB<mode:N>
					# Agr: number, person
					# Add: adsubj:yes
					@temp = ($listTags =~ /($VERB${l}lemma:$VSrefleja\|${b2}se:yes\|${r})($VERB${l}mode:N\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}lemma:$VSrefleja\|${b2}se:yes\|${r})($VERB${l}concord:1${b2}mode:N\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;
					Add("HeadDep","adsubj:yes",\@temp);

					# SubjR: VERB<ind:yes&lemma:$VSind> VERB<mode:N>
					# Agr: number, person
					# Add: adsubj:yes
					@temp = ($listTags =~ /($VERB${l}ind:yes\|${b2}lemma:$VSind\|${r})($VERB${l}mode:N\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}ind:yes\|${b2}lemma:$VSind\|${r})($VERB${l}concord:1${b2}mode:N\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;
					Add("HeadDep","adsubj:yes",\@temp);

					# DobjR: VERB VERB<mode:N>
					@temp = ($listTags =~ /($VERB$a2)($VERB${l}mode:N\|${r})/g);
					$Rel =  "DobjR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($VERB${l}mode:N\|${r})/$1/g;

					# AdjnR:  VERB<mode:[^PNG]> DATE
					@temp = ($listTags =~ /($VERB${l}mode:[^PNG]\|${r})($DATE$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}mode:[^PNG]\|${r})($DATE$a2)/$1/g;

					# PunctL: Fc [DATE] VERB<mode:[^PNG]>
					# NEXT
					# AdjnL:  [Fc]? DATE VERB<mode:[^PNG]>
					@temp = ($listTags =~ /($Fc$a2)(?:$DATE$a2)($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?($DATE$a2)($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($DATE$a2)($VERB${l}mode:[^PNG]\|${r})/$3/g;

					# CprepR: NOUNCOORD PRP NOUNCOORD
					@temp = ($listTags =~ /($NOUNCOORD)($PRP$a2)($NOUNCOORD)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD)($PRP$a2)($NOUNCOORD)/$1/g;

					# Single: [VERB<lemma:$SubcatClaus>]  PRO<type:R>  [NOUNCOORD|PRO<type:D|P|I|X>]?  [VERB<mode:[^PNG]>]
					# Corr: tag:CONJ, type:S
					@temp = ($listTags =~ /(?:$VERB${l}lemma:$SubcatClaus\|${r})($PRO${l}type:R\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?(?:$VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatClaus\|${r})($PRO${l}type:R\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($VERB${l}mode:[^PNG]\|${r})/$1$2$3$4/g;
					Corr("Head","tag:CONJ,type:S",\@temp);

					# SpecL: [VERB] CONJ<type:S>  VERB<mode:[^PNG]>
					# NEXT
					# DobjR: VERB  [CONJ<type:S>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)($CONJ${l}type:S\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$CONJ${l}type:S\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "DobjR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}type:S\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

					# SpecL: [VERB]  CONJ<type:S>  [NOUNCOORD|PRO<type:D|P|I|X>] VERB<mode:[^PNG]>
					# NEXT
					# SubjL:  [VERB]  [CONJ<type:S>]  NOUNCOORD|PRO<type:D|P|I|X> VERB<mode:[^PNG]>
					# Add: adsubj:yes
					# NEXT
					# DobjR: VERB   [CONJ<type:S>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)($CONJ${l}type:S\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$CONJ${l}type:S\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					Add("DepHead","adsubj:yes",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$CONJ${l}type:S\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "DobjR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}type:S\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

					# SpecL: [VERB] [PRP] CONJ<lemma:que> VERB<mode:[^PNG]>
					# NEXT
					# CircR: VERB PRP [CONJ<lemma:que>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$PRP$a2)($CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)($PRP$a2)(?:$CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($PRP$a2)($CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc|Fpa|Fca VERB [Fc|Fpt|Fct]
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] VERB Fc|Fpt|Fct
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] VERB [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)($VERB$a2)(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)($VERB$a2)($Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)($VERB$a2)(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)($VERB$a2)($Fc$a2|$Fpt$a2|$Fct$a2)/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc|Fpa|Fca [PRP] NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] [PRP] NOUNCOORD|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
					# NEXT
					# CprepR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] PRP NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)(?:$PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)(?:$PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|$Fct$a2)/$1/g;

					# AdjnL: [Fc] VERB<mode:P> [Fc] VERB
					# NEXT
					# PunctL: Fc [VERB<mode:P>] [Fc] VERB
					# NEXT
					# PunctL: [Fc] [VERB<mode:P>] Fc VERB
					@temp = ($listTags =~ /(?:$Fc$a2)($VERB${l}mode:P\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "AdjnL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($Fc$a2)(?:$VERB${l}mode:P\|${r})(?:$Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)(?:$VERB${l}mode:P\|${r})($Fc$a2)($VERB$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($VERB${l}mode:P\|${r})($Fc$a2)($VERB$a2)/$4/g;

					# CoordL: NP [Fc] [NP] CONJ<(type:C)|(lemma:$CCord)> [NP]
					# NEXT
					# PunctL: [NP] Fc [NP] CONJ<(type:C)|(lemma:$CCord)> [NP]
					# Recursivity: 10
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
					@temp = ($listTags =~ /($NP)(?:$Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NP)($Fc$a2)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NP)($Fc$a2)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;

					# CoordL: [Fc]? NP CONJ<(type:C)|(lemma:$CCord)> [NP]
					# NEXT
					# CoordR: [Fc]? [NP] CONJ<(type:C)|(lemma:$CCord)> NP
					# Add: coord:noun
					@temp = ($listTags =~ /(?:$Fc$a2)?($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$1$3/g;
					Add("HeadDep","coord:noun",\@temp);

					# PunctL: Fc CONJ<coord:noun>
					@temp = ($listTags =~ /($Fc$a2)($CONJ${l}coord:noun\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($CONJ${l}coord:noun\|${r})/$2/g;

					# CoordL: VERB<nomin:no> [Fc] [VERB<nomin:no>] CONJ<(type:C)|(lemma:$CCord)> [VERB<nomin:no>]
					# NEXT
					# PunctL: [VERB<nomin:no>] Fc [VERB<nomin:no>] CONJ<(type:C)|(lemma:$CCord)> [VERB<nomin:no>]
					# Recursivity: 5
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
					@temp = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a2)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a2)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;

					# CoordL: [Fc]? VERB<nomin:no> CONJ<(type:C)|(lemma:$CCord)> [VERB<nomin:no>]
					# NEXT
					# CoordR: [Fc]? [VERB<nomin:no>] CONJ<(type:C)|(lemma:$CCord)> VERB<nomin:no>
					# Add: coord:verb
					# Inherit: mode, tense
					@temp = ($listTags =~ /(?:$Fc$a2)?($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/g);
					$Rel =  "CoordR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$1$3/g;
					Inherit("HeadDep","mode,tense",\@temp);
					Add("HeadDep","coord:verb",\@temp);

					# PunctL: Fc CONJ<coord:verb>
					@temp = ($listTags =~ /($Fc$a2)($CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)($CONJ${l}coord:verb\|${r})/$2/g;

					# SubjL: NOUN<type:P> VERB<mode:[^PG]>|CONJ<coord:verb&mode:[^PG]>
					# Add: adsubj:yes
					@temp = ($listTags =~ /($NOUN${l}type:P\|${r})($VERB${l}mode:[^PG]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^PG]\|${r})/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOUN${l}type:P\|${r})($VERB${l}mode:[^PG]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^PG]\|${r})/$2/g;
					Add("DepHead","adsubj:yes",\@temp);

					# SubjL: NOMINAL|PRO<type:D|P|I|X> VERB<mode:[^PG]>|CONJ<coord:verb&mode:[^PG]>
					# Add: adsubj:yes
					@temp = ($listTags =~ /($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PG]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^PG]\|${r})/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PG]\|${r}|$CONJ${l}coord:verb\|${b2}mode:[^PG]\|${r})/$2/g;
					Add("DepHead","adsubj:yes",\@temp);

					# SubjR: VERB<lemma:$VS> NOMINAL|PRO<type:D|P|I|X>
					# Agr: number, person
					@temp = ($listTags =~ /($VERB${l}lemma:$VS\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}lemma:$VS\|${r})($NOMINAL|$PRO${l}concord:1${b2}type:(?:D|P|I|X)\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;

					# SubjR: VERB<se:yes&lemma:$VSrefleja> NOMINAL|PRO<type:D|P|I|X>
					# Agr: number, person
					@temp = ($listTags =~ /($VERB${l}lemma:$VSrefleja\|${b2}se:yes\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}lemma:$VSrefleja\|${b2}se:yes\|${r})($NOMINAL|$PRO${l}concord:1${b2}type:(?:D|P|I|X)\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;

					# SubjR: VERB<ind:yes&lemma:$VSind> NOMINAL|PRO<type:D|P|I|X>
					# Agr: number, person
					@temp = ($listTags =~ /($VERB${l}ind:yes\|${b2}lemma:$VSind\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}ind:yes\|${b2}lemma:$VSind\|${r})($NOMINAL|$PRO${l}concord:1${b2}type:(?:D|P|I|X)\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;

					# DobjPrepR: VERB<lemma:$SubcatTr> PRP<lemma:a> NOMINAL|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatTr\|${r})($PRP${l}lemma:a\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "DobjPrepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatTr\|${r})($PRP${l}lemma:a\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# AtrR: VERB<lemma:ser> NOMINAL|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB${l}lemma:ser\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "AtrR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:ser\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# DobjR: VERB NOMINAL|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB$a2)($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "DobjR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

					# IobjR: VERB<lemma:($SubcatIND)|(SubcatBitr)>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:a> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatIND\|${r}|$VERB${l}SubcatBitr\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "IobjR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatIND\|${r}|$VERB${l}SubcatBitr\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatA>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:a> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatA\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatA\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatEM>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:em> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatEM\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:em\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatEM\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:em\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatDE>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:de> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatDE\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:de\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatDE\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:de\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatCOM>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:com> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatCOM\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:com\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatCOM\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:com\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatPOR>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:por> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatPOR\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:por\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatPOR\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:por\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatPARA>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:para> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatPARA\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:para\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatPARA\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:para\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatSOBRE>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:sobre> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatSOBRE\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:sobre\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatSOBRE\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:sobre\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CprepR: ADJ|ADV|DATE|NOUN PRP VERB<mode:N>
					@temp = ($listTags =~ /($ADJ$a2|$ADV$a2|$DATE$a2|$NOUN$a2)($PRP$a2)($VERB${l}mode:N\|${r})/g);
					$Rel =  "CprepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($ADJ$a2|$ADV$a2|$DATE$a2|$NOUN$a2)($PRP$a2)($VERB${l}mode:N\|${r})/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>|PRO<lemma:que|quem>] VERB<adsubj:yes>|CONJ<adsubj:yes&coord:verb>    [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc] [PRO<type:R|W>|PRO<lemma:que|quem>] VERB<adsubj:yes>|CONJ<adsubj:yes&coord:verb>   Fc
					# NEXT
					# DobjL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W>|PRO<lemma:que|quem> VERB<adsubj:yes>|CONJ<adsubj:yes&coord:verb>    [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>|PRO<lemma:que|quem>] VERB<adsubj:yes>|CONJ<adsubj:yes&coord:verb>    [Fc]?
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "DobjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})($Fc$a2)?/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>|PRO<lemma:que|quem>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? [PRO<type:R|W>|PRO<lemma:que|quem>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# SubjL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W>|PRO<lemma:que|quem> VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>|PRO<lemma:que|quem>] VERB|CONJ<coord:verb>  [Fc]?
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRP] [PRO<type:R|W>|PRO<lemma:que|quem>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?  [PRP] [PRO<type:R|W>|PRO<lemma:que|quem>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# CircL: [NOUNCOORD|PRO<type:D|P|I|X>]  [Fc]? PRP PRO<type:R|W>|PRO<lemma:que|quem> VERB|CONJ<coord:verb> [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRP] [PRO<type:R|W>|PRO<lemma:que|quem>] VERB|CONJ<coord:verb> [Fc]?
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quem)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc VERB<mode:[GP]>|CONJ<coord:verb>
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? VERB<mode:[GP]>|CONJ<coord:verb>
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/$1/g;

					# AdjnR: VERB CONJ<type:S> [VERB]
					# NEXT
					# AdjnR: VERB [CONJ<type:S>] VERB
					@temp = ($listTags =~ /($VERB$a2)($CONJ${l}type:S\|${r})(?:$VERB$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$CONJ${l}type:S\|${r})($VERB$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}type:S\|${r})($VERB$a2)/$1/g;

					# TermR: PRP NOUNCOORD|PRO<type:D|P|I|X>|VERB
					# NoUniq
					@temp = ($listTags =~ /($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB$a2)/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB$a2)/$1$2/g;

				}
############################## END GRAMMAR  ###############################

				if ($ListInit eq $listTags) {
					$STOP = 1;
				}
			}
			#print STDERR "Iterations: $iteration\n";

#########SAIDA CORRECTOR TAGGER
			if ($flag eq "-c") {    
				for($i=0;$i<=$#Token;$i++) {
					my $saida = "$Token[$i]\t";#<string>
					my %OrdTags=();#<map><string>
					$OrdTags{"tag"} = $Tag[$i]; 
					foreach my $feat (keys %{$ATTR[$i]}) {
						$OrdTags{$feat} = $ATTR[$i]{$feat};
					}
					foreach my $feat (sort keys %OrdTags) {
						$saida .= "$feat:$OrdTags{$feat}|";
					}
					if($pipe){#<ignore-line>
						print "$saida\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,$saida);
					}#<ignore-line>
				}
				##Colocar a zero os vectores de cada oraçao
				@Token=();
				@Tag=();
				@Lemma=();
				@Attributes=();
				@ATTR=();   
			}
#########SAIDA STANDARD DO ANALISADOR 
			elsif ($flag eq "-a") {
				##Escrever a oraçao que vai ser analisada:
				if($pipe){#<ignore-line>
					print "SENT::$seq\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida,"SENT::$seq");
				}#<ignore-line>
				#print STDERR "LIST:: $listTags\n";
				####imprimir Hash de dependencias ordenado:
				foreach my $triplet (sort {$Ordenar{$a} <=> $Ordenar{$b} } keys %Ordenar ) {
					$triplet =~ s/^\(//;
					$triplet =~ s/\)$//;
					my ($re, $he, $de) =  split (";", $triplet);#<string>
					if ($re !~ /($DepLex)/) {
						($he , my $ta1, my $pos1) = split ("_", $he);#<string>
						$he = $Lemma[$pos1];
						($de ,my $ta2, my $pos2) = split ("_", $de);#<string>
						$de = $Lemma[$pos2];
						$triplet = "$re;$he\_$ta1\_$pos1;$de\_$ta2\_$pos2" ;
					}
					if($pipe){#<ignore-line>
						print "($triplet)\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,"($triplet)");
					}#<ignore-line>
				}
				##final de analise de frase:
				if($pipe){#<ignore-line>
					print "---\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida,"---");
				}#<ignore-line>
			}
###SAIDA ANALISADOR COM ESTRUTURA ATRIBUTO-VALOR (full analysis)
			elsif ($flag eq "-fa") {
				##Escrever a oraçao que vai ser analisada:
				if($pipe){#<ignore-line>
					print "SENT::$seq\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida,"SENT::$seq");
				}#<ignore-line>
				#print STDERR "LIST:: $listTags\n";
				####imprimir Hash de dependencias ordenado:
				my $re="";#<string>
				foreach my $triplet (sort {$Ordenar{$a} <=>
					$Ordenar{$b} }
					keys %Ordenar ) {
					$triplet =~ s/^\(//;
					$triplet =~ s/\)$//;
					($re, my $he,my $de) =  split (";", $triplet);#<string>

					if ($re !~ /($DepLex)/) { ##se rel nao e lexical
						my ($he1, $ta1, $pos1) = split ("_", $he);#<string>
						$he1 = $Lemma[$pos1];
						my ($de2 ,$ta2, $pos2) = split ("_", $de);#<string>
						$de2 = $Lemma[$pos2];
						$triplet = "$re;$he1\_$ta1\_$pos1;$de2\_$ta2\_$pos2";
					}
					if($pipe){#<ignore-line>
						print "($triplet)\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,"($triplet)");
					}#<ignore-line>

					($he, my $ta, my $pos) = split ("_", $he);#<string>
					my $saida = "HEAD::$he\_$ta\_$pos<";#<string>
					$ATTR[$pos]{"lemma"} = $Lemma[$pos];
					$ATTR[$pos]{"token"} = $Token[$pos];
					foreach my $feat (sort keys %{$ATTR[$pos]}) {
						$saida .= "$feat:$ATTR[$pos]{$feat}|";
					}
					if($pipe){#<ignore-line>
						print "$saida>\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,"$saida>");
					}#<ignore-line>

					($de, $ta, $pos) = split ("_", $de);#<string>
					$saida = "DEP::$de\_$ta\_$pos<";
					$ATTR[$pos]{"lemma"} = $Lemma[$pos];
					$ATTR[$pos]{"token"} = $Token[$pos];
					foreach my $feat (sort keys %{$ATTR[$pos]}) {
						$saida .= "$feat:$ATTR[$pos]{$feat}|" ;
					}
					if($pipe){#<ignore-line>
						print "$saida>\n";#<ignore-line>
					}else{#<ignore-line>
						push (@saida,"$saida>");
					}#<ignore-line>

					if ($re =~ /\//) {
						my ($depName, $reUnit) = split ('\/', $re);#<string>
						(my $reLex, $ta, $pos) = split ("_", $reUnit);#<string>
						$saida =  "REL::$reLex\_$ta\_$pos<";
						$ATTR[$pos]{"lemma"} = $Lemma[$pos];
						$ATTR[$pos]{"token"} = $Token[$pos];
						foreach my $feat (sort keys %{$ATTR[$pos]}) {
							$saida .= "$feat:$ATTR[$pos]{$feat}|" ;
						}
						if($pipe){#<ignore-line>
							print "$saida>\n";#<ignore-line>
						}else{#<ignore-line>
							push (@saida,"$saida>");
						}#<ignore-line>
					}
				}
				##final de analise de frase:
				if($pipe){#<ignore-line>
					print "---\n";#<ignore-line>
				}else{#<ignore-line>
					push (@saida,"---");
				}#<ignore-line>
			}
    
			##Colocar numa lista vazia os strings com os tags (listTags) e a oraçao (seq)
			##Borrar hash ordenado de triplets

			$i=0;
			$j=0;
			$listTags="";
			$seq="";
			%Ordenar=();
			@Token=();
			@Tag=();
			@Lemma=();
			@Attributes=();
			@ATTR=();  
	   
		} ##fim do elsif

	}

	#print "\n";
	return \@saida;
}


sub HeadDep {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Head = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Dep =~ /[\w]+_([0-9]+)/);


		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			my $Rel =  $y ;#<string>
			$Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && 
				($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) && ##a modificar: so no caso de que atr = number or genre (N = invariable or neutral)
				($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "") ) {

				$found=1;
				}
			}

			# print STDERR "Found: $found\n";
			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				my $Rel =  $y ;#<string>
				$Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
			}
		}
	}
}


sub DepHead {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	# print STDERR "-$y-, -$z-, -@x-\n";

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			my $Rel =  $y;#<string>
			$Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;

		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) &&
				 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "") ) {
				$found=1;
				}
			}

			#  print STDERR "Found: $found\n";
			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
				$found=0;
			} else  {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
				$found=0;
				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				my $Rel =  $y;#<string>
				$Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
			}
		}
	}
}


sub DepRelHead {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Rel = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
					($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
					($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found=1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;


				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}";
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub HeadRelDep {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Head = $x->[$m];#<string>
		$m++;
		my $Rel = $y . "_" . $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);


		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) && 
				 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found=1;
				}
			}

			if ($found)  {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}";
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}";
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub RelDepHead {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Rel = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
				 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found=1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;


				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub RelHeadDep {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Rel = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
				($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
				($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
				$found = 1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub DepHeadRel {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>
		$m++;
		my $Rel = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
					($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
					($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found = 1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}";
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
			}
		}
	}
}


sub HeadDepRel {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $n3=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Head = $x->[$m];#<string>
		$m++;
		my $Rel = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
		($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}";
			$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}";
			$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}";

			$Ordenar{"($Rel;$Head;$Dep)"} = $n3;
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
					($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
					($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
					$found=1;
				}
			}

			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:1\|/;
				$found=0;

				$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

				$Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;
			}
		}
	}
}


sub HeadDep_lex {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Head = $x->[$m];#<string>
		$m++;
		my $Dep = $x->[$m];#<string>
		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			#$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Head = "$ATTR[$n1]{'lemma'}_$Tag[$n1]_${n1}" ;
			my $Rel =  $y;#<string>
			#$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$ATTR[$n2]{'lemma'}_$Tag[$n2]_${n2}" ;

			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
			#print STDERR "head::$Head -- dep:::$Dep\n";

			if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} . "\@$Lemma[$n2]" ;
				# $ATTR_token{$n1} = $ATTR[$n1]{"token"} .  "\@$Token[$n2]";
				$IDF{$n1}++;
			} elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} .  "\@$ATTR_lemma{$n2}" ;
				#$ATTR_token{$n1} = $ATTR[$n1]{"token"} .   "\@$ATTR_token{$n2}";
				$IDF{$n1}++;
			} elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} .=   "\@$Lemma[$n2]";
				#$ATTR_token{$n1} .=   "\@$Token[$n2]";
			} else {
				$ATTR_lemma{$n1} .=    "\@$ATTR_lemma{$n2}" ;
				#$ATTR_token{$n1} .=    "\@$ATTR_token{$n2}";
			}
			#print STDERR "$n1::: $ATTR_lemma{$n1} -- $ATTR_token{$n1} \n";
		} else {
			foreach my $atr (@z) {
				if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) &&
				 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "") ) {
					$found = 1;
				}
			}

			# print STDERR "Found: $found\n";
			if ($found) {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
				$found=0;
			} else {
				$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
				$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
				$found=0;

				#$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
				$Head = "$ATTR[$n1]{'lemma'}_$Tag[$n1]_${n1}";
				my $Rel =  $y;#<string>
				#$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
				$Dep =  "$ATTR[$n2]{'lemma'}_$Tag[$n2]_${n2}";

				$Ordenar{"($Rel;$Head;$Dep)"} = $n2;

				if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
					$ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} . "\@$Lemma[$n2]" ;
					# $ATTR_token{$n1} = $ATTR[$n1]{"token"} .  "\@$Token[$n2]";
					$IDF{$n1}++;
				} elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
					$ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} .  "\@$ATTR_lemma{$n2}" ;
					#$ATTR_token{$n1} = $ATTR[$n1]{"token"} .   "\@$ATTR_token{$n2}";
					$IDF{$n1}++;
				} elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
					$ATTR_lemma{$n1} .=   "\@$Lemma[$n2]" ;
					#$ATTR_token{$n1} .=   "\@$Token[$n2]";
				} else {
					$ATTR_lemma{$n1} .=    "\@$ATTR_lemma{$n2}";
					#$ATTR_token{$n1} .=    "\@$ATTR_token{$n2}";
				}
			}
		}
		$Lemma[$n1] = $ATTR_lemma{$n1};
		# $Token[$n1] = $ATTR_token{$n1};
	}
}


sub DepHead_lex {

	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $found=0;#<boolean>

	my @z = split (",", $z);#<array><string>

	for (my $m=0;$m<$size;$m++) {#<integer>
		my $Dep = $x->[$m];#<string>
		$m++;
		my $Head = $x->[$m];#<string>

		($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

		if ($z eq "") {
			#$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Head = "$ATTR[$n1]{'lemma'}_$Tag[$n1]_${n1}" ;
			my $Rel =  $y;#<string>
			#$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$ATTR[$n2]{'lemma'}_$Tag[$n2]_${n2}" ;
			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;

			#print STDERR "OKKKK: #$Dep - $n2#\n";
			if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} = $ATTR[$n2]{"lemma"} . "\@$Lemma[$n1]" ;
				#$ATTR_token{$n1} = $ATTR[$n2]{"token"} .  "\@$Token[$n1]";
				$IDF{$n1}++;
			} elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} =   "$ATTR_lemma{$n2}\@"  . $ATTR[$n1]{"lemma"}  ;
				#$ATTR_token{$n1} =   "$ATTR_token{$n2}\@" .  $ATTR[$n1]{"token"};
				$IDF{$n1}++;
		} elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
			$ATTR_lemma{$n1} .=   "$Lemma[$n2]\@";
			#$ATTR_token{$n1} .=   "$Token[$n2]\@";
		} else {
			$ATTR_lemma{$n1} .=    "$ATTR_lemma{$n1}\@" ;
			#$ATTR_token{$n1} .=    "$ATTR_token{$n1}\@" ;
		}
	} else {
		foreach my $atr (@z) {
			if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) &&
			 ($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "")  ) {
				$found=1;
			}
		}
		# print STDERR "Found: $found\n";
		if ($found) {
			$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
			$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
			$found=0;
		} else {
			$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
			$listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
			$found=0;
			#$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
			$Head = "$ATTR[$n1]{'lemma'}_$Tag[$n1]_${n1}";
			my $Rel =  $y;#<string>
			#$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
			$Dep =  "$ATTR[$n2]{'lemma'}_$Tag[$n2]_${n2}";
			$Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;

			if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} = $ATTR[$n2]{"lemma"} . "\@$Lemma[$n1]" ;
				#$ATTR_token{$n1} = $ATTR[$n2]{"token"} .  "\@$Token[$n1]";
				$IDF{$n1}++;
			} elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} =   "$ATTR_lemma{$n2}\@"  . $ATTR[$n1]{"lemma"}  ;
				#$ATTR_token{$n1} =   "$ATTR_token{$n2}\@" .  $ATTR[$n1]{"token"};
				$IDF{$n1}++;
			} elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
				$ATTR_lemma{$n1} .=   "$Lemma[$n2]\@";
				#$ATTR_token{$n1} .=   "$Token[$n2]\@";
			} else {
				$ATTR_lemma{$n1} .=    "$ATTR_lemma{$n1}\@";
				#$ATTR_token{$n1} .=    "$ATTR_token{$n1}\@";
			}
		}
	}
	$Lemma[$n1] = $ATTR_lemma{$n1} ;
	#$Token[$n1] = $ATTR_token{$n1} ;
	}
}



sub Head {
	(my $y, my $z,#<string>
	my $x) = @_ ;#<ref><array><string>

	return 1;
}


sub LEX {

	foreach my $idf (keys %IDF) {
		#print STDERR "idf = $idf";

		##parche para \2... \pi...:
		# $ATTR[$idf]{"lemma"}  =~ s/[\\]/\\\\/g ;
		# $ATTR[$idf]{"token"}  =~ s/[\\]/\\\\/g ;

		$listTags =~ s/($Tag[$idf]_${idf}${l})lemma:$ATTR[$idf]{'lemma'}/${1}lemma:$ATTR_lemma{$idf}/;
		# $listTags =~ s/($Tag[$idf]_${idf}${l})token:$ATTR[$idf]{"token"}/${1}token:$ATTR_token{$idf}/;

		delete $IDF{$idf};
		delete $ATTR_lemma{$idf};
		#delete $ATTR_token{$idf};
	}
}


##Operaçoes Corr, Inherit, Add, 
sub Corr {

	(my $z, my $y,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $atr="";#<string>
	my $value="";#<string>
	my $info="";#<string>
	my $attribute="";#<string>
	my $entry="";#<string>

	my @y = split (",", $y);#<array><string>


	if ($z eq "Head") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;

			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;

				##token:=lemma / lemma:=token
				if ($value =~ /^=/) {
					$value =~ s/^=//;
					$ATTR[$n1]{$atr} = $ATTR[$n1]{$value} ;
					if ($value eq "token") {
						$Lemma[$n1] = $ATTR[$n1]{$value} ;
					} elsif ($value eq "lemma") {
						$Token[$n1] = $ATTR[$n1]{$value} ;
					}
				} 
				##change the PoS tag:
				elsif ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$entry = "${value}_${n1}_<";
					if (activarTags($value,$n1)) {
						foreach my $attribute (sort keys %{$ATTR[$n1]}) {
							#print STDERR "--atribs: $attribute\n";      
							if (defined $TagStr{$attribute}) {
								$entry .= "$attribute:$ATTR[$n1]{$attribute}|" ;
								#print STDERR "atribute defined : $attribute --$entry\n";
							} else {
								#$entry .= "$attribute:$TagStr{$attribute}|" ;
								delete $ATTR[$n1]{$attribute} ;
								#print STDERR "++entry : $entry\n";
							} 
						}

						foreach my $attribute (sort keys %TagStr) {
							#print STDERR "++atribs: $attribute\n";      
							if (!defined $ATTR[$n1]{$attribute}) {
								$entry .= "$attribute:$ATTR[$n1]{$attribute}|" ;
								$ATTR[$n1]{$attribute} = $TagStr{$attribute};
								#print STDERR "++atribute defined : $attribute --$entry\n";
							}
						}
					}
					$entry .= ">";
					#print STDERR  "--$entry\n" ;
					$listTags =~ s/$Tag[$n1]_$n1$a2/$entry/;
					$Tag[$n1] = $value;
					desactivarTags($value);
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};  
					}
				}
			}
		}
	}
}


sub Inherit {

	(my $z, my $y,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>

	my @y = split (",", $y);#<array><string>

	if ($z eq "DepHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "HeadDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "DepRelHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m +=2;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "HeadRelDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m +=2;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "RelDepHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			$m++;
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "RelHeadDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			$m++;
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
			}
		}
	} elsif ($z eq "DepHeadRel") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};               
			}
		}
	} elsif ($z eq "HeadDepRel") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr}; 
			}
		}
	} elsif ($z eq "DepHead_lex") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/);
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
					$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr}; 
			}
		}
	} elsif ($z eq "HeadDep_lex") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $atr (@y) {
				if (!$ATTR[$n1]{$atr}) {
					$listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
				} else {
					$listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
				}
				$ATTR[$n1]{$atr} = $ATTR[$n2]{$atr}; 
			}
		}
	}
}


sub Add {

	(my $z, my $y,#<string>
	my $x) = @_ ;#<ref><array><string>
	my $size = @{$x};#<integer>
	my $n1=0;#<integer>
	my $n2=0;#<integer>
	my $atr="";#<string>
	my $value="";#<string>
	my $info="";#<string>

	my @y = split (",", $y);#<array><string>

 
	if ($z eq "Head") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;
				if ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
                                        my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					my $feat2 = $feat;
					$feat2 =~ s/\|/\\|/g;
					$listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					my @feat = split ('\|', $feat); 
					push (@feat,$info);
					@feat = sort (@feat); 
					$feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;    

					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
				}
			}
		}
	} elsif ($z eq "DepHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/);
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $info (@y) {
				($atr, $value) = split (":", $info);
				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
					#print STDERR "$atr - $value : #$l# - #$r#";
					} else {
					    my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					    #$listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;

					     $ATTR[$n1]{$atr} = $value;
					     if ($atr eq "lemma") {
							$Lemma[$n1] = $ATTR[$n1]{"lemma"};
				}
				if ($atr eq "token") {
					$Token[$n1] = $ATTR[$n1]{"token"};
				}
				#print STDERR "$atr - $value ::: #$l# - #$r#";
				}
			}
		}
	} elsif ($z eq "HeadDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					    my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
					    $ATTR[$n1]{$atr} = $value; 
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
				            }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} elsif ($z eq "DepRelHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m+=2;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					 my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;

					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} elsif ($z eq "HeadRelDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m +=2;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
				$ATTR[$n1]{$atr} = $value;
				$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
				$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					 my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} elsif ($z eq "RelDepHead") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			$m++;
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach my $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					 my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					 
					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} elsif ($z eq "RelHeadDep") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			$m++;
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
					 my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} elsif ($z eq "DepHeadRel") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags  =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
				            my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} elsif ($z eq "HeadDepRel") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
					$ATTR[$n1]{$atr} = $value;
				if ($atr eq "lemma") {
					$Lemma[$n1] = $ATTR[$n1]{"lemma"};
				}
				if ($atr eq "token") {
					$Token[$n1] = $ATTR[$n1]{"token"};
				}
				$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
				            my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} elsif ($z eq "DepHead_lex") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Dep = $x->[$m];#<string>
			$m++;
			my $Head = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
					$listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
				} else {
				            my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
				}
			}
		}
	} 

	if ($z eq "HeadDep_lex") {
		for (my $m=0;$m<$size;$m++) {#<integer>
			my $Head = $x->[$m];#<string>
			$m++;
			my $Dep = $x->[$m];#<string>
			($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
			($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  

			foreach $info (@y) {
				($atr, $value) = split (":", $info) ;

				##change the PoS tag:
				if ($atr =~ /^tag/) {
					$ATTR[$n1]{$atr} = $value;
				        $listTags =~ s/$Tag[$n1]_${n1}/${value}_${n1}/;
					$Tag[$n1] = $value;
				} elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
					$ATTR[$n1]{$atr} = $value;
					if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					}
					if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					}
					$listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}${info}\|/;
				} else {
				            my ($feat) = $listTags =~/$Tag[$n1]_${n1}_<([^>]+)>/;
					    my $feat2 = $feat;
					    $feat2 =~ s/\|/\\|/g;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)$feat2/${1}/;
					   
					    my @feat = split ('\|', $feat); 
					    push (@feat,$info);
					    @feat = sort (@feat); 
					    $feat = join("|",@feat);
					   # $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
					    $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}${feat}\|/;
					
					    $ATTR[$n1]{$atr} = $value;
					    if ($atr eq "lemma") {
						$Lemma[$n1] = $ATTR[$n1]{"lemma"};
					    }
					    if ($atr eq "token") {
						$Token[$n1] = $ATTR[$n1]{"token"};
					    }
					#print STDERR "$atr - $value ::: #$l# - #$r#";
				}
			}
		}
	} 
}


sub negL {

	my ($x) = @_ ;#<string>
	my $expr="";#<string>
	my $ref="";#<string>
	my $CAT="";#<string>

	($CAT, $ref) = split ("_", $x);  
	$expr = "(?<!${CAT})\\_$ref";


	return $expr;
}


sub negR {

	my ($x) = @_ ;#<string>
	my $expr="";#<string>
	my $ref="";#<string>
	my $CAT="";#<string>

	($CAT, $ref) = split ("_", $x); 
	$expr = "?!${CAT}\\_$ref";

	return $expr;
}



sub activarTags {

	my ($x, #<string>
	$pos) = @_ ; #<integer>

	##shared attributes:
	# $TagStr{"tag"} = 0;
	$TagStr{"lemma"} = 0;
	$TagStr{"token"} = 0;

	if ($x =~ /^PRO/) {
		$TagStr{"type"} = 0;
		$TagStr{"person"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"case"} = 0;
		$TagStr{"possessor"} = 0;
		$TagStr{"politeness"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	##conjunctions:
	elsif ($x =~ /^C/) {
		$TagStr{"type"} =  0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	##interjections:
	elsif ($x =~ /^I/) {
		$TagStr{"type"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	##numbers
	elsif ($x =~  /^CARD/) {
		$TagStr{"number"} = "P";
		$TagStr{"person"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	##dates
	elsif ($x =~  /^DATE/) {
		$TagStr{"number"} = 0;
		$TagStr{"person"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	elsif ($x =~ /^ADJ/) {
		$TagStr{"type"} = 0;
		$TagStr{"degree"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"function"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	elsif ($x =~ /^ADV/) {
		$TagStr{"type"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
	elsif ($x =~ /^PRP/) {
		$TagStr{"type"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
	}
   elsif ($x =~ /^NOUN/) {    
		$TagStr{"type"} = 0 ;
		$TagStr{"gender"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"person"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
   }
   elsif ($x =~ /^DT/) {
		$TagStr{"type"} = 0;
		$TagStr{"person"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"possessor"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;
   }
  ##mudar tags nos verbos:
   elsif ($x =~ /^VERB/) {
		$TagStr{"type"} = 0;
		$TagStr{"mode"} = 0;
		$TagStr{"tense"} = 0;
		$TagStr{"person"} = 0;
		$TagStr{"number"} = 0;
		$TagStr{"gender"} = 0;
		$TagStr{"pos"} = $pos;
		return 1;  
   }
   else {
		return 0;
   }
}


sub desactivarTags {

	my ($x) = @_ ; #<string>

	delete $TagStr{"type"} ;
	delete $TagStr{"person"};
	delete $TagStr{"gender"} ;
	delete $TagStr{"number"} ;
	delete $TagStr{"case"} ;
	delete $TagStr{"possessor"} ;
	delete $TagStr{"politeness"} ;
	delete $TagStr{"mode"} ;
	delete $TagStr{"tense"} ;
	delete $TagStr{"function"} ;
	delete $TagStr{"degree"} ;
	delete $TagStr{"pos"} ;     

	delete $TagStr{"lemma"} ;
	delete $TagStr{"token"} ;
	# delete $TagStr{"tag"} ;
	return 1;
}


sub ConvertChar {

	my ($x, $y) = @_ ;#<string>

	$info =~ s/lemma:$x/lemma:\*$y\*/g; 
	$info =~ s/token:$x/token:\*$y\*/g;

}

sub ReConvertChar {

	my ($x, $y, $z) = @_ ;#<string>

	$Attributes[$z] =~ s/lemma:\*$y\*/lemma:$x/g;
	$Attributes[$z] =~ s/token:\*$y\*/token:$x/g;
	$ATTR[$z]{"lemma"} =~ s/\*$y\*/$x/g;
	$ATTR[$z]{"token"} =~ s/\*$y\*/$x/g;
	$Token[$z] =~ s/\*$y\*/$x/g;
	$Lemma[$z] =~ s/\*$y\*/$x/g;
}

#<ignore-block>
if($pipe){
	my @lines=<STDIN>;
	parse(\@lines, shift(@ARGV));
}
#<ignore-block>
