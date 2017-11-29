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
my $AdvTemp  = "(?:hoy\|mañana\|ayer\|amanhã\|hoje\|ontem\|mañá\|hoxe\|onte\|today\|yesterday\|tomorrow\|)";#<string>
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
my $VSrefleja  = "(?:acabar\|agotar\|apuntar\|desencadenar\|filtrar\|importar\|informar\|\|producir\|quebrar\|)";#<string>
my $VSind  = "(?:agradar\|apasionar\|apetecer\|\|asombrar\|\|cundir\|desagradar\|encantar\|extrañar\|faltar\|gustar\|interesar\|sorprender\|)";#<string>
my $VS  = "(?:abundar\|aflorar\|agradar\|anidar\|aparecer\|apasionar\|arder\|bastar\|bramar\|brillar\|brotar\|caber\|cesar\|circular\|comenzar\|comparecer\|concluir\|concurrir\|constar\|contrastar\|convenir\|cuajar\|danzar\|desfilar\|despuntar\|doler\|empezar\|\|estallar\|existir\|faltar\|fascinar\|fastidiar\|figurar\|finalizar\|fracasar\|gustar\|hinchar\|holgar\|imperar\|\|intervenir\|latir\|mediar\|ocurrir\|parecer\|perdurar\|predominar\|\|puntualizar\|rechinar\|reinar\|replicar\|reventar\|rugir\|sentenciar\|sobrar\|sobrevenir\|sobrevivir\|sonar\|suceder\|surgir\|temblar\|terciar\|transcurrir\|urgir\|)";#<string>
my $SubcatIND  = "(?:dar\|agradar\|gustar\|parecer\|hacer\|decir\|preguntar\|pedir\|pasar\|poner\|ocurrir\|atribuir\|hablar\|ofrecer\|contar\|entregar\|echar\|importar\|interesar\|dejar\|quitar\|servir\|tocar\|encantar\|prestar\|escribir\|dirigir\|dedicar\|corresponder\|explicar\|permitir\|añadir\|regalar\|enseñar\|sonreír\|devolver\|enviar\|presentar\|aportar\|deber\|exigir\|llevar\|quedar\|faltar\|abrir\|imponer\|tener\|proponer\|pagar\|comunicar\|ordenar\|conceder\|sacar\|ser\|mandar\|costar\|mostrar\|agregar\|escapar\|llegar\|venir\|asignar\|otorgar\|caer\|negar\|traer\|ver\|arrancar\|molestar\|remitir\|resultar\|ceder\|suceder\|atraer\|meter\|recordar\|tender\|adeudar\|vender\|causar\|aplicar\|pegar\|cerrar\|plantear\|agradecer\|consultar\|contestar\|encargar\|rendir\|comprar\|imprimir\|ocultar\|salir\|demostrar\|tomar\|exponer\|cortar\|restar\|confesar\|asegurar\|confiar\|convenir\|encontrar\|agradar\|gritar\|perder\|recomendar\|impedir\|robar\|llamar\|achacar\|entrar\|facilitar\|prometer\|solicitar\|coger\|caber\|hurtar\|advertir\|proporcionar\|bastar\|comentar\|conferir\|doler\|extrañar\|producir\|adjudicar\|evitar\|avisar\|brindar\|suponer\|indicar\|arrebatar\|chocar\|cantar\|valer\|olvidar\|referir\|prender\|suplicar\|arengar\|imputar\|revelar\|sorprender\|aconsejar\|buscar\|plantar\|reclamar\|repetir\|envidiar\|replicar\|levantar\|perdonar\|relatar\|sugerir\|guardar\|reprochar\|afectar\|procurar\|adeudar\|arengar\|hurtar\|)";#<string>
my $SubcatA  = "(?:acceder\|acercar\|acertar\|acostumbrar\|acudir\|adaptar\|afectar\|aferrar\|aficionar\|afiliar\|ajustar\|aludir\|apelar\|apostar\|apresurar\|aproximar\|arrimar\|arrojar\|asistir\|asomar\|atener\|atinar\|atrever\|avenir\|comprometer\|conducir\|contribuir\|corresponder\|deber\|dedicar\|dirigir\|disponer\|enfrentar\|equivaler\|exponer\|inducir\|invitar\|ir\|limitar\|llegar\|mudar\|negar\|obligar\|oler\|oponer\|pertenecer\|precipitar\|proceder\|recurrir\|referir\|regresar\|remontar\|renunciar\|resignar\|resistir\|someter\|subir\|sumar\|sustraer\|tender\|trasladar\|unir\|vincular\|volver\|ir\|llegar\|llevar\|volver\|venir\|acercar\|salir\|referir\|dirigir\|atrever\|dedicar\|obligar\|dar\|pasar\|pertenecer\|disponer\|asistir\|subir\|acudir\|responder\|regresar\|ayudar\|mirar\|invitar\|jugar\|asomar\|negar\|limitar\|sentar\|renunciar\|bajar\|enfrentar\|aprender\|echar\|afectar\|conducir\|entrar\|llamar\|tender\|esperar\|correr\|decidir\|reducir\|destinar\|corresponder\|hacer\|someter\|aludir\|entregar\|unir\|deber\|contribuir\|resistir\|arrojar\|mandar\|oler\|recurrir\|acompañar\|oponer\|acostumbrar\|acceder\|caer\|aplicar\|estar\|aproximar\|lanzar\|trasladar\|traer\|proceder\|apresurar\|poner\|condenar\|enseñar\|quedar\|enviar\|adaptar\|ajustar\|tirar\|exponer\|incorporar\|escapar\|sacar\|atener\|forzar\|animar\|marchar\|acertar\|devolver\|agarrar\|aspirar\|presentar\|saltar\|retirar\|extender\|ascender\|comprometer\|parar\|remitir\|aferrar\|abrazar\|resignar\|apostar\|pegar\|contestar\|seguir\|arrimar\|prestar\|elevar\|obedecer\|avenir\|largar\|ceder\|sumar\|precipitar\|viajar\|preferir\|adelantar\|remontar\|apuntar\|equivaler\|abrir\|mover\|inclinar\|sustraer\|acoger\|atañer\|impulsar\|desplazar\|abandonar\|inducir\|asemejar\|plegar\|subyacer\|atender\|sujetar\|imponer\|sobreponer\|transportar\|adecuar\|empujar\|instar\|dejar\|encaminar\|encontrar\|transmitir\|declarar\|equiparar\|vivir\|incitar\|sobrevivir\|colocar\|sonar\|rendir\|autorizar\|aguardar\|ofrecer\|reintegrar\|arrastrar\|levantar\|tocar\|mudar\|arriesgar\|cerrar\|traducir\|descender\|probar\|retornar\|aficionar\|sucumbir\|concurrir\|consagrar\|convocar\|doblar\|atinar\|comparar\|anticipar\|comparecer\|vincular\|apelar\|tener\|cruzar\|cambiar\|exhortar\|hallar\|afiliar\|liar\|preparar\|resolver\|asociar\|optar\|saber\|meter\|rebajar\|decir\|sacrificar\|señalar\|apestar\|instalar\|partir\|resbalar\|propender\|retroceder\|alcanzar\|relegar\|aventurar\|denunciar\|huir\|anteponer\|cooperar\|ligar\|sentir\|supeditar\|ceñir\|faltar\|impeler\|mezclar\|subordinar\|figurar\|jugar\|)";#<string>
my $SubcatDE  = "(?:hablar\|tratar\|salir\|dar\|sacar\|acordar\|venir\|hacer\|saber\|pasar\|enterar\|servir\|cambiar\|depender\|ocupar\|ir\|separar\|apartar\|carecer\|disponer\|acusar\|alejar\|opinar\|encargar\|huir\|echar\|convencer\|olvidar\|tirar\|llenar\|bajar\|levantar\|librar\|llegar\|despedir\|gozar\|quitar\|colgar\|tomar\|dudar\|informar\|provenir\|pensar\|reír\|escapar\|coger\|encoger\|quedar\|quejar\|enamorar\|vestir\|entender\|apoderar\|desprender\|disfrutar\|extraer\|surgir\|decir\|proceder\|nacer\|vivir\|regresar\|traer\|recibir\|arrancar\|alegrar\|brotar\|prescindir\|derivar\|volver\|descender\|defender\|retirar\|burlar\|necesitar\|esperar\|salvar\|preocupar\|partir\|aprovechar\|despojar\|participar\|mover\|distinguir\|dejar\|desaparecer\|presumir\|llevar\|avergonzar\|liberar\|percatar\|cansar\|marchar\|saltar\|privar\|caer\|emerger\|cubrir\|fiar\|aprender\|abstener\|adueñar\|cerciorar\|arrepentir\|perder\|desconfiar\|heredar\|borrar\|gustar\|desligar\|alimentar\|reponer\|desviar\|distar\|proveer\|rescatar\|subir\|abusar\|cuidar\|conocer\|contar\|aislar\|llorar\|equivocar\|deducir\|disfrazar\|distraer\|excluir\|avisar\|despegar\|dotar\|sospechar\|apropiar\|apear\|armar\|desentender\|diferenciar\|emanar\|preservar\|recoger\|agarrar\|deshacer\|extrañar\|persuadir\|constar\|valer\|asegurar\|cruzar\|desistir\|vengar\|pender\|diferir\|renegar\|resultar\|sorprender\|proteger\|vaciar\|alardear\|cargar\|desembarazar\|mudar\|expulsar\|elevar\|impregnar\|limpiar\|bastar\|componer\|despertar\|absolver\|obtener\|predicar\|matricular\|descargar\|extender\|asombrar\|escurrir\|apiadar\|asustar\|querer\|alzar\|arrojar\|comportar\|evadir\|protestar\|recuperar\|desvincular\|esconder\|examinar\|jactar\|redimir\|aburrir\|adolecer\|escribir\|rodear\|disuadir\|empezar\|hartar\|recelar\|seguir\|charlar\|trasladar\|exigir\|acompañar\|curar\|beneficiar\|ser\|abstener\|abusar\|acordar\|acusar\|adueñar\|aislar\|alegrar\|apartar\|apiadar\|apoderar\|apropiar\|avergonzar\|burlar\|carecer\|cerciorar\|convencer\|depender\|derivar\|desconfiar\|desembarazar\|desentender\|despojar\|desprender\|diferenciar\|diferir\|disfrazar\|disfrutar\|dudar\|enamorar\|encargar\|encoger\|enterar\|extraer\|fiar\|gozar\|hablar\|huir\|liberar\|librar\|ocupar\|partir\|percatar\|prescindir\|presumir\|privar\|provenir\|salir\|separar\|tratar\|vestir\|)";#<string>
my $SubcatEN  = "(?:entrar\|pensar\|convertir\|estar\|meter\|vivir\|poner\|encontrar\|quedar\|dejar\|sentar\|caer\|creer\|participar\|fijar\|tardar\|consistir\|pasar\|insistir\|apoyar\|confiar\|nacer\|introducir\|figurar\|residir\|transformar\|ir\|encerrar\|hallar\|instalar\|permanecer\|reparar\|colocar\|situar\|hundir\|intervenir\|echar\|incluir\|refugiar\|guardar\|empeñar\|sentir\|centrar\|esconder\|coincidir\|clavar\|concentrar\|salir\|esforzar\|desembocar\|basar\|despertar\|venir\|penetrar\|envolver\|caber\|mirar\|reflejar\|ingresar\|viajar\|adentrar\|flotar\|inscribir\|besar\|depositar\|distinguir\|seguir\|mantener\|influir\|sumergir\|tomar\|cifrar\|sumir\|golpear\|dudar\|posar\|habitar\|girar\|reconocer\|fundar\|montar\|hurgar\|incurrir\|interesar\|obstinar\|trabajar\|recostar\|matricular\|dividir\|veranear\|actuar\|manifestar\|tirar\|mediar\|ocupar\|oscilar\|colar\|emplear\|reinar\|traer\|acabar\|invertir\|incidir\|infiltrar\|internar\|acomodar\|colaborar\|interponer\|irrumpir\|prorrumpir\|integrar\|precipitar\|descansar\|hacer\|prender\|provocar\|encarnar\|plantar\|inspirar\|parar\|fundir\|asentar\|culminar\|encajar\|repercutir\|retener\|molestar\|radicar\|expresar\|repartir\|convenir\|delegar\|admitir\|volver\|andar\|yacer\|complacer\|citar\|mandar\|tender\|vacilar\|traducir\|verter\|concretar\|leer\|tumbar\|especializar\|gastar\|recrear\|volcar\|empecinar\|demorar\|insertar\|proyectar\|ahondar\|enredar\|hincar\|profundizar\|degenerar\|trocar\|elegir\|implantar\|cagar\|escarbar\|agolpar\|distribuir\|establecer\|investigar\|reclinar\|redundar\|sacar\|servir\|abandonar\|constituir\|descollar\|entretener\|estallar\|localizar\|resolver\|zambullir\|causar\|equivocar\|esmerar\|estimar\|persistir\|soñar\|cejar\|materializar\|pervivir\|reinstalar\|sepultar\|tocar\|transfigurar\|amparar\|imprimir\|inducir\|sustentar\|vegetar\|acodar\|descargar\|gobernar\|llevar\|mecer\|albergar\|construir\|existir\|grabar\|afanar\|plasmar\|reafirmar\|afirmar\|alojar\|colgar\|cruzar\|derramar\|extender\|iniciar\|recaer\|surgir\|acodar\|adentrar\|ahondar\|apoyar\|asentar\|basar\|caer\|centrar\|colar\|complacer\|concentrar\|confiar\|consistir\|convertir\|desembocar\|dividir\|empecinar\|empeñar\|encarnar\|encerrar\|entrar\|envolver\|esconder\|esforzar\|especializar\|fijar\|flotar\|hundir\|hurgar\|incidir\|incurrir\|infiltrar\|influir\|ingresar\|inscribir\|insistir\|instalar\|internar\|introducir\|irrumpir\|materializar\|matricular\|meter\|nacer\|obstinar\|oscilar\|participar\|penetrar\|plantificar\|profundizar\|prorrumpir\|radicar\|recostar\|recrear\|refugiar\|reparar\|repercutir\|residir\|sentar\|situar\|soñar\|sumergir\|sumir\|tardar\|transformar\|tumbar\|veranear\|zambullir\|)";#<string>
my $SubcatCON  = "(?:hablar\|contar\|encontrar\|relacionar\|tener\|quedar\|casar\|acabar\|coincidir\|dar\|comparar\|bastar\|acostar\|identificar\|pasar\|tratar\|soñar\|vivir\|luchar\|reunir\|compartir\|estar\|confundir\|tropezar\|poder\|cubrir\|enfrentar\|cruzar\|mezclar\|romper\|tapar\|entrevistar\|salir\|conversar\|conformar\|ocurrir\|convivir\|comenzar\|contrastar\|amenazar\|empezar\|hacer\|cumplir\|seguir\|topar\|chocar\|pelear\|discutir\|andar\|comunicar\|cargar\|atentar\|unir\|guardar\|lanzar\|llenar\|vestir\|negociar\|enfadar\|combinar\|entender\|colaborar\|disfrutar\|estrellar\|charlar\|fundir\|bailar\|continuar\|comentar\|encarar\|contactar\|reconciliar\|terminar\|despertar\|divertir\|dotar\|concluir\|meter\|rebelar\|conectar\|defender\|protestar\|volver\|arremeter\|suceder\|tocar\|competir\|alternar\|enlazar\|golpear\|apoyar\|pactar\|sentir\|comprometer\|entusiasmar\|acompañar\|comulgar\|envolver\|aparear\|dirigir\|venir\|mandar\|aburrir\|sustituir\|asociar\|concordar\|consultar\|frotar\|intercambiar\|alzar\|compaginar\|corresponder\|permanecer\|enrollar\|atrever\|combatir\|contentar\|insistir\|tirar\|simpatizar\|culminar\|simultanear\|complementar\|completar\|gozar\|asociar\|atentar\|bastar\|coincidir\|colaborar\|comparar\|conectar\|conformar\|confundir\|conversar\|convivir\|encarar\|enlazar\|entrevistar\|identificar\|mezclar\|rebelar\|reconciliar\|relacionar\|soñar\|topar\|tropezar\|)";#<string>
my $SubcatPOR  = "(?:pasar\|entrar\|ir\|preguntar\|dar\|salir\|optar\|pasear\|andar\|interesar\|luchar\|venir\|empezar\|sentir\|preocupar\|cambiar\|sustituir\|meter\|mirar\|subir\|esforzar\|seguir\|llorar\|agarrar\|coger\|poner\|tirar\|pugnar\|pagar\|guiar\|caer\|inclinar\|decidir\|vivir\|caracterizar\|valer\|extender\|juzgar\|abogar\|felicitar\|protestar\|echar\|rezar\|deambular\|velar\|tomar\|adentrar\|asomar\|colar\|cruzar\|quedar\|estar\|vagar\|volver\|circular\|apostar\|trepar\|discurrir\|multiplicar\|brindar\|escurrir\|arrojar\|atravesar\|traer\|substituir\|viajar\|temer\|pronunciar\|pelear\|rondar\|caber\|distinguir\|faltar\|sacar\|abogar\|brindar\|caracterizar\|deambular\|luchar\|optar\|pugnar\|vagar\|velar\|)";#<string>
my $SubcatHACIA  = "(?:volver\|ir\|mirar\|dirigir\|avanzar\|correr\|caminar\|encaminar\|salir\|atraer\|orientar\|sentir\|inclinar\|desviar\|venir\|empujar\|tender\|andar\|señalar\|lanzar\|echar\|llevar\|arrastrar\|desplazar\|partir\|levantar\|conducir\|huir\|apuntar\|cruzar\|saltar\|encaminar\|)";#<string>
my $SubcatSOBRE  = "(?:abalanzar\|)";#<string>
my $SubcatImpers  = "(?:haber\|hacer\|tratar\|bastar\|ser\|llover\|ir\|dar\|nevar\|oler\|anochecer\|amanecer\|parecer\|oscurecer\|doler\|poner\|)";#<string>
my $SubcatBitr  = "(?:dar\|hacer\|pedir\|poner\|decir\|preguntar\|ofrecer\|echar\|atribuir\|dejar\|quitar\|contar\|prestar\|dedicar\|aportar\|deber\|explicar\|permitir\|llevar\|tener\|devolver\|entregar\|exigir\|abrir\|dirigir\|pasar\|imponer\|enviar\|proponer\|sacar\|regalar\|presentar\|conceder\|añadir\|negar\|traer\|otorgar\|recordar\|remitir\|costar\|adeudar\|enseñar\|asignar\|comunicar\|arrancar\|pagar\|rendir\|agregar\|ceder\|meter\|mandar\|tomar\|asegurar\|cerrar\|ver\|imprimir\|cortar\|encontrar\|llamar\|causar\|confesar\|mostrar\|restar\|comprar\|demostrar\|ordenar\|tender\|robar\|coger\|proporcionar\|plantear\|solicitar\|agradecer\|escribir\|exponer\|impedir\|producir\|conferir\|arrebatar\|perder\|prometer\|facilitar\|evitar\|envidiar\|indicar\|ocultar\|avisar\|referir\|vender\|levantar\|advertir\|encargar\|perdonar\|recomendar\|revelar\|buscar\|relatar\|reprochar\|)";#<string>
my $SubcatTr  = "(?:abandonar\|abarcar\|abonar\|abordar\|abrigar\|abrir\|abrochar\|absorber\|acariciar\|acarrear\|acatar\|accionar\|acechar\|acelerar\|acentuar\|aceptar\|aclarar\|acoger\|acometer\|aconsejar\|acreditar\|acumular\|adelantar\|adivinar\|administrar\|admirar\|admitir\|adoptar\|adorar\|adquirir\|advertir\|afilar\|afirmar\|aflojar\|afrontar\|agitar\|agradecer\|agredir\|aguardar\|aguzar\|ahorrar\|alargar\|albergar\|alcanzar\|alegar\|alentar\|aligerar\|alijar\|alisar\|aliviar\|alquilar\|alterar\|alzar\|ampliar\|analizar\|añorar\|anotar\|anular\|anunciar\|apaciguar\|apagar\|aparentar\|aplacar\|aplastar\|aplazar\|aplicar\|aporrear\|aportar\|apreciar\|aprender\|apresar\|apretar\|aprovechar\|apuñalar\|argumentar\|armar\|arrancar\|arrasar\|arrastrar\|arrebatar\|arreglar\|arrogar\|articular\|asaltar\|asegurar\|asesinar\|asimilar\|aspirar\|asumir\|atacar\|atajar\|atraer\|atrapar\|atravesar\|atribuir\|aumentar\|autorizar\|aventurar\|averiguar\|avivar\|bajar\|barrer\|batir\|beber\|bendecir\|blandir\|bloquear\|bordear\|borrar\|buscar\|calar\|calcular\|calentar\|calzar\|captar\|cargar\|causar\|cazar\|celebrar\|ceñir\|cerrar\|citar\|clavar\|cobrar\|cocinar\|coger\|combinar\|cometer\|compartir\|compensar\|completar\|complicar\|componer\|comprar\|comprender\|comprobar\|comunicar\|concebir\|conceder\|condicionar\|confeccionar\|confesar\|confirmar\|conjeturar\|conocer\|conquistar\|conseguir\|conservar\|considerar\|consolidar\|constatar\|constituir\|construir\|consultar\|consumar\|contar\|contemplar\|contener\|contraer\|contratar\|controlar\|convocar\|copiar\|coronar\|corroborar\|cortar\|costar\|crear\|creer\|criticar\|cruzar\|cubrir\|culminar\|cultivar\|cumplir\|cursar\|dañar\|decidir\|declarar\|decretar\|deducir\|defender\|demandar\|demostrar\|denotar\|denunciar\|deplorar\|depositar\|derribar\|derrotar\|desabrochar\|desactivar\|desatar\|desbordar\|descalificar\|descargar\|descartar\|descentralizar\|descifrar\|descolgar\|desconocer\|descorrer\|describir\|descubrir\|desdeñar\|desear\|desechar\|desempeñar\|desenterrar\|deshacer\|designar\|desmentir\|desoír\|despachar\|despegar\|despejar\|desperdiciar\|desplegar\|despreciar\|destacar\|destapar\|desterrar\|destrozar\|destruir\|desvelar\|desviar\|detectar\|determinar\|detestar\|devolver\|devorar\|dibujar\|dictar\|difundir\|dilucidar\|dirimir\|disimular\|disipar\|disolver\|disputar\|distinguir\|divisar\|doblar\|dominar\|echar\|efectuar\|ejecutar\|ejercer\|elaborar\|elegir\|elevar\|eliminar\|elogiar\|eludir\|embarcar\|emitir\|emplear\|emprender\|empujar\|empuñar\|enarbolar\|encarecer\|encarnar\|encauzar\|encender\|encontrar\|encubrir\|enderezar\|enfilar\|enfocar\|enjugar\|enriquecer\|enseñar\|entablar\|entonar\|entorpecer\|entrañar\|entreabrir\|entregar\|entrever\|enumerar\|enviar\|erradicar\|esbozar\|escalar\|escamotear\|esclarecer\|escoger\|escribir\|escrutar\|escuchar\|esgrimir\|espantar\|esperar\|esquivar\|establecer\|estimar\|estimular\|estipular\|estirar\|estrechar\|estrenar\|estropear\|estudiar\|evaluar\|evitar\|evocar\|exaltar\|examinar\|excluir\|excusar\|exhibir\|exigir\|expeler\|experimentar\|explicar\|explorar\|expresar\|extender\|fabricar\|facilitar\|favorecer\|financiar\|fingir\|firmar\|fomentar\|forjar\|formar\|formular\|fortalecer\|forzar\|franquear\|frotar\|fruncir\|fumar\|fundar\|fundir\|ganar\|garantizar\|gastar\|generar\|gestionar\|golpear\|guardar\|habitar\|hacer\|hojear\|humedecer\|ignorar\|iluminar\|ilustrar\|imaginar\|imitar\|impartir\|impedir\|implantar\|implicar\|imponer\|imprimir\|improvisar\|impulsar\|inaugurar\|incendiar\|incluir\|incoar\|incrementar\|indagar\|indicar\|inferir\|infundir\|ingerir\|iniciar\|insinuar\|inspeccionar\|inspirar\|intentar\|intercambiar\|interpretar\|intuir\|invadir\|inventar\|invertir\|investigar\|invocar\|involucrar\|jalar\|juntar\|jurar\|justificar\|juzgar\|ladear\|lamentar\|lamer\|lanzar\|lavar\|leer\|liar\|limar\|limpiar\|liquidar\|llenar\|llevar\|localizar\|lograr\|lucir\|maldecir\|mandar\|manejar\|manifestar\|mantener\|marcar\|mascar\|masticar\|matizar\|medir\|mejorar\|mencionar\|mentar\|merecer\|minar\|modernizar\|modificar\|morder\|mostrar\|motivar\|narrar\|necesitar\|negociar\|neutralizar\|nombrar\|notar\|nublar\|observar\|obtener\|ocultar\|odiar\|ofrecer\|oír\|olvidar\|opinar\|oprimir\|ordenar\|organizar\|otear\|otorgar\|padecer\|pagar\|paladear\|palmear\|palpar\|pedir\|pegar\|pensar\|percibir\|perder\|perfeccionar\|permitir\|persuadir\|pesar\|picar\|pintar\|pisar\|pisotear\|planchar\|planear\|plantar\|plantear\|ponderar\|poner\|poseer\|postergar\|postular\|practicar\|precisar\|predecir\|preferir\|preguntar\|prender\|preparar\|presenciar\|presentir\|preservar\|presidir\|presionar\|prestar\|pretender\|pretextar\|prever\|probar\|proclamar\|procurar\|proferir\|profesar\|prohibir\|prolongar\|prometer\|promocionar\|promover\|pronunciar\|propagar\|propiciar\|propinar\|proponer\|proporcionar\|propugnar\|proseguir\|provocar\|publicar\|pulsar\|quebrantar\|quemar\|querer\|quitar\|rascar\|rasgar\|rastrear\|ratificar\|razonar\|realizar\|reanudar\|rebajar\|rebasar\|recabar\|recetar\|rechazar\|recibir\|reclamar\|recobrar\|recoger\|recomendar\|recomponer\|reconocer\|reconsiderar\|reconstruir\|recordar\|recorrer\|recortar\|recuperar\|redactar\|redoblar\|reducir\|reflejar\|reformar\|reforzar\|regalar\|registrar\|regular\|rehuir\|reiterar\|reivindicar\|relatar\|releer\|rematar\|rememorar\|remover\|renovar\|repartir\|repasar\|repetir\|reponer\|representar\|reprimir\|reprobar\|reprochar\|reproducir\|requerir\|resaltar\|rescatar\|reservar\|resolver\|respetar\|restablecer\|restar\|restaurar\|restregar\|resumir\|retomar\|retrasar\|revelar\|revisar\|revivir\|robar\|rodear\|rogar\|romper\|rozar\|rumiar\|saber\|saborear\|sacar\|sacrificar\|sacudir\|salvaguardar\|salvar\|satisfacer\|secundar\|seguir\|seleccionar\|sembrar\|señalar\|serrar\|servir\|significar\|simular\|solicitar\|solucionar\|soñar\|sopesar\|soportar\|sorber\|sortear\|sospechar\|sostener\|subrayar\|sufrir\|sugerir\|sujetar\|suministrar\|superar\|suplantar\|suponer\|suprimir\|suscitar\|suspender\|sustentar\|sustituir\|tapar\|tararear\|temer\|tener\|tentar\|terminar\|tocar\|tolerar\|tomar\|torcer\|traer\|tragar\|transmitir\|transportar\|traspasar\|trasponer\|trazar\|usar\|utilizar\|vaciar\|valer\|valorar\|velar\|vencer\|vender\|ver\|verificar\|visitar\|vislumbrar\|voltear\|vomitar\|zampar\|zanjar\|)";#<string>
my $SubcatAtr  = "(?:acabar\|actuar\|amanecer\|andar\|antojar\|aparecer\|caer\|considerar\|continuar\|costar\|creer\|dar\|declarar\|definir\|dejar\|ejercer\|encontrar\|erigir\|estar\|hacer\|hallar\|imaginar\|ingresar\|ir\|llamar\|llevar\|manifestar\|mantener\|meter\|mostrar\|nacer\|parecer\|pasar\|permanecer\|poner\|proseguir\|quedar\|resultar\|revelar\|saber\|salir\|seguir\|sentir\|ser\|sonar\|tener\|terminar\|tirar\|titular\|tornar\|trabajar\|transcurrir\|venir\|ver\|vivir\|volver\|yacer\|)";#<string>
my $SubcatODirAtr  = "(?:tener\|dejar\|hacer\|ver\|poner\|llamar\|considerar\|llevar\|mantener\|sentir\|tomar\|oír\|calificar\|encontrar\|creer\|dar\|imaginar\|traer\|estimar\|pasar\|entender\|volver\|juzgar\|definir\|concebir\|utilizar\|declarar\|mirar\|colocar\|escuchar\|hallar\|denominar\|conocer\|conservar\|reconocer\|tachar\|identificar\|tratar\|aceptar\|coger\|)";#<string>
my $SubcatClaus  = "(?:saber\|creer\|querer\|decir\|pensar\|ver\|preguntar\|intentar\|recordar\|permitir\|lograr\|decidir\|desear\|pretender\|hacer\|asegurar\|esperar\|pedir\|explicar\|comprender\|conseguir\|preferir\|necesitar\|suponer\|sentir\|afirmar\|considerar\|tener\|entender\|impedir\|contar\|procurar\|reconocer\|temer\|advertir\|señalar\|dejar\|oír\|indicar\|proponer\|comprobar\|descubrir\|imaginar\|declarar\|confesar\|demostrar\|añadir\|jurar\|admitir\|prometer\|significar\|anunciar\|sospechar\|evitar\|aceptar\|mirar\|fingir\|observar\|contestar\|notar\|olvidar\|mostrar\|manifestar\|negar\|comentar\|mandar\|sostener\|encontrar\|responder\|ordenar\|estimar\|precisar\|ignorar\|exigir\|opinar\|rogar\|soñar\|lamentar\|merecer\|dar\|agregar\|confirmar\|averiguar\|enseñar\|adivinar\|aclarar\|aconsejar\|comunicar\|sugerir\|prever\|subrayar\|repetir\|conocer\|deducir\|destacar\|intuir\|informar\|revelar\|figurar\|gritar\|perdonar\|poner\|resolver\|probar\|avisar\|prohibir\|recomendar\|dudar\|agradecer\|determinar\|apuntar\|criticar\|acordar\|calcular\|solicitar\|juzgar\|reiterar\|reprochar\|simular\|estudiar\|replicar\|tolerar\|insinuar\|ofrecer\|argumentar\|aparentar\|establecer\|percibir\|verificar\|buscar\|presentir\|referir\|escribir\|aprovechar\|alegar\|leer\|amenazar\|denunciar\|garantizar\|desconocer\|escuchar\|implicar\|justificar\|odiar\|reponer\|consentir\|reclamar\|dignar\|hablar\|concebir\|servir\|apreciar\|adelantar\|contemplar\|elegir\|descartar\|reflexionar\|suplicar\|presumir\|puntualizar\|rehuir\|disponer\|rehusar\|notificar\|pretextar\|requerir\|concluir\|estipular\|)";#<string>


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

					# Single: PRP<lemma:pero|because|though|if|whether|while> [X]?
					# Corr: tag:CONJ, type:S
					@temp = ($listTags =~ /($PRP${l}lemma:(?:pero|because|though|if|whether|while)\|${r})(?:$X$a2)?/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($PRP${l}lemma:(?:pero|because|though|if|whether|while)\|${r})($X$a2)?/$1$2/g;
					Corr("Head","tag:CONJ,type:S",\@temp);

					# Single: [NOUN] [Fc]? CONJ<lemma:que> [NOUN] [VERB]
					# Corr: tag:PRO, type:R
					@temp = ($listTags =~ /(?:$NOUN$a2)(?:$Fc$a2)?($CONJ${l}lemma:que\|${r})(?:$NOUN$a2)(?:$VERB$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($NOUN$a2)($Fc$a2)?($CONJ${l}lemma:que\|${r})($NOUN$a2)($VERB$a2)/$1$2$3$4$5/g;
					Corr("Head","tag:PRO,type:R",\@temp);

					# Single: [X<lemma:lo>] CONJ<lemma:que>
					# Corr: tag:PRO, type:R
					@temp = ($listTags =~ /(?:$X${l}lemma:lo\|${r})($CONJ${l}lemma:que\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($X${l}lemma:lo\|${r})($CONJ${l}lemma:que\|${r})/$1$2/g;
					Corr("Head","tag:PRO,type:R",\@temp);

					# Single: X<lemma:lo> [PRO<lemma:que>]
					# Corr: tag:DET, type:A
					@temp = ($listTags =~ /($X${l}lemma:lo\|${r})(?:$PRO${l}lemma:que\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($X${l}lemma:lo\|${r})($PRO${l}lemma:que\|${r})/$1$2/g;
					Corr("Head","tag:DET,type:A",\@temp);

					# Single: [X]? CONJ<lemma:pero>
					# Corr: type:S
					@temp = ($listTags =~ /(?:$X$a2)?($CONJ${l}lemma:pero\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($X$a2)?($CONJ${l}lemma:pero\|${r})/$1$2/g;
					Corr("Head","type:S",\@temp);

					# Single: [X]? NOUN<lemma:$AdvTemp>
					# Corr: tag:ADV
					@temp = ($listTags =~ /(?:$X$a2)?($NOUN${l}lemma:$AdvTemp\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($X$a2)?($NOUN${l}lemma:$AdvTemp\|${r})/$1$2/g;
					Corr("Head","tag:ADV",\@temp);

					# Single: VERB<token:[cC]reo> [X]? [X<lemma:que>]
					# Corr: lemma:creer
					@temp = ($listTags =~ /($VERB${l}token:[cC]reo\|${r})(?:$X$a2)?(?:$X${l}lemma:que\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}token:[cC]reo\|${r})($X$a2)?($X${l}lemma:que\|${r})/$1$2$3/g;
					Corr("Head","lemma:creer",\@temp);

					# Single: X<token:–> [X]
					# Corr: tag:Fe
					@temp = ($listTags =~ /($X${l}token:–\|${r})(?:$X$a2)/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($X${l}token:–\|${r})($X$a2)/$1$2/g;
					Corr("Head","tag:Fe",\@temp);

					# Single: [X<lemma:este>] X<lemma:lunes|martes|miércoles|jueves|viernes|sábado|domingo>
					# Corr: tag:DATE
					@temp = ($listTags =~ /(?:$X${l}lemma:este\|${r})($X${l}lemma:(?:lunes|martes|miércoles|jueves|viernes|sábado|domingo)\|${r})/g);
					$Rel =  "Single";
					Head($Rel,"",\@temp);
					$listTags =~ s/($X${l}lemma:este\|${r})($X${l}lemma:(?:lunes|martes|miércoles|jueves|viernes|sábado|domingo)\|${r})/$1$2/g;
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

					# <: X<lemma:momento|minuto|segundo|hora|día|mes|año|semana|siglo> X<lemma:antes|después>
					# Add: tag:DATE
					@temp = ($listTags =~ /($X${l}lemma:(?:momento|minuto|segundo|hora|día|mes|año|semana|siglo)\|${r})($X${l}lemma:(?:antes|después)\|${r})/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					$listTags =~ s/($X${l}lemma:(?:momento|minuto|segundo|hora|día|mes|año|semana|siglo)\|${r})($X${l}lemma:(?:antes|después)\|${r})/$2/g;
					LEX();
					Add("DepHead_lex","tag:DATE",\@temp);

					# >: X<lemma:lunes|martes|miércoles|jueves|viernes|sábado|domingo> Fc [DATE]
					# NEXT
					# <: X<lemma:lunes|martes|miércoles|jueves|viernes|sábado|domingo> [Fc]? DATE
					@temp = ($listTags =~ /($X${l}lemma:(?:lunes|martes|miércoles|jueves|viernes|sábado|domingo)\|${r})($Fc$a2)(?:$DATE$a2)/g);
					$Rel =  ">";
					HeadDep_lex($Rel,"",\@temp);
					@temp = ($listTags =~ /($X${l}lemma:(?:lunes|martes|miércoles|jueves|viernes|sábado|domingo)\|${r})(?:$Fc$a2)?($DATE$a2)/g);
					$Rel =  "<";
					DepHead_lex($Rel,"",\@temp);
					$listTags =~ s/($X${l}lemma:(?:lunes|martes|miércoles|jueves|viernes|sábado|domingo)\|${r})($Fc$a2)?($DATE$a2)/$3/g;
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

					# PunctR: NOUN Fc [ADJ|CONJ<coord:adj>]
					# NEXT
					# AdjnR: NOUN [Fc] ADJ|CONJ<coord:adj>
					# Agreement: gender, number
					@temp = ($listTags =~ /($NOUN$a2)($Fc$a2)(?:$ADJ$a2|$CONJ${l}coord:adj\|${r})/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUN$a2)(?:$Fc$a2)($ADJ$a2|$CONJ${l}coord:adj\|${r})/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"gender,number",\@temp);
					$listTags =~ s/($NOUN${l}concord:1${r})($Fc$a2)($ADJ${l}concord:1${r}|$CONJ${l}concord:1${b2}coord:adj\|${r})/$1/g;
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

					# VSpecL: VERB<type:S> [ADV]? VERB<mode:P>
					# Add: voice:passive
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}type:S\|${r})(?:$ADV$a2)?($VERB${l}mode:P\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}type:S\|${r})($ADV$a2)?($VERB${l}mode:P\|${r})/$2$3/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);
					Add("DepHead","voice:passive",\@temp);

					# VSpecL: VERB<token:[Ff]ui|[Ff]ue|[Ff]uimos|[Ff]ueran|[Ff]uisteis|[Ff]uese|[Ff]uesen> [ADV]? VERB<mode:P>
					# Add: voice:passive
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}token:(?:[Ff]ui|[Ff]ue|[Ff]uimos|[Ff]ueran|[Ff]uisteis|[Ff]uese|[Ff]uesen)\|${r})(?:$ADV$a2)?($VERB${l}mode:P\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}token:(?:[Ff]ui|[Ff]ue|[Ff]uimos|[Ff]ueran|[Ff]uisteis|[Ff]uese|[Ff]uesen)\|${r})($ADV$a2)?($VERB${l}mode:P\|${r})/$2$3/g;
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

					# VSpecL: [VERB<lemma:tener|haber>] [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? CONJ<lemma:que&type:S> [ADV]? VERB<mode:N>
					# NEXT
					# VSpecL: VERB<lemma:tener|haber> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [CONJ<lemma:que&type:S>] [ADV]? VERB<mode:N>
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /(?:$VERB${l}lemma:(?:tener|haber)\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($CONJ${l}lemma:que\|${b2}type:S\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}lemma:(?:tener|haber)\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$CONJ${l}lemma:que\|${b2}type:S\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:tener|haber)\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($CONJ${l}lemma:que\|${b2}type:S\|${r})($ADV$a2)?($VERB${l}mode:N\|${r})/$2$3$4$5$6$7$8$9$10$11$13$14/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

					# VSpecL: [VERB<lemma:ir|venir|empezar|comenzar|acabar|finalizar|terminar|pasar|estar>] [ADV]? PRP<lemma:$PrepLocs> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:N>
					# NEXT
					# VSpecL: VERB<lemma:ir|deber|venir|empezar|comenzar|acabar|finalizar|terminar|pasar|estar> [ADV]? [PRP<lemma:$PrepLocs>] [ADV]? VERB<mode:N>
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /(?:$VERB${l}lemma:(?:ir|venir|empezar|comenzar|acabar|finalizar|terminar|pasar|estar)\|${r})(?:$ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB${l}lemma:(?:ir|deber|venir|empezar|comenzar|acabar|finalizar|terminar|pasar|estar)\|${r})(?:$ADV$a2)?(?:$PRP${l}lemma:$PrepLocs\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:ir|deber|venir|empezar|comenzar|acabar|finalizar|terminar|pasar|estar)\|${r})($ADV$a2)?($PRP${l}lemma:$PrepLocs\|${r})($ADV$a2)?($VERB${l}mode:N\|${r})/$2$4$5/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

					# VSpecL: VERB<lemma:querer|desear|pensar|soler|acostumbrar> [ADV]? VERB<mode:N>
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:(?:querer|desear|pensar|soler|acostumbrar)\|${r})(?:$ADV$a2)?($VERB${l}mode:N\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:(?:querer|desear|pensar|soler|acostumbrar)\|${r})($ADV$a2)?($VERB${l}mode:N\|${r})/$2$3/g;
					Inherit("DepHead","mode,person,tense,number",\@temp);

					# VSpecL: VERB<lemma:estar> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:G>
					# Inherit: mode, person, tense, number
					@temp = ($listTags =~ /($VERB${l}lemma:estar\|${r})(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?(?:$ADV$a2)?($VERB${l}mode:G\|${r})/g);
					$Rel =  "VSpecL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:estar\|${r})($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($ADV$a2)?($VERB${l}mode:G\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
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

					}
{#<function>
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

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc|Fpa|Fca NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] NOUNCOORD|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2|$Fpa$a2|$Fca$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)(?:$Fc$a2|$Fpt$a2|$Fct$a2)/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2|$Fpa$a2|$Fca$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a2)($Fc$a2|$Fpt$a2|$Fct$a2)/$1/g;

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

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>|PRO<lemma:que|quien>] [NOUNCOORD|PRO<type:D|P|I|X>]  VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc] [PRO<type:R|W>|PRO<lemma:que|quien>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>   Fc
					# NEXT
					# DobjL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W>|PRO<lemma:que|quien> [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>|PRO<lemma:que|quien>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>    [Fc]?
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "DobjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1$2$3$4$5$6/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>|PRO<lemma:que|quien>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? [PRO<type:R|W>|PRO<lemma:que|quien>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# SubjL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W>|PRO<lemma:que|quien> VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>|PRO<lemma:que|quien>] VERB|CONJ<coord:verb>  [Fc]?
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1$2$3$4$5/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRP] [PRO<type:R|W>|PRO<lemma:que|quien>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?  [PRP] [PRO<type:R|W>|PRO<lemma:que|quien>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# CircL: [NOUNCOORD|PRO<type:D|P|I|X>]  [Fc]? PRP PRO<type:R|W>|PRO<lemma:que|quien> VERB|CONJ<coord:verb> [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRP] [PRO<type:R|W>|PRO<lemma:que|quien>] VERB|CONJ<coord:verb> [Fc]?
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1$2$3$4$5$6/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRP] [PRO<type:R|W>|PRO<lemma:que|quien>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?  [PRP] [PRO<type:R|W>|PRO<lemma:que|quien>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# CircL: [NOUNCOORD|PRO<type:D|P|I|X>]  [Fc]? PRP PRO<type:R|W>|PRO<lemma:que|quien> [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb> [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRP] [PRO<type:R|W>|PRO<lemma:que|quien>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb> [Fc]?
					# NoUniq
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1$2$3$4$5$6$7/g;

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
					# Add: nomin:yes
					# Inherit: number, person
					@temp = ($listTags =~ /($PRO${l}sust:yes\|${r})($VERB$a2)/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}sust:yes\|${r})($VERB$a2)/$2/g;
					Inherit("DepHead","number,person",\@temp);
					Add("DepHead","nomin:yes",\@temp);

					# SubjL: [PRO<sust:yes>] NOUNCOORD|PRO<type:D|P|I|X> VERB
					# NEXT
					# DobjL: PRO<sust:yes> [NOUNCOORD|PRO<type:D|P|I|X>] VERB
					# Add: nomin:yes
					# Inherit: number, person
					@temp = ($listTags =~ /(?:$PRO${l}sust:yes\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRO${l}sust:yes\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/g);
					$Rel =  "DobjL";
					DepHead($Rel,"",\@temp);
					$listTags =~ s/($PRO${l}sust:yes\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a2)/$3/g;
					Inherit("DepHead","number,person",\@temp);
					Add("DepHead","nomin:yes",\@temp);

					# SubjR: VERB<lemma:$VS> NOUNCOORD|PRO<type:D|P|I|X>
					# Agr: number, person
					@temp = ($listTags =~ /($VERB${l}lemma:$VS\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}lemma:$VS\|${r})($NOUNCOORD|$PRO${l}concord:1${b2}type:(?:D|P|I|X)\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;

					# SubjR: VERB<se:yes&lemma:$VSrefleja> NOUNCOORD|PRO<type:D|P|I|X>
					# Agr: number, person
					@temp = ($listTags =~ /($VERB${l}lemma:$VSrefleja\|${b2}se:yes\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}lemma:$VSrefleja\|${b2}se:yes\|${r})($NOUNCOORD|$PRO${l}concord:1${b2}type:(?:D|P|I|X)\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;

					# SubjR: VERB<ind:yes&lemma:$VSind> NOUNCOORD|PRO<type:D|P|I|X>
					# Agr: number, person
					@temp = ($listTags =~ /($VERB${l}ind:yes\|${b2}lemma:$VSind\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}ind:yes\|${b2}lemma:$VSind\|${r})($NOUNCOORD|$PRO${l}concord:1${b2}type:(?:D|P|I|X)\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;

					# DobjPrepR: VERB<lemma:$SubcatTr> PRP<lemma:a> NOUNCOORD|PRO<type:D|P|I|X>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatTr\|${r})($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
					$Rel =  "DobjPrepR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatTr\|${r})($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

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

					# CregR: VERB<lemma:$SubcatEN>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:en> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatEN\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:en\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatEN\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:en\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatDE>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:de> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatDE\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:de\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatDE\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:de\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatCON>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:con> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatCON\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:con\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatCON\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:con\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatPOR>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:por> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatPOR\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:por\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatPOR\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:por\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatHACIA>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:hacia> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatHACIA\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:hacia\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatHACIA\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:hacia\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatSOBRE>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:sobre> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatSOBRE\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:sobre\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatSOBRE\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:sobre\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

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

					}
{#<function>
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
					# TermR: [VERB] [Fc] PRP NOUNCOORD|PRO<type:D|P|I|X> [Fc]?
					# NEXT
					# CircR: VERB [Fc] PRP NOUNCOORD|PRO<type:D|P|I|X> [Fc]?
					# Recursivity:1
					@temp = ($listTags =~ /($VERB$a2)($Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)(?:$PRP$a2)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "TermR";
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
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "TermR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($Fc$a2)($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?/$1/g;

					# PunctL: [PRP<pos:0>] [NOUNCOORD|PRO<type:D|P|I|X>] Fc  VERB<mode:[^PNG]>|CONJ<coord:verb>
					# NEXT
					# CircL: PRP<pos:0> NOUNCOORD|PRO<type:D|P|I|X> [Fc]?  VERB<mode:[^PNG]>|CONJ<coord:verb>
					@temp = ($listTags =~ /(?:$PRP${l}pos:0\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($PRP${l}pos:0\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					$listTags =~ s/($PRP${l}pos:0\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/$4/g;

					# PunctL: Fc [PRP] [NOUNCOORD|PRO<type:D|P|I|X> ] [Fc]?  VERB<mode:[^PNG]>|CONJ<coord:verb>
					# NEXT
					# PunctL: [Fc]? [PRP] [NOUNCOORD|PRO<type:D|P|I|X> ] Fc  VERB<mode:[^PNG]>|CONJ<coord:verb>
					# NEXT
					# CircL: [Fc]? PRP NOUNCOORD|PRO<type:D|P|I|X>  [Fc]?  VERB<mode:[^PNG]>|CONJ<coord:verb>
					# Recursivity:1
					@temp = ($listTags =~ /($Fc$a2)(?:$PRP$a2)([NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(])(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$PRP$a2)([NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(])($Fc$a2)($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/$5/g;
					@temp = ($listTags =~ /($Fc$a2)(?:$PRP$a2)([NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(])(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?(?:$PRP$a2)([NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(])($Fc$a2)($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$Fc$a2)?($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					$listTags =~ s/($Fc$a2)?($PRP$a2)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/$5/g;

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
					@temp = ($listTags =~ /($VERB${l}lemma:$VS\|${r})($VERB${l}mode:N\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}lemma:$VS\|${r})($VERB${l}concord:1${b2}mode:N\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;

					# SubjR: VERB<se:yes&lemma:$VSrefleja> VERB<mode:N>
					# Agr: number, person
					@temp = ($listTags =~ /($VERB${l}lemma:$VSrefleja\|${b2}se:yes\|${r})($VERB${l}mode:N\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}lemma:$VSrefleja\|${b2}se:yes\|${r})($VERB${l}concord:1${b2}mode:N\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;

					# SubjR: VERB<ind:yes&lemma:$VSind> VERB<mode:N>
					# Agr: number, person
					@temp = ($listTags =~ /($VERB${l}ind:yes\|${b2}lemma:$VSind\|${r})($VERB${l}mode:N\|${r})/g);
					$Rel =  "SubjR";
					HeadDep($Rel,"number,person",\@temp);
					$listTags =~ s/($VERB${l}concord:1${b2}ind:yes\|${b2}lemma:$VSind\|${r})($VERB${l}concord:1${b2}mode:N\|${r})/$1/g;
					$listTags =~ s/concord:[01]\|//g;

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

					# SpecL: [VERB] CONJ<lemma:que|si> VERB<mode:[^PNG]>
					# NEXT
					# DobjR: VERB  [CONJ<lemma:que|si>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)($CONJ${l}lemma:(?:que|si)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$CONJ${l}lemma:(?:que|si)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "DobjR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}lemma:(?:que|si)\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

					# SpecL: [VERB]  CONJ<lemma:que|si>  [NOUNCOORD|PRO<type:D|P|I|X>] VERB<mode:[^PNG]>
					# NEXT
					# SubjL:  [VERB]  [CONJ<lemma:que|si>]  NOUNCOORD|PRO<type:D|P|I|X> VERB<mode:[^PNG]>
					# NEXT
					# DobjR: VERB   [CONJ<lemma:que|si>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB<mode:[^PNG]>
					@temp = ($listTags =~ /(?:$VERB$a2)($CONJ${l}lemma:(?:que|si)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "SpecL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$VERB$a2)(?:$CONJ${l}lemma:(?:que|si)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($VERB$a2)(?:$CONJ${l}lemma:(?:que|si)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
					$Rel =  "DobjR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($VERB$a2)($CONJ${l}lemma:(?:que|si)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

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

					# CregR: VERB<lemma:$SubcatEN>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:en> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatEN\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:en\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatEN\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:en\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatDE>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:de> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatDE\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:de\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatDE\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:de\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatCON>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:con> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatCON\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:con\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatCON\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:con\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatPOR>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:por> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatPOR\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:por\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatPOR\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:por\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatHACIA>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:hacia> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatHACIA\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:hacia\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatHACIA\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:hacia\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# CregR: VERB<lemma:$SubcatSOBRE>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:sobre> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
					@temp = ($listTags =~ /($VERB${l}lemma:$SubcatSOBRE\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:sobre\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
					$Rel =  "CregR";
					HeadRelDep($Rel,"",\@temp);
					$listTags =~ s/($VERB${l}lemma:$SubcatSOBRE\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:sobre\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>|PRO<lemma:que|quien>] VERB<adsubj:yes>|CONJ<adsubj:yes&coord:verb>    [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc] [PRO<type:R|W>|PRO<lemma:que|quien>] VERB<adsubj:yes>|CONJ<adsubj:yes&coord:verb>   Fc
					# NEXT
					# DobjL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W>|PRO<lemma:que|quien> VERB<adsubj:yes>|CONJ<adsubj:yes&coord:verb>    [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>|PRO<lemma:que|quien>] VERB<adsubj:yes>|CONJ<adsubj:yes&coord:verb>    [Fc]?
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "DobjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB${l}adsubj:yes\|${r}|$CONJ${l}adsubj:yes\|${b2}coord:verb\|${r})($Fc$a2)?/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>|PRO<lemma:que|quien>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? [PRO<type:R|W>|PRO<lemma:que|quien>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# SubjL: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W>|PRO<lemma:que|quien> VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>|PRO<lemma:que|quien>] VERB|CONJ<coord:verb>  [Fc]?
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "SubjL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1/g;

					# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc [PRP] [PRO<type:R|W>|PRO<lemma:que|quien>] VERB|CONJ<coord:verb>   [Fc]?
					# NEXT
					# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?  [PRP] [PRO<type:R|W>|PRO<lemma:que|quien>] VERB|CONJ<coord:verb> Fc
					# NEXT
					# CircL: [NOUNCOORD|PRO<type:D|P|I|X>]  [Fc]? PRP PRO<type:R|W>|PRO<lemma:que|quien> VERB|CONJ<coord:verb> [Fc]?
					# NEXT
					# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? [PRP] [PRO<type:R|W>|PRO<lemma:que|quien>] VERB|CONJ<coord:verb> [Fc]?
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "PunctL";
					DepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)/g);
					$Rel =  "PunctR";
					HeadDep($Rel,"",\@temp);
					@temp = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "CircL";
					RelDepHead($Rel,"",\@temp);
					@temp = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a2)?(?:$PRP$a2)(?:$PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})(?:$Fc$a2)?/g);
					$Rel =  "AdjnR";
					HeadDep($Rel,"",\@temp);
					$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a2)?($PRP$a2)($PRO${l}type:(?:R|W)\|${r}|$PRO${l}lemma:(?:que|quien)\|${r})($VERB$a2|$CONJ${l}coord:verb\|${r})($Fc$a2)?/$1/g;

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
