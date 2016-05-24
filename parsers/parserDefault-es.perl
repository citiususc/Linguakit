#!/usr/bin/perl -X

##flag -a=analisador -c=corrector
$flag = shift(@ARGV);

## -a por defeito
if (!defined $flag) {
    $flag = "-a";
}
  
#fronteira de frase:
$Border="SENT";

#identificar nomes de dependencias lexicais (idiomaticas)
$DepLex = "^<\$|^>\$|lex\$" ;


#string com todos os atributos:
$b = "[^ _<>]*" ;

$a = "\\_<${b}>" ; ##todos os atributos
$l =  "\\_<${b}" ; ##atributos parte esquerda
$r =  "${b}>" ;  ##atributos parte direita


###########################GENERATED CODE BY COMPI#############################################

######################################## POS TAGS ########################################
$ADJ = "ADJ_[0-9]+";
$NOUN = "NOUN_[0-9]+";
$PRP = "PRP_[0-9]+";
$ADV = "ADV_[0-9]+";
$CARD = "CARD_[0-9]+";
$CONJ = "CONJ_[0-9]+";
$DET = "DT_[0-9]+";
$PRO = "PRO_[0-9]+";
$VERB = "VERB_[0-9]+";
$I = "I_[0-9]+";
$DATE = "DATE_[0-9]+";
$POS = "POS_[0-9]+";
$PCLE = "PCLE_[0-9]+";
$EX = "EX_[0-9]+";
$Fc = "Fc_[0-9]+";
$Fg = "Fg_[0-9]+";
$Fz = "Fz_[0-9]+";
$Fe = "Fe_[0-9]+";
$Fd = "Fd_[0-9]+";
$Fx = "Fx_[0-9]+";
$Fpa = "Fpa_[0-9]+";
$Fpt = "Fpt_[0-9]+";
$Fca = "Fca_[0-9]+";
$Fct = "Fct_[0-9]+";
$SENT = "SENT_[0-9]+";
$NP = "NOUN_[0-9]+$a|PRP_[0-9]+${l}nomin:yes${r}|VERB_[0-9]+${l}nomin:yes${r}";
$NOMINAL = "NOUN_[0-9]+$a|PRP_[0-9]+${l}nomin:yes${r}|VERB_[0-9]+${l}nomin:yes${r}|CONJ_[0-9]+${l}coord:noun${r}";
$NOUNCOORD = "CARD_[0-9]+$a|DATE_[0-9]+$a|NOUN_[0-9]+$a|CONJ_[0-9]+${l}coord:noun${r}";
$NOUNSINGLE = "CARD_[0-9]+$a|DATE_[0-9]+$a|NOUN_[0-9]+";
$NPCOORD = "CONJ_[0-9]+${l}coord:np${r}|NOUN_[0-9]+${l}type:P${r}";
$X = "[A-Z]+_[0-9]+";
$NOTVERB = "[^V][^E]+_[0-9]+";
$PUNCT = "F[a-z]+_[0-9]+";



#################################### LEXICAL CLASSES #####################################
$Quant  = "(?:very\|more\|less\|least\|most\|quite\|as\|muy\|mucho\|bastante\|bien\|casi\|tan\|muy\|bem\|ben\|menos\|poco\|mui\|moi\|muito\|tão\|más\|mais\|máis\|pouco\|peu\|assez\|plus\|moins\|aussi\|)";
$AdvTemp  = "(?:hoy\|mañana\|ayer\|amanhã\|hoje\|ontem\|mañá\|hoxe\|onte\|today\|yesterday\|tomorrow\|)";
$CCord  = "(?:and\|or\|nor\|y\|ni\|e\|nin\|nem\|et\|o\|ou\|)";
$Partitive  = "(?:de\|of\|)";
$PrepLocs  = "(?:a\|de\|por\|par\|by\|to\|)";
$PrepRA  = "(?:de\|com\|con\|sobre\|sem\|sen\|sin\|entre\|of\|with\|about\|without\|between\|on\|avec\|sûr\|)";
$PrepMA  = "(?:hasta\|até\|hacia\|desde\|em\|en\|para\|since\|until\|at\|in\|for\|to\|jusqu
\|depuis\|pour\|dans\|)";
$cliticopers  = "(?:lo\|la\|los\|las\|le\|les\|nos\|os\|me\|te\|se\|Lo\|La\|Las\|Le\|Les\|Nos\|Me\|Te\|Se\|lle\|lles\|lhe\|lhes\|Lles\|Lhes\|Lle\|Lhe\|che\|ches\|Che\|Ches\|o\|O\|a\|A\|os\|Os\|as\|As\|him\|her\|me\|us\|you\|them\|lui\|leur\|leurs\|)";
$cliticoind  = "(?:le\|les\|nos\|me\|te\|Le\|Les\|Nos\|Me\|Te\|)";
$PROperssuj = "(?:yo\|tú\|usted\|él\|ella\|nosotros\|vosotros\|ellos\|ellas\|ustedes\|eu\|ti\|tu\|vostede\|você\|ele\|ela\|nós\|vós\|eles\|elas\|vostedes\|vocês\|eles\|elas\|you\|i\|we\|they\|he\|she\|je\|il\|elle\|ils\|elles\|nous\|vous\|)";
$PROsujgz = "(?:eu\|ti\|tu\|vostede\|você\|el\|ele\|ela\|nós\|vós\|eles\|elas\|vostedes\|vocês\|eles\|elas\|)";
$VModalEN  = "(?:can\|cannot\|should\|must\|shall\|will\|would\|may\|might\|)";
$VModalES   = "(?:poder\|deber\|)";
$Vpass  = "(?:ser\|be\|être\|)";
$Vaux  = "(?:haber\|haver\|ter\|have\|avoir\|)";
$NincSp  = "(?:alusión\|comentario\|referencia\|llamamiento\|mención\|observación\|declaración\|propuesta\|pregunta\|)";
$NincExp  = "(?:afecto\|alegría\|amparo\|angustia\|ánimo\|cariño\|cobardía\|comprensión\|consuelo\|corte\|daño\|disgusto\|duda\|escándalo\|fobia\|gana\|gracias\|gusto\|inquietud\|)";
$PTa  = "(?:aceder\|acostumar\|acudir\|adaptar\|comprometer\|chegar\|cheirar\|dar\|dedicar\|equivaler\|ir\|olhar\|negar\|pertencer\|recorrer\|referir\|regressar\|renunciar\|subir\|sustrair\|unir\|vincular\|voltar\|acostumbrar\|llegar\|oler\|mirar\|pertenecer\|recurrir\|sustraer\|volver\|)";
$VSrefleja  = "(?:acabar\|agotar\|apuntar\|desencadenar\|filtrar\|importar\|informar\|\|producir\|quebrar\|)";
$VSind  = "(?:agradar\|apasionar\|apetecer\|\|asombrar\|\|cundir\|desagradar\|encantar\|extrañar\|faltar\|gustar\|interesar\|sorprender\|)";
$VS  = "(?:abundar\|aflorar\|agradar\|anidar\|aparecer\|apasionar\|arder\|bastar\|bramar\|brillar\|brotar\|caber\|cesar\|circular\|comenzar\|comparecer\|concluir\|concurrir\|constar\|contrastar\|convenir\|cuajar\|danzar\|desfilar\|despuntar\|doler\|empezar\|\|estallar\|existir\|faltar\|fascinar\|fastidiar\|figurar\|finalizar\|fracasar\|gustar\|hinchar\|holgar\|imperar\|\|intervenir\|latir\|mediar\|ocurrir\|parecer\|perdurar\|predominar\|\|puntualizar\|rechinar\|reinar\|replicar\|reventar\|rugir\|sentenciar\|sobrar\|sobrevenir\|sobrevivir\|sonar\|suceder\|surgir\|temblar\|terciar\|transcurrir\|urgir\|)";
$SubcatIND  = "(?:dar\|agradar\|gustar\|parecer\|hacer\|decir\|preguntar\|pedir\|pasar\|poner\|ocurrir\|atribuir\|hablar\|ofrecer\|contar\|entregar\|echar\|importar\|interesar\|dejar\|quitar\|servir\|tocar\|encantar\|prestar\|escribir\|dirigir\|dedicar\|corresponder\|explicar\|permitir\|añadir\|regalar\|enseñar\|sonreír\|devolver\|enviar\|presentar\|aportar\|deber\|exigir\|llevar\|quedar\|faltar\|abrir\|imponer\|tener\|proponer\|pagar\|comunicar\|ordenar\|conceder\|sacar\|ser\|mandar\|costar\|mostrar\|agregar\|escapar\|llegar\|venir\|asignar\|otorgar\|caer\|negar\|traer\|ver\|arrancar\|molestar\|remitir\|resultar\|ceder\|suceder\|atraer\|meter\|recordar\|tender\|adeudar\|vender\|causar\|aplicar\|pegar\|cerrar\|plantear\|agradecer\|consultar\|contestar\|encargar\|rendir\|comprar\|imprimir\|ocultar\|salir\|demostrar\|tomar\|exponer\|cortar\|restar\|confesar\|asegurar\|confiar\|convenir\|encontrar\|agradar\|gritar\|perder\|recomendar\|impedir\|robar\|llamar\|achacar\|entrar\|facilitar\|prometer\|solicitar\|coger\|caber\|hurtar\|advertir\|proporcionar\|bastar\|comentar\|conferir\|doler\|extrañar\|producir\|adjudicar\|evitar\|avisar\|brindar\|suponer\|indicar\|arrebatar\|chocar\|cantar\|valer\|olvidar\|referir\|prender\|suplicar\|arengar\|imputar\|revelar\|sorprender\|aconsejar\|buscar\|plantar\|reclamar\|repetir\|envidiar\|replicar\|levantar\|perdonar\|relatar\|sugerir\|guardar\|reprochar\|afectar\|procurar\|adeudar\|arengar\|hurtar\|)";
$SubcatA  = "(?:acceder\|acercar\|acertar\|acostumbrar\|acudir\|adaptar\|afectar\|aferrar\|aficionar\|afiliar\|ajustar\|aludir\|apelar\|apostar\|apresurar\|aproximar\|arrimar\|arrojar\|asistir\|asomar\|atener\|atinar\|atrever\|avenir\|comprometer\|conducir\|contribuir\|corresponder\|deber\|dedicar\|dirigir\|disponer\|enfrentar\|equivaler\|exponer\|inducir\|invitar\|ir\|limitar\|llegar\|mudar\|negar\|obligar\|oler\|oponer\|pertenecer\|precipitar\|proceder\|recurrir\|referir\|regresar\|remontar\|renunciar\|resignar\|resistir\|someter\|subir\|sumar\|sustraer\|tender\|trasladar\|unir\|vincular\|volver\|ir\|llegar\|llevar\|volver\|venir\|acercar\|salir\|referir\|dirigir\|atrever\|dedicar\|obligar\|dar\|pasar\|pertenecer\|disponer\|asistir\|subir\|acudir\|responder\|regresar\|ayudar\|mirar\|invitar\|jugar\|asomar\|negar\|limitar\|sentar\|renunciar\|bajar\|enfrentar\|aprender\|echar\|afectar\|conducir\|entrar\|llamar\|tender\|esperar\|correr\|decidir\|reducir\|destinar\|corresponder\|hacer\|someter\|aludir\|entregar\|unir\|deber\|contribuir\|resistir\|arrojar\|mandar\|oler\|recurrir\|acompañar\|oponer\|acostumbrar\|acceder\|caer\|aplicar\|estar\|aproximar\|lanzar\|trasladar\|traer\|proceder\|apresurar\|poner\|condenar\|enseñar\|quedar\|enviar\|adaptar\|ajustar\|tirar\|exponer\|incorporar\|escapar\|sacar\|atener\|forzar\|animar\|marchar\|acertar\|devolver\|agarrar\|aspirar\|presentar\|saltar\|retirar\|extender\|ascender\|comprometer\|parar\|remitir\|aferrar\|abrazar\|resignar\|apostar\|pegar\|contestar\|seguir\|arrimar\|prestar\|elevar\|obedecer\|avenir\|largar\|ceder\|sumar\|precipitar\|viajar\|preferir\|adelantar\|remontar\|apuntar\|equivaler\|abrir\|mover\|inclinar\|sustraer\|acoger\|atañer\|impulsar\|desplazar\|abandonar\|inducir\|asemejar\|plegar\|subyacer\|atender\|sujetar\|imponer\|sobreponer\|transportar\|adecuar\|empujar\|instar\|dejar\|encaminar\|encontrar\|transmitir\|declarar\|equiparar\|vivir\|incitar\|sobrevivir\|colocar\|sonar\|rendir\|autorizar\|aguardar\|ofrecer\|reintegrar\|arrastrar\|levantar\|tocar\|mudar\|arriesgar\|cerrar\|traducir\|descender\|probar\|retornar\|aficionar\|sucumbir\|concurrir\|consagrar\|convocar\|doblar\|atinar\|comparar\|anticipar\|comparecer\|vincular\|apelar\|tener\|cruzar\|cambiar\|exhortar\|hallar\|afiliar\|liar\|preparar\|resolver\|asociar\|optar\|saber\|meter\|rebajar\|decir\|sacrificar\|señalar\|apestar\|instalar\|partir\|resbalar\|propender\|retroceder\|alcanzar\|relegar\|aventurar\|denunciar\|huir\|anteponer\|cooperar\|ligar\|sentir\|supeditar\|ceñir\|faltar\|impeler\|mezclar\|subordinar\|figurar\|jugar\|)";
$SubcatDE  = "(?:hablar\|tratar\|salir\|dar\|sacar\|acordar\|venir\|hacer\|saber\|pasar\|enterar\|servir\|cambiar\|depender\|ocupar\|ir\|separar\|apartar\|carecer\|disponer\|acusar\|alejar\|opinar\|encargar\|huir\|echar\|convencer\|olvidar\|tirar\|llenar\|bajar\|levantar\|librar\|llegar\|despedir\|gozar\|quitar\|colgar\|tomar\|dudar\|informar\|provenir\|pensar\|reír\|escapar\|coger\|encoger\|quedar\|quejar\|enamorar\|vestir\|entender\|apoderar\|desprender\|disfrutar\|extraer\|surgir\|decir\|proceder\|nacer\|vivir\|regresar\|traer\|recibir\|arrancar\|alegrar\|brotar\|prescindir\|derivar\|volver\|descender\|defender\|retirar\|burlar\|necesitar\|esperar\|salvar\|preocupar\|partir\|aprovechar\|despojar\|participar\|mover\|distinguir\|dejar\|desaparecer\|presumir\|llevar\|avergonzar\|liberar\|percatar\|cansar\|marchar\|saltar\|privar\|caer\|emerger\|cubrir\|fiar\|aprender\|abstener\|adueñar\|cerciorar\|arrepentir\|perder\|desconfiar\|heredar\|borrar\|gustar\|desligar\|alimentar\|reponer\|desviar\|distar\|proveer\|rescatar\|subir\|abusar\|cuidar\|conocer\|contar\|aislar\|llorar\|equivocar\|deducir\|disfrazar\|distraer\|excluir\|avisar\|despegar\|dotar\|sospechar\|apropiar\|apear\|armar\|desentender\|diferenciar\|emanar\|preservar\|recoger\|agarrar\|deshacer\|extrañar\|persuadir\|constar\|valer\|asegurar\|cruzar\|desistir\|vengar\|pender\|diferir\|renegar\|resultar\|sorprender\|proteger\|vaciar\|alardear\|cargar\|desembarazar\|mudar\|expulsar\|elevar\|impregnar\|limpiar\|bastar\|componer\|despertar\|absolver\|obtener\|predicar\|matricular\|descargar\|extender\|asombrar\|escurrir\|apiadar\|asustar\|querer\|alzar\|arrojar\|comportar\|evadir\|protestar\|recuperar\|desvincular\|esconder\|examinar\|jactar\|redimir\|aburrir\|adolecer\|escribir\|rodear\|disuadir\|empezar\|hartar\|recelar\|seguir\|charlar\|trasladar\|exigir\|acompañar\|curar\|beneficiar\|ser\|abstener\|abusar\|acordar\|acusar\|adueñar\|aislar\|alegrar\|apartar\|apiadar\|apoderar\|apropiar\|avergonzar\|burlar\|carecer\|cerciorar\|convencer\|depender\|derivar\|desconfiar\|desembarazar\|desentender\|despojar\|desprender\|diferenciar\|diferir\|disfrazar\|disfrutar\|dudar\|enamorar\|encargar\|encoger\|enterar\|extraer\|fiar\|gozar\|hablar\|huir\|liberar\|librar\|ocupar\|partir\|percatar\|prescindir\|presumir\|privar\|provenir\|salir\|separar\|tratar\|vestir\|)";
$SubcatEN  = "(?:entrar\|pensar\|convertir\|estar\|meter\|vivir\|poner\|encontrar\|quedar\|dejar\|sentar\|caer\|creer\|participar\|fijar\|tardar\|consistir\|pasar\|insistir\|apoyar\|confiar\|nacer\|introducir\|figurar\|residir\|transformar\|ir\|encerrar\|hallar\|instalar\|permanecer\|reparar\|colocar\|situar\|hundir\|intervenir\|echar\|incluir\|refugiar\|guardar\|empeñar\|sentir\|centrar\|esconder\|coincidir\|clavar\|concentrar\|salir\|esforzar\|desembocar\|basar\|despertar\|venir\|penetrar\|envolver\|caber\|mirar\|reflejar\|ingresar\|viajar\|adentrar\|flotar\|inscribir\|besar\|depositar\|distinguir\|seguir\|mantener\|influir\|sumergir\|tomar\|cifrar\|sumir\|golpear\|dudar\|posar\|habitar\|girar\|reconocer\|fundar\|montar\|hurgar\|incurrir\|interesar\|obstinar\|trabajar\|recostar\|matricular\|dividir\|veranear\|actuar\|manifestar\|tirar\|mediar\|ocupar\|oscilar\|colar\|emplear\|reinar\|traer\|acabar\|invertir\|incidir\|infiltrar\|internar\|acomodar\|colaborar\|interponer\|irrumpir\|prorrumpir\|integrar\|precipitar\|descansar\|hacer\|prender\|provocar\|encarnar\|plantar\|inspirar\|parar\|fundir\|asentar\|culminar\|encajar\|repercutir\|retener\|molestar\|radicar\|expresar\|repartir\|convenir\|delegar\|admitir\|volver\|andar\|yacer\|complacer\|citar\|mandar\|tender\|vacilar\|traducir\|verter\|concretar\|leer\|tumbar\|especializar\|gastar\|recrear\|volcar\|empecinar\|demorar\|insertar\|proyectar\|ahondar\|enredar\|hincar\|profundizar\|degenerar\|trocar\|elegir\|implantar\|cagar\|escarbar\|agolpar\|distribuir\|establecer\|investigar\|reclinar\|redundar\|sacar\|servir\|abandonar\|constituir\|descollar\|entretener\|estallar\|localizar\|resolver\|zambullir\|causar\|equivocar\|esmerar\|estimar\|persistir\|soñar\|cejar\|materializar\|pervivir\|reinstalar\|sepultar\|tocar\|transfigurar\|amparar\|imprimir\|inducir\|sustentar\|vegetar\|acodar\|descargar\|gobernar\|llevar\|mecer\|albergar\|construir\|existir\|grabar\|afanar\|plasmar\|reafirmar\|afirmar\|alojar\|colgar\|cruzar\|derramar\|extender\|iniciar\|recaer\|surgir\|acodar\|adentrar\|ahondar\|apoyar\|asentar\|basar\|caer\|centrar\|colar\|complacer\|concentrar\|confiar\|consistir\|convertir\|desembocar\|dividir\|empecinar\|empeñar\|encarnar\|encerrar\|entrar\|envolver\|esconder\|esforzar\|especializar\|fijar\|flotar\|hundir\|hurgar\|incidir\|incurrir\|infiltrar\|influir\|ingresar\|inscribir\|insistir\|instalar\|internar\|introducir\|irrumpir\|materializar\|matricular\|meter\|nacer\|obstinar\|oscilar\|participar\|penetrar\|plantificar\|profundizar\|prorrumpir\|radicar\|recostar\|recrear\|refugiar\|reparar\|repercutir\|residir\|sentar\|situar\|soñar\|sumergir\|sumir\|tardar\|transformar\|tumbar\|veranear\|zambullir\|)";
$SubcatCON  = "(?:hablar\|contar\|encontrar\|relacionar\|tener\|quedar\|casar\|acabar\|coincidir\|dar\|comparar\|bastar\|acostar\|identificar\|pasar\|tratar\|soñar\|vivir\|luchar\|reunir\|compartir\|estar\|confundir\|tropezar\|poder\|cubrir\|enfrentar\|cruzar\|mezclar\|romper\|tapar\|entrevistar\|salir\|conversar\|conformar\|ocurrir\|convivir\|comenzar\|contrastar\|amenazar\|empezar\|hacer\|cumplir\|seguir\|topar\|chocar\|pelear\|discutir\|andar\|comunicar\|cargar\|atentar\|unir\|guardar\|lanzar\|llenar\|vestir\|negociar\|enfadar\|combinar\|entender\|colaborar\|disfrutar\|estrellar\|charlar\|fundir\|bailar\|continuar\|comentar\|encarar\|contactar\|reconciliar\|terminar\|despertar\|divertir\|dotar\|concluir\|meter\|rebelar\|conectar\|defender\|protestar\|volver\|arremeter\|suceder\|tocar\|competir\|alternar\|enlazar\|golpear\|apoyar\|pactar\|sentir\|comprometer\|entusiasmar\|acompañar\|comulgar\|envolver\|aparear\|dirigir\|venir\|mandar\|aburrir\|sustituir\|asociar\|concordar\|consultar\|frotar\|intercambiar\|alzar\|compaginar\|corresponder\|permanecer\|enrollar\|atrever\|combatir\|contentar\|insistir\|tirar\|simpatizar\|culminar\|simultanear\|complementar\|completar\|gozar\|asociar\|atentar\|bastar\|coincidir\|colaborar\|comparar\|conectar\|conformar\|confundir\|conversar\|convivir\|encarar\|enlazar\|entrevistar\|identificar\|mezclar\|rebelar\|reconciliar\|relacionar\|soñar\|topar\|tropezar\|)";
$SubcatPOR  = "(?:pasar\|entrar\|ir\|preguntar\|dar\|salir\|optar\|pasear\|andar\|interesar\|luchar\|venir\|empezar\|sentir\|preocupar\|cambiar\|sustituir\|meter\|mirar\|subir\|esforzar\|seguir\|llorar\|agarrar\|coger\|poner\|tirar\|pugnar\|pagar\|guiar\|caer\|inclinar\|decidir\|vivir\|caracterizar\|valer\|extender\|juzgar\|abogar\|felicitar\|protestar\|echar\|rezar\|deambular\|velar\|tomar\|adentrar\|asomar\|colar\|cruzar\|quedar\|estar\|vagar\|volver\|circular\|apostar\|trepar\|discurrir\|multiplicar\|brindar\|escurrir\|arrojar\|atravesar\|traer\|substituir\|viajar\|temer\|pronunciar\|pelear\|rondar\|caber\|distinguir\|faltar\|sacar\|abogar\|brindar\|caracterizar\|deambular\|luchar\|optar\|pugnar\|vagar\|velar\|)";
$SubcatHACIA  = "(?:volver\|ir\|mirar\|dirigir\|avanzar\|correr\|caminar\|encaminar\|salir\|atraer\|orientar\|sentir\|inclinar\|desviar\|venir\|empujar\|tender\|andar\|señalar\|lanzar\|echar\|llevar\|arrastrar\|desplazar\|partir\|levantar\|conducir\|huir\|apuntar\|cruzar\|saltar\|encaminar\|)";
$SubcatSOBRE  = "(?:abalanzar\|)";
$SubcatImpers  = "(?:haber\|hacer\|tratar\|bastar\|ser\|llover\|ir\|dar\|nevar\|oler\|anochecer\|amanecer\|parecer\|oscurecer\|doler\|poner\|)";
$SubcatBitr  = "(?:dar\|hacer\|pedir\|poner\|decir\|preguntar\|ofrecer\|echar\|atribuir\|dejar\|quitar\|contar\|prestar\|dedicar\|aportar\|deber\|explicar\|permitir\|llevar\|tener\|devolver\|entregar\|exigir\|abrir\|dirigir\|pasar\|imponer\|enviar\|proponer\|sacar\|regalar\|presentar\|conceder\|añadir\|negar\|traer\|otorgar\|recordar\|remitir\|costar\|adeudar\|enseñar\|asignar\|comunicar\|arrancar\|pagar\|rendir\|agregar\|ceder\|meter\|mandar\|tomar\|asegurar\|cerrar\|ver\|imprimir\|cortar\|encontrar\|llamar\|causar\|confesar\|mostrar\|restar\|comprar\|demostrar\|ordenar\|tender\|robar\|coger\|proporcionar\|plantear\|solicitar\|agradecer\|escribir\|exponer\|impedir\|producir\|conferir\|arrebatar\|perder\|prometer\|facilitar\|evitar\|envidiar\|indicar\|ocultar\|avisar\|referir\|vender\|levantar\|advertir\|encargar\|perdonar\|recomendar\|revelar\|buscar\|relatar\|reprochar\|)";
$SubcatTr  = "(?:abandonar\|abarcar\|abonar\|abordar\|abrigar\|abrir\|abrochar\|absorber\|acariciar\|acarrear\|acatar\|accionar\|acechar\|acelerar\|acentuar\|aceptar\|aclarar\|acoger\|acometer\|aconsejar\|acreditar\|acumular\|adelantar\|adivinar\|administrar\|admirar\|admitir\|adoptar\|adorar\|adquirir\|advertir\|afilar\|afirmar\|aflojar\|afrontar\|agitar\|agradecer\|agredir\|aguardar\|aguzar\|ahorrar\|alargar\|albergar\|alcanzar\|alegar\|alentar\|aligerar\|alijar\|alisar\|aliviar\|alquilar\|alterar\|alzar\|ampliar\|analizar\|añorar\|anotar\|anular\|anunciar\|apaciguar\|apagar\|aparentar\|aplacar\|aplastar\|aplazar\|aplicar\|aporrear\|aportar\|apreciar\|aprender\|apresar\|apretar\|aprovechar\|apuñalar\|argumentar\|armar\|arrancar\|arrasar\|arrastrar\|arrebatar\|arreglar\|arrogar\|articular\|asaltar\|asegurar\|asesinar\|asimilar\|aspirar\|asumir\|atacar\|atajar\|atraer\|atrapar\|atravesar\|atribuir\|aumentar\|autorizar\|aventurar\|averiguar\|avivar\|bajar\|barrer\|batir\|beber\|bendecir\|blandir\|bloquear\|bordear\|borrar\|buscar\|calar\|calcular\|calentar\|calzar\|captar\|cargar\|causar\|cazar\|celebrar\|ceñir\|cerrar\|citar\|clavar\|cobrar\|cocinar\|coger\|combinar\|cometer\|compartir\|compensar\|completar\|complicar\|componer\|comprar\|comprender\|comprobar\|comunicar\|concebir\|conceder\|condicionar\|confeccionar\|confesar\|confirmar\|conjeturar\|conocer\|conquistar\|conseguir\|conservar\|considerar\|consolidar\|constatar\|constituir\|construir\|consultar\|consumar\|contar\|contemplar\|contener\|contraer\|contratar\|controlar\|convocar\|copiar\|coronar\|corroborar\|cortar\|costar\|crear\|creer\|criticar\|cruzar\|cubrir\|culminar\|cultivar\|cumplir\|cursar\|dañar\|decidir\|declarar\|decretar\|deducir\|defender\|demandar\|demostrar\|denotar\|denunciar\|deplorar\|depositar\|derribar\|derrotar\|desabrochar\|desactivar\|desatar\|desbordar\|descalificar\|descargar\|descartar\|descentralizar\|descifrar\|descolgar\|desconocer\|descorrer\|describir\|descubrir\|desdeñar\|desear\|desechar\|desempeñar\|desenterrar\|deshacer\|designar\|desmentir\|desoír\|despachar\|despegar\|despejar\|desperdiciar\|desplegar\|despreciar\|destacar\|destapar\|desterrar\|destrozar\|destruir\|desvelar\|desviar\|detectar\|determinar\|detestar\|devolver\|devorar\|dibujar\|dictar\|difundir\|dilucidar\|dirimir\|disimular\|disipar\|disolver\|disputar\|distinguir\|divisar\|doblar\|dominar\|echar\|efectuar\|ejecutar\|ejercer\|elaborar\|elegir\|elevar\|eliminar\|elogiar\|eludir\|embarcar\|emitir\|emplear\|emprender\|empujar\|empuñar\|enarbolar\|encarecer\|encarnar\|encauzar\|encender\|encontrar\|encubrir\|enderezar\|enfilar\|enfocar\|enjugar\|enriquecer\|enseñar\|entablar\|entonar\|entorpecer\|entrañar\|entreabrir\|entregar\|entrever\|enumerar\|enviar\|erradicar\|esbozar\|escalar\|escamotear\|esclarecer\|escoger\|escribir\|escrutar\|escuchar\|esgrimir\|espantar\|esperar\|esquivar\|establecer\|estimar\|estimular\|estipular\|estirar\|estrechar\|estrenar\|estropear\|estudiar\|evaluar\|evitar\|evocar\|exaltar\|examinar\|excluir\|excusar\|exhibir\|exigir\|expeler\|experimentar\|explicar\|explorar\|expresar\|extender\|fabricar\|facilitar\|favorecer\|financiar\|fingir\|firmar\|fomentar\|forjar\|formar\|formular\|fortalecer\|forzar\|franquear\|frotar\|fruncir\|fumar\|fundar\|fundir\|ganar\|garantizar\|gastar\|generar\|gestionar\|golpear\|guardar\|habitar\|hacer\|hojear\|humedecer\|ignorar\|iluminar\|ilustrar\|imaginar\|imitar\|impartir\|impedir\|implantar\|implicar\|imponer\|imprimir\|improvisar\|impulsar\|inaugurar\|incendiar\|incluir\|incoar\|incrementar\|indagar\|indicar\|inferir\|infundir\|ingerir\|iniciar\|insinuar\|inspeccionar\|inspirar\|intentar\|intercambiar\|interpretar\|intuir\|invadir\|inventar\|invertir\|investigar\|invocar\|involucrar\|jalar\|juntar\|jurar\|justificar\|juzgar\|ladear\|lamentar\|lamer\|lanzar\|lavar\|leer\|liar\|limar\|limpiar\|liquidar\|llenar\|llevar\|localizar\|lograr\|lucir\|maldecir\|mandar\|manejar\|manifestar\|mantener\|marcar\|mascar\|masticar\|matizar\|medir\|mejorar\|mencionar\|mentar\|merecer\|minar\|modernizar\|modificar\|morder\|mostrar\|motivar\|narrar\|necesitar\|negociar\|neutralizar\|nombrar\|notar\|nublar\|observar\|obtener\|ocultar\|odiar\|ofrecer\|oír\|olvidar\|opinar\|oprimir\|ordenar\|organizar\|otear\|otorgar\|padecer\|pagar\|paladear\|palmear\|palpar\|pedir\|pegar\|pensar\|percibir\|perder\|perfeccionar\|permitir\|persuadir\|pesar\|picar\|pintar\|pisar\|pisotear\|planchar\|planear\|plantar\|plantear\|ponderar\|poner\|poseer\|postergar\|postular\|practicar\|precisar\|predecir\|preferir\|preguntar\|prender\|preparar\|presenciar\|presentir\|preservar\|presidir\|presionar\|prestar\|pretender\|pretextar\|prever\|probar\|proclamar\|procurar\|proferir\|profesar\|prohibir\|prolongar\|prometer\|promocionar\|promover\|pronunciar\|propagar\|propiciar\|propinar\|proponer\|proporcionar\|propugnar\|proseguir\|provocar\|publicar\|pulsar\|quebrantar\|quemar\|querer\|quitar\|rascar\|rasgar\|rastrear\|ratificar\|razonar\|realizar\|reanudar\|rebajar\|rebasar\|recabar\|recetar\|rechazar\|recibir\|reclamar\|recobrar\|recoger\|recomendar\|recomponer\|reconocer\|reconsiderar\|reconstruir\|recordar\|recorrer\|recortar\|recuperar\|redactar\|redoblar\|reducir\|reflejar\|reformar\|reforzar\|regalar\|registrar\|regular\|rehuir\|reiterar\|reivindicar\|relatar\|releer\|rematar\|rememorar\|remover\|renovar\|repartir\|repasar\|repetir\|reponer\|representar\|reprimir\|reprobar\|reprochar\|reproducir\|requerir\|resaltar\|rescatar\|reservar\|resolver\|respetar\|restablecer\|restar\|restaurar\|restregar\|resumir\|retomar\|retrasar\|revelar\|revisar\|revivir\|robar\|rodear\|rogar\|romper\|rozar\|rumiar\|saber\|saborear\|sacar\|sacrificar\|sacudir\|salvaguardar\|salvar\|satisfacer\|secundar\|seguir\|seleccionar\|sembrar\|señalar\|serrar\|servir\|significar\|simular\|solicitar\|solucionar\|soñar\|sopesar\|soportar\|sorber\|sortear\|sospechar\|sostener\|subrayar\|sufrir\|sugerir\|sujetar\|suministrar\|superar\|suplantar\|suponer\|suprimir\|suscitar\|suspender\|sustentar\|sustituir\|tapar\|tararear\|temer\|tener\|tentar\|terminar\|tocar\|tolerar\|tomar\|torcer\|traer\|tragar\|transmitir\|transportar\|traspasar\|trasponer\|trazar\|usar\|utilizar\|vaciar\|valer\|valorar\|velar\|vencer\|vender\|ver\|verificar\|visitar\|vislumbrar\|voltear\|vomitar\|zampar\|zanjar\|)";
$SubcatAtr  = "(?:acabar\|actuar\|amanecer\|andar\|antojar\|aparecer\|caer\|considerar\|continuar\|costar\|creer\|dar\|declarar\|definir\|dejar\|ejercer\|encontrar\|erigir\|estar\|hacer\|hallar\|imaginar\|ingresar\|ir\|llamar\|llevar\|manifestar\|mantener\|meter\|mostrar\|nacer\|parecer\|pasar\|permanecer\|poner\|proseguir\|quedar\|resultar\|revelar\|saber\|salir\|seguir\|sentir\|ser\|sonar\|tener\|terminar\|tirar\|titular\|tornar\|trabajar\|transcurrir\|venir\|ver\|vivir\|volver\|yacer\|)";
$SubcatODirAtr  = "(?:tener\|dejar\|hacer\|ver\|poner\|llamar\|considerar\|llevar\|mantener\|sentir\|tomar\|oír\|calificar\|encontrar\|creer\|dar\|imaginar\|traer\|estimar\|pasar\|entender\|volver\|juzgar\|definir\|concebir\|utilizar\|declarar\|mirar\|colocar\|escuchar\|hallar\|denominar\|conocer\|conservar\|reconocer\|tachar\|identificar\|tratar\|aceptar\|coger\|)";
$SubcatClaus  = "(?:saber\|creer\|querer\|decir\|pensar\|ver\|preguntar\|intentar\|recordar\|permitir\|lograr\|decidir\|desear\|pretender\|hacer\|asegurar\|esperar\|pedir\|explicar\|comprender\|conseguir\|preferir\|necesitar\|suponer\|sentir\|afirmar\|considerar\|tener\|entender\|impedir\|contar\|procurar\|reconocer\|temer\|advertir\|señalar\|dejar\|oír\|indicar\|proponer\|comprobar\|descubrir\|imaginar\|declarar\|confesar\|demostrar\|añadir\|jurar\|admitir\|prometer\|significar\|anunciar\|sospechar\|evitar\|aceptar\|mirar\|fingir\|observar\|contestar\|notar\|olvidar\|mostrar\|manifestar\|negar\|comentar\|mandar\|sostener\|encontrar\|responder\|ordenar\|estimar\|precisar\|ignorar\|exigir\|opinar\|rogar\|soñar\|lamentar\|merecer\|dar\|agregar\|confirmar\|averiguar\|enseñar\|adivinar\|aclarar\|aconsejar\|comunicar\|sugerir\|prever\|subrayar\|repetir\|conocer\|deducir\|destacar\|intuir\|informar\|revelar\|figurar\|gritar\|perdonar\|poner\|resolver\|probar\|avisar\|prohibir\|recomendar\|dudar\|agradecer\|determinar\|apuntar\|criticar\|acordar\|calcular\|solicitar\|juzgar\|reiterar\|reprochar\|simular\|estudiar\|replicar\|tolerar\|insinuar\|ofrecer\|argumentar\|aparentar\|establecer\|percibir\|verificar\|buscar\|presentir\|referir\|escribir\|aprovechar\|alegar\|leer\|amenazar\|denunciar\|garantizar\|desconocer\|escuchar\|implicar\|justificar\|odiar\|reponer\|consentir\|reclamar\|dignar\|hablar\|concebir\|servir\|apreciar\|adelantar\|contemplar\|elegir\|descartar\|reflexionar\|suplicar\|presumir\|puntualizar\|rehuir\|disponer\|rehusar\|notificar\|pretextar\|requerir\|concluir\|estipular\|)";


####################################END CODE BY COMPI################################################



$i=0;
$listTags="";
$seq="";
$CountLines=0;

$j=0;
while (<>) {
   chop($_);

  ($token, $info) = split(" ", $_);

  if ( ($CountLines % 100) == 0) {;
       printf  STDERR "- - - processar linha:(%6d) - - -\r",$CountLines;
  }
  $CountLines++;

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



  ##organizamos a informacao de cada token:
   if ($info ne "") {
     (@info) = split ('\|', $info);
     for ($i=0;$i<=$#info;$i++) {
       if ($info[$i] ne "") {
        ($attrib, $value) = split (':', $info[$i]) ;
        $Exp{$attrib} = $value ;
       }
     }
   }

   ##construimos os vectores da oracao
   if ($Exp{"tag"} ne $Border) {
     $Token[$j] = $token ;
     if ($info ne "") {
       $Lemma[$j] = $Exp{"lemma"} ;
       $Tag[$j] = $Exp{"tag"} ;
       $Attributes[$j] = "";
       foreach $at (sort keys %Exp) {
	 if ($at ne "tag"){
	     $Attributes[$j] .= "$at:$Exp{$at}|" ; 
             $ATTR[$j]{$at} = $Exp{$at} ;
         }
       }
       foreach $at (sort keys %Exp) {
	   delete $Exp{$at};
       }
     }

     $j++;
     #print STDERR "$j\r";
   }

   elsif ($Exp{"tag"} eq $Border) {
     $Token[$j] = $token ;
     $Lemma[$j] = $Exp{"lemma"} ;
     $Tag[$j] = $Exp{"tag"} ;
     $Attributes[$j] = "";
     foreach $at (sort keys %Exp) {
         if ($at ne "tag"){
             $Attributes[$j] .= "$at:$Exp{$at}|" ;
             $ATTR[$j]{$at} = $Exp{$at} ;
         }
     }
     foreach $at (sort keys %Exp) {
           delete $Exp{$at};
     }


     ##construimos os strings com a lista de tags-atributos e os token-tags da oraçao
     for ($i=0;$i<=$#Token;$i++) {

       ReConvertChar ('\:', "Fd", $i);
       ReConvertChar ('\|', "Fz", $i);
       ReConvertChar ('\>', "Fz1", $i);
       ReConvertChar ('\<', "Fz2", $i);

       $listTags .= "$Tag[$i]_${i}_<$Attributes[$i]>" ;
       $seq .= "$Token[$i]_$Tag[$i]_${i}_<$Attributes[$i]>" . " ";

	 
      }##fim do for
     # $seq .= "\." . "_" . $Border ;
     
      $STOP=0;
      #$iteration=0;
      while (!$STOP) {
         $ListInit = $listTags;
         #$iteration++;
        # print STDERR "$iteration\n";


###########################BEGIN GRAMMAR#############################################
# Single: VERB
# Add: nomin:no
(@temp) = ($listTags =~ /($VERB$a)/g);
$Rel =  "Single";
Head($Rel,"",@temp);
$listTags =~ s/($VERB$a)/$1/g;
Add("Head","nomin:no",@temp);

# Single: PRP<lemma:pero|because|though|if|whether|while> [X]?
# Corr: tag:CONJ, type:S
(@temp) = ($listTags =~ /($PRP${l}lemma:(?:pero|because|though|if|whether|while)\|${r})(?:$X$a)?/g);
$Rel =  "Single";
Head($Rel,"",@temp);
$listTags =~ s/($PRP${l}lemma:(?:pero|because|though|if|whether|while)\|${r})($X$a)?/$1$2/g;
Corr("Head","tag:CONJ,type:S",@temp);

# Single: [NOUN] [Fc]? CONJ<lemma:que> [NOUN] [VERB]
# Corr: tag:PRO, type:R
(@temp) = ($listTags =~ /(?:$NOUN$a)(?:$Fc$a)?($CONJ${l}lemma:que\|${r})(?:$NOUN$a)(?:$VERB$a)/g);
$Rel =  "Single";
Head($Rel,"",@temp);
$listTags =~ s/($NOUN$a)($Fc$a)?($CONJ${l}lemma:que\|${r})($NOUN$a)($VERB$a)/$1$2$3$4$5/g;
Corr("Head","tag:PRO,type:R",@temp);

# Single: [X<lemma:lo>] CONJ<lemma:que>
# Corr: tag:PRO, type:R
(@temp) = ($listTags =~ /(?:$X${l}lemma:lo\|${r})($CONJ${l}lemma:que\|${r})/g);
$Rel =  "Single";
Head($Rel,"",@temp);
$listTags =~ s/($X${l}lemma:lo\|${r})($CONJ${l}lemma:que\|${r})/$1$2/g;
Corr("Head","tag:PRO,type:R",@temp);

# Single: X<lemma:lo> [PRO<lemma:que>]
# Corr: tag:DT, type:A
(@temp) = ($listTags =~ /($X${l}lemma:lo\|${r})(?:$PRO${l}lemma:que\|${r})/g);
$Rel =  "Single";
Head($Rel,"",@temp);
$listTags =~ s/($X${l}lemma:lo\|${r})($PRO${l}lemma:que\|${r})/$1$2/g;
Corr("Head","tag:DT,type:A",@temp);

# Single: [X]? CONJ<lemma:pero>
# Corr: type:S
(@temp) = ($listTags =~ /(?:$X$a)?($CONJ${l}lemma:pero\|${r})/g);
$Rel =  "Single";
Head($Rel,"",@temp);
$listTags =~ s/($X$a)?($CONJ${l}lemma:pero\|${r})/$1$2/g;
Corr("Head","type:S",@temp);

# Single: [X]? NOUN<lemma:$AdvTemp>
# Corr: tag:ADV
(@temp) = ($listTags =~ /(?:$X$a)?($NOUN${l}lemma:$AdvTemp\|${r})/g);
$Rel =  "Single";
Head($Rel,"",@temp);
$listTags =~ s/($X$a)?($NOUN${l}lemma:$AdvTemp\|${r})/$1$2/g;
Corr("Head","tag:ADV",@temp);

# Single: VERB<token:[cC]reo> [X]? [X<lemma:que>]
# Corr: lemma:creer
(@temp) = ($listTags =~ /($VERB${l}token:[cC]reo\|${r})(?:$X$a)?(?:$X${l}lemma:que\|${r})/g);
$Rel =  "Single";
Head($Rel,"",@temp);
$listTags =~ s/($VERB${l}token:[cC]reo\|${r})($X$a)?($X${l}lemma:que\|${r})/$1$2$3/g;
Corr("Head","lemma:creer",@temp);

# PunctR: X Fz|Fe
(@temp) = ($listTags =~ /($X$a)($Fz$a|$Fe$a)/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($X$a)($Fz$a|$Fe$a)/$1/g;

# PunctL: Fz|Fe X
(@temp) = ($listTags =~ /($Fz$a|$Fe$a)($X$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($Fz$a|$Fe$a)($X$a)/$2/g;

# >: VERB<lemma:tener|ter|haber|haver|take|have> NOUN<number:S> [PRP]
(@temp) = ($listTags =~ /($VERB${l}lemma:(?:tener|ter|haber|haver|take|have)\|${r})($NOUN${l}number:S\|${r})(?:$PRP$a)/g);
$Rel =  ">";
HeadDep_lex($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:(?:tener|ter|haber|haver|take|have)\|${r})($NOUN${l}number:S\|${r})($PRP$a)/$1$3/g;
LEX();

# >: VERB<lemma:be|ser> ADJ [PRP]
(@temp) = ($listTags =~ /($VERB${l}lemma:(?:be|ser)\|${r})($ADJ$a)(?:$PRP$a)/g);
$Rel =  ">";
HeadDep_lex($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:(?:be|ser)\|${r})($ADJ$a)($PRP$a)/$1$3/g;
LEX();

# <: [VERB<lemma:ser|tornar|converter|be|become>] ADV<lemma:$Quant> ADJ [CONJ|PRO<lemma:que|como>]
# NEXT
# >: VERB<lemma:ser|tornar|converter|be|become> [ADV<lemma:$Quant>] ADJ [CONJ|PRO<lemma:que|como>]
# NEXT
# >: VERB<lemma:ser|tornar|converter|be|become>  [ADV<lemma:$Quant>] [ADJ] CONJ|PRO<lemma:que|como>
(@temp) = ($listTags =~ /(?:$VERB${l}lemma:(?:ser|tornar|converter|be|become)\|${r})($ADV${l}lemma:$Quant\|${r})($ADJ$a)(?:$CONJ$a|$PRO${l}lemma:(?:que|como)\|${r})/g);
$Rel =  "<";
DepHead_lex($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB${l}lemma:(?:ser|tornar|converter|be|become)\|${r})(?:$ADV${l}lemma:$Quant\|${r})($ADJ$a)(?:$CONJ$a|$PRO${l}lemma:(?:que|como)\|${r})/g);
$Rel =  ">";
HeadDep_lex($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB${l}lemma:(?:ser|tornar|converter|be|become)\|${r})(?:$ADV${l}lemma:$Quant\|${r})(?:$ADJ$a)($CONJ$a|$PRO${l}lemma:(?:que|como)\|${r})/g);
$Rel =  ">";
HeadDep_lex($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:(?:ser|tornar|converter|be|become)\|${r})($ADV${l}lemma:$Quant\|${r})($ADJ$a)($CONJ$a|$PRO${l}lemma:(?:que|como)\|${r})/$1/g;
LEX();

# CoordL: ADV [Fc] [ADV] CONJ<(type:C)|(lemma:$CCord)> [ADV]
# NEXT
# PunctL: [ADV] Fc [ADV] CONJ<(type:C)|(lemma:$CCord)> [ADV]
# Recursivity: 10
(@temp) = ($listTags =~ /($ADV$a)(?:$Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADV$a)($Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV$a)($Fc$a)($ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADV$a)(?:$Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADV$a)($Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV$a)($Fc$a)($ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADV$a)(?:$Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADV$a)($Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV$a)($Fc$a)($ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADV$a)(?:$Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADV$a)($Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV$a)($Fc$a)($ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADV$a)(?:$Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADV$a)($Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV$a)($Fc$a)($ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADV$a)(?:$Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADV$a)($Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV$a)($Fc$a)($ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADV$a)(?:$Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADV$a)($Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV$a)($Fc$a)($ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADV$a)(?:$Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADV$a)($Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV$a)($Fc$a)($ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADV$a)(?:$Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADV$a)($Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV$a)($Fc$a)($ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADV$a)(?:$Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADV$a)($Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV$a)($Fc$a)($ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADV$a)(?:$Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADV$a)($Fc$a)(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV$a)($Fc$a)($ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a)/$3$4$5/g;

# CoordL: [Fc]? ADV CONJ<(type:C)|(lemma:$CCord)> [ADV]
# NEXT
# CoordR: [Fc]? [ADV] CONJ<(type:C)|(lemma:$CCord)> ADV
# Add: coord:adv
(@temp) = ($listTags =~ /(?:$Fc$a)?($ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADV$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?(?:$ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a)/g);
$Rel =  "CoordR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($Fc$a)?($ADV$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADV$a)/$1$3/g;
Add("HeadDep","coord:adv",@temp);

# PunctL: Fc CONJ<coord:adv>
(@temp) = ($listTags =~ /($Fc$a)($CONJ${l}coord:adv\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($Fc$a)($CONJ${l}coord:adv\|${r})/$2/g;

# AdjnL: ADV<lemma:$Quant> ADV|ADJ
(@temp) = ($listTags =~ /($ADV${l}lemma:$Quant\|${r})($ADV$a|$ADJ$a)/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV${l}lemma:$Quant\|${r})($ADV$a|$ADJ$a)/$2/g;

# AdjnL: ADV<lemma:[Mm]ais@de> [DET]? CARD|NOUN
(@temp) = ($listTags =~ /($ADV${l}lemma:[Mm]ais@de\|${r})(?:$DET$a)?($CARD$a|$NOUN$a)/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV${l}lemma:[Mm]ais@de\|${r})($DET$a)?($CARD$a|$NOUN$a)/$2$3/g;

# PunctL: [ADJ] Fc ADJ [NOUN]
# NEXT
# AdjnL: ADJ [Fc] ADJ [NOUN]
# Recursivity: 5
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)($ADJ$a)(?:$NOUN$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)($ADJ$a)(?:$NOUN$a)/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($NOUN$a)/$3$4/g;
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)($ADJ$a)(?:$NOUN$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)($ADJ$a)(?:$NOUN$a)/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($NOUN$a)/$3$4/g;
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)($ADJ$a)(?:$NOUN$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)($ADJ$a)(?:$NOUN$a)/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($NOUN$a)/$3$4/g;
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)($ADJ$a)(?:$NOUN$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)($ADJ$a)(?:$NOUN$a)/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($NOUN$a)/$3$4/g;
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)($ADJ$a)(?:$NOUN$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)($ADJ$a)(?:$NOUN$a)/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($NOUN$a)/$3$4/g;
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)($ADJ$a)(?:$NOUN$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)($ADJ$a)(?:$NOUN$a)/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($NOUN$a)/$3$4/g;

# CoordL: ADJ [Fc] [ADJ] CONJ<(type:C)|(lemma:$CCord)> [ADJ]
# NEXT
# PunctL: [ADJ] Fc [ADJ] CONJ<(type:C)|(lemma:$CCord)> [ADJ]
# Recursivity: 10
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a)/$3$4$5/g;
(@temp) = ($listTags =~ /($ADJ$a)(?:$Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$ADJ$a)($Fc$a)(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADJ$a)($Fc$a)($ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a)/$3$4$5/g;

# CoordL: [Fc]? ADJ CONJ<(type:C)|(lemma:$CCord)> [ADJ]
# NEXT
# CoordR: [Fc]? [ADJ] CONJ<(type:C)|(lemma:$CCord)> ADJ
# Add: coord:adj
# Inherit: gender, number
(@temp) = ($listTags =~ /(?:$Fc$a)?($ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$ADJ$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?(?:$ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a)/g);
$Rel =  "CoordR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($Fc$a)?($ADJ$a)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($ADJ$a)/$1$3/g;
Inherit("HeadDep","gender,number",@temp);
Add("HeadDep","coord:adj",@temp);

# PunctL: Fc CONJ<coord:adj>
(@temp) = ($listTags =~ /($Fc$a)($CONJ${l}coord:adj\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($Fc$a)($CONJ${l}coord:adj\|${r})/$2/g;

# AdjnR:  NOUN NOUN
# Recursivity: 1
(@temp) = ($listTags =~ /($NOUN$a)($NOUN$a)/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($NOUN$a)($NOUN$a)/$1/g;
(@temp) = ($listTags =~ /($NOUN$a)($NOUN$a)/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($NOUN$a)($NOUN$a)/$1/g;

# Single: [DET] ADJ [PRP]
# Corr: tag:NOUN
(@temp) = ($listTags =~ /(?:$DET$a)($ADJ$a)(?:$PRP$a)/g);
$Rel =  "Single";
Head($Rel,"",@temp);
$listTags =~ s/($DET$a)($ADJ$a)($PRP$a)/$1$2$3/g;
Corr("Head","tag:NOUN",@temp);

# SpecL: DET DET|PRO<type:X> [NOUN]
# NEXT
# SpecL: [DET] DET|PRO<type:X> NOUN
(@temp) = ($listTags =~ /($DET$a)($DET$a|$PRO${l}type:X\|${r})(?:$NOUN$a)/g);
$Rel =  "SpecL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$DET$a)($DET$a|$PRO${l}type:X\|${r})($NOUN$a)/g);
$Rel =  "SpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($DET$a)($DET$a|$PRO${l}type:X\|${r})($NOUN$a)/$3/g;

# SpecL: DET<type:I> DET<type:A> [PRO<type:R>]
(@temp) = ($listTags =~ /($DET${l}type:I\|${r})($DET${l}type:A\|${r})(?:$PRO${l}type:R\|${r})/g);
$Rel =  "SpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($DET${l}type:I\|${r})($DET${l}type:A\|${r})($PRO${l}type:R\|${r})/$2$3/g;

# AdjnL: [DET] VERB<mode:P> NOUN
# NEXT
# SpecL: DET [VERB<mode:P>] NOUN
(@temp) = ($listTags =~ /(?:$DET$a)($VERB${l}mode:P\|${r})($NOUN$a)/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($DET$a)(?:$VERB${l}mode:P\|${r})($NOUN$a)/g);
$Rel =  "SpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($DET$a)($VERB${l}mode:P\|${r})($NOUN$a)/$3/g;

# SpecL: DET CARD|DATE
(@temp) = ($listTags =~ /($DET$a)($CARD$a|$DATE$a)/g);
$Rel =  "SpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($DET$a)($CARD$a|$DATE$a)/$2/g;

# SpecL: DET NOUN
(@temp) = ($listTags =~ /($DET$a)($NOUN$a)/g);
$Rel =  "SpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($DET$a)($NOUN$a)/$2/g;

# SpecL: DET<type:A> PRO<type:X>
(@temp) = ($listTags =~ /($DET${l}type:A\|${r})($PRO${l}type:X\|${r})/g);
$Rel =  "SpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($DET${l}type:A\|${r})($PRO${l}type:X\|${r})/$2/g;

# SpecL: DET<type:[AD]>|PRO<type:D> PRO<type:[RW]>
# Add: sust:yes
# Inherit: number, person
(@temp) = ($listTags =~ /($DET${l}type:[AD]\|${r}|$PRO${l}type:D\|${r})($PRO${l}type:[RW]\|${r})/g);
$Rel =  "SpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($DET${l}type:[AD]\|${r}|$PRO${l}type:D\|${r})($PRO${l}type:[RW]\|${r})/$2/g;
Inherit("DepHead","number,person",@temp);
Add("DepHead","sust:yes",@temp);

# SpecL: DET<type:[AD]>|PRO<type:D> PRP<lemma:de> [NOUNSINGLE|PRO<type:D|P|I|X>]
# Add: nomin:yes
# Inherit: number, person
(@temp) = ($listTags =~ /($DET${l}type:[AD]\|${r}|$PRO${l}type:D\|${r})($PRP${l}lemma:de\|${r})(?:$NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "SpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($DET${l}type:[AD]\|${r}|$PRO${l}type:D\|${r})($PRP${l}lemma:de\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/$2$3/g;
Inherit("DepHead","number,person",@temp);
Add("DepHead","nomin:yes",@temp);

# ClitL: PRO<lemma:se> VERB
# Add: se:yes
# Uniq
(@temp) = ($listTags =~ /($PRO${l}lemma:se\|${r})($VERB$a)/g);
$Rel =  "ClitL";
DepHead($Rel,"",@temp);
$listTags =~ s/($PRO${l}lemma:se\|${r})($VERB$a)/$2/g;
Add("DepHead","se:yes",@temp);

# ClitR: VERB PRO<lemma:se>
# Add: se:yes
# Uniq
(@temp) = ($listTags =~ /($VERB$a)($PRO${l}lemma:se\|${r})/g);
$Rel =  "ClitR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($PRO${l}lemma:se\|${r})/$1/g;
Add("HeadDep","se:yes",@temp);

# ClitL: PRO<token:$cliticoind> VERB
# Add: ind:yes
# Uniq
(@temp) = ($listTags =~ /($PRO${l}token:$cliticoind\|${r})($VERB$a)/g);
$Rel =  "ClitL";
DepHead($Rel,"",@temp);
$listTags =~ s/($PRO${l}token:$cliticoind\|${r})($VERB$a)/$2/g;
Add("DepHead","ind:yes",@temp);

# ClitR: VERB PRO<token:$cliticoind>
# Add: ind:yes
# Uniq
(@temp) = ($listTags =~ /($VERB$a)($PRO${l}token:$cliticoind\|${r})/g);
$Rel =  "ClitR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($PRO${l}token:$cliticoind\|${r})/$1/g;
Add("HeadDep","ind:yes",@temp);

# ClitL: PRO<token:$cliticopers> VERB
# Recursivity: 1
(@temp) = ($listTags =~ /($PRO${l}token:$cliticopers\|${r})($VERB$a)/g);
$Rel =  "ClitL";
DepHead($Rel,"",@temp);
$listTags =~ s/($PRO${l}token:$cliticopers\|${r})($VERB$a)/$2/g;
(@temp) = ($listTags =~ /($PRO${l}token:$cliticopers\|${r})($VERB$a)/g);
$Rel =  "ClitL";
DepHead($Rel,"",@temp);
$listTags =~ s/($PRO${l}token:$cliticopers\|${r})($VERB$a)/$2/g;

# ClitR: VERB PRO<token:$cliticopers>
# Recursivity: 1
(@temp) = ($listTags =~ /($VERB$a)($PRO${l}token:$cliticopers\|${r})/g);
$Rel =  "ClitR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($PRO${l}token:$cliticopers\|${r})/$1/g;
(@temp) = ($listTags =~ /($VERB$a)($PRO${l}token:$cliticopers\|${r})/g);
$Rel =  "ClitR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($PRO${l}token:$cliticopers\|${r})/$1/g;

# VSpecL: VERB<type:S> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:P>
# Add: voice:passive
# Inherit: mode, person, tense, number
(@temp) = ($listTags =~ /($VERB${l}type:S\|${r})(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?($VERB${l}mode:P\|${r})/g);
$Rel =  "VSpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}type:S\|${r})($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($VERB${l}mode:P\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
Inherit("DepHead","mode,person,tense,number",@temp);
Add("DepHead","voice:passive",@temp);

# VSpecL: VERB<(type:A)|(lemma:ter|haver|haber|avoir|have)> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:P>
# Add: type:perfect
# Inherit: mode, person, tense, number
(@temp) = ($listTags =~ /($VERB${l}type:A\|${r}|$VERB${l}lemma:(?:ter|haver|haber|avoir|have)\|${r})(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?($VERB${l}mode:P\|${r})/g);
$Rel =  "VSpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}type:A\|${r}|$VERB${l}lemma:(?:ter|haver|haber|avoir|have)\|${r})($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($VERB${l}mode:P\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
Inherit("DepHead","mode,person,tense,number",@temp);
Add("DepHead","type:perfect",@temp);

# VSpecL: VERB<lemma:$VModalES> [ADV]? VERB<mode:N>
# Inherit: mode, person, tense, number
(@temp) = ($listTags =~ /($VERB${l}lemma:$VModalES\|${r})(?:$ADV$a)?($VERB${l}mode:N\|${r})/g);
$Rel =  "VSpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$VModalES\|${r})($ADV$a)?($VERB${l}mode:N\|${r})/$2$3/g;
Inherit("DepHead","mode,person,tense,number",@temp);

# VSpecL: [VERB<lemma:tener|haber>] [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? CONJ<lemma:que&type:S> [ADV]? VERB<mode:N>
# NEXT
# VSpecL: VERB<lemma:tener|haber> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [CONJ<lemma:que&type:S>] [ADV]? VERB<mode:N>
# Inherit: mode, person, tense, number
(@temp) = ($listTags =~ /(?:$VERB${l}lemma:(?:tener|haber)\|${r})(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?($CONJ${l}lemma:que\|${b}type:S\|${r})(?:$ADV$a)?($VERB${l}mode:N\|${r})/g);
$Rel =  "VSpecL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB${l}lemma:(?:tener|haber)\|${r})(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$CONJ${l}lemma:que\|${b}type:S\|${r})(?:$ADV$a)?($VERB${l}mode:N\|${r})/g);
$Rel =  "VSpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:(?:tener|haber)\|${r})($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($CONJ${l}lemma:que\|${b}type:S\|${r})($ADV$a)?($VERB${l}mode:N\|${r})/$2$3$4$5$6$7$8$9$10$11$13$14/g;
Inherit("DepHead","mode,person,tense,number",@temp);

# VSpecL: [VERB<lemma:ir|venir|empezar|comenzar|acabar|finalizar|terminar|pasar|estar>] [ADV]? PRP<lemma:$PrepLocs> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:N>
# NEXT
# VSpecL: VERB<lemma:ir|deber|venir|empezar|comenzar|acabar|finalizar|terminar|pasar|estar> [ADV]? [PRP<lemma:$PrepLocs>] [ADV]? VERB<mode:N>
# Inherit: mode, person, tense, number
(@temp) = ($listTags =~ /(?:$VERB${l}lemma:(?:ir|venir|empezar|comenzar|acabar|finalizar|terminar|pasar|estar)\|${r})(?:$ADV$a)?($PRP${l}lemma:$PrepLocs\|${r})(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?($VERB${l}mode:N\|${r})/g);
$Rel =  "VSpecL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB${l}lemma:(?:ir|deber|venir|empezar|comenzar|acabar|finalizar|terminar|pasar|estar)\|${r})(?:$ADV$a)?(?:$PRP${l}lemma:$PrepLocs\|${r})(?:$ADV$a)?($VERB${l}mode:N\|${r})/g);
$Rel =  "VSpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:(?:ir|deber|venir|empezar|comenzar|acabar|finalizar|terminar|pasar|estar)\|${r})($ADV$a)?($PRP${l}lemma:$PrepLocs\|${r})($ADV$a)?($VERB${l}mode:N\|${r})/$2$4$5/g;
Inherit("DepHead","mode,person,tense,number",@temp);

# VSpecL: VERB<lemma:querer|desear|pensar|soler|acostumbrar> [ADV]? VERB<mode:N>
# Inherit: mode, person, tense, number
(@temp) = ($listTags =~ /($VERB${l}lemma:(?:querer|desear|pensar|soler|acostumbrar)\|${r})(?:$ADV$a)?($VERB${l}mode:N\|${r})/g);
$Rel =  "VSpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:(?:querer|desear|pensar|soler|acostumbrar)\|${r})($ADV$a)?($VERB${l}mode:N\|${r})/$2$3/g;
Inherit("DepHead","mode,person,tense,number",@temp);

# VSpecL: VERB<lemma:estar> [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? [ADV]? VERB<mode:G>
# Inherit: mode, person, tense, number
(@temp) = ($listTags =~ /($VERB${l}lemma:estar\|${r})(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?(?:$ADV$a)?($VERB${l}mode:G\|${r})/g);
$Rel =  "VSpecL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:estar\|${r})($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($ADV$a)?($VERB${l}mode:G\|${r})/$2$3$4$5$6$7$8$9$10$11$12/g;
Inherit("DepHead","mode,person,tense,number",@temp);

# PunctL: [ADV<pos:0>] Fc VERB
# NEXT
# AdjnL: ADV<pos:0> [Fc] VERB
(@temp) = ($listTags =~ /(?:$ADV${l}pos:0\|${r})($Fc$a)($VERB$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($ADV${l}pos:0\|${r})(?:$Fc$a)($VERB$a)/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV${l}pos:0\|${r})($Fc$a)($VERB$a)/$3/g;

# PunctR:  VERB [Fc]? [ADV] Fc
# NEXT
# PunctR: VERB Fc [ADV] [Fc]
# NEXT
# AdjnR: VERB [Fc]? ADV [Fc]
(@temp) = ($listTags =~ /($VERB$a)(?:$Fc$a)?(?:$ADV$a)($Fc$a)/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a)($Fc$a)(?:$ADV$a)(?:$Fc$a)/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a)(?:$Fc$a)?($ADV$a)(?:$Fc$a)/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($Fc$a)?($ADV$a)($Fc$a)/$1/g;

# PunctL: Fc [ADV] [Fc]? VERB
# NEXT
# PunctL: [Fc] [ADV] Fc VERB
# NEXT
# AdjnL: [Fc] ADV [Fc]? VERB
(@temp) = ($listTags =~ /($Fc$a)(?:$ADV$a)(?:$Fc$a)?($VERB$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)(?:$ADV$a)($Fc$a)($VERB$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)($ADV$a)(?:$Fc$a)?($VERB$a)/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
$listTags =~ s/($Fc$a)($ADV$a)($Fc$a)?($VERB$a)/$4/g;

# AdjnR: VERB [NOUN|PRO<type:D|P|I|X>]? ADV|CONJ<coord:adv>
# Recursivity: 1
(@temp) = ($listTags =~ /($VERB$a)(?:$NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a|$CONJ${l}coord:adv\|${r})/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a|$CONJ${l}coord:adv\|${r})/$1$2/g;
(@temp) = ($listTags =~ /($VERB$a)(?:$NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a|$CONJ${l}coord:adv\|${r})/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})?($ADV$a|$CONJ${l}coord:adv\|${r})/$1$2/g;

# AdjnL:  ADV|CONJ<coord:adv>  VERB
# Recursivity: 1
(@temp) = ($listTags =~ /($ADV$a|$CONJ${l}coord:adv\|${r})($VERB$a)/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV$a|$CONJ${l}coord:adv\|${r})($VERB$a)/$2/g;
(@temp) = ($listTags =~ /($ADV$a|$CONJ${l}coord:adv\|${r})($VERB$a)/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
$listTags =~ s/($ADV$a|$CONJ${l}coord:adv\|${r})($VERB$a)/$2/g;

# TermR: PRP NOUN [Fc] [PRP] [NOUN] [CONJ<lemma:$CCord>] [PRP] [NOUN]
# NEXT
# CoordL: PRP [NOUN] [Fc] [PRP] [NOUN] CONJ<lemma:$CCord> [PRP] [NOUN]
# NEXT
# PunctL: [PRP] [NOUN] Fc [PRP] [NOUN] CONJ<lemma:$CCord> [PRP] [NOUN]
# Recursivity: 3
(@temp) = ($listTags =~ /($PRP$a)($NOUN$a)(?:$Fc$a)(?:$PRP$a)(?:$NOUN$a)(?:$CONJ${l}lemma:$CCord\|${r})(?:$PRP$a)(?:$NOUN$a)/g);
$Rel =  "TermR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($PRP$a)(?:$NOUN$a)(?:$Fc$a)(?:$PRP$a)(?:$NOUN$a)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a)(?:$NOUN$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$PRP$a)(?:$NOUN$a)($Fc$a)(?:$PRP$a)(?:$NOUN$a)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a)(?:$NOUN$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($PRP$a)($NOUN$a)($Fc$a)($PRP$a)($NOUN$a)($CONJ${l}lemma:$CCord\|${r})($PRP$a)($NOUN$a)/$4$5$6$7$8/g;
(@temp) = ($listTags =~ /($PRP$a)($NOUN$a)(?:$Fc$a)(?:$PRP$a)(?:$NOUN$a)(?:$CONJ${l}lemma:$CCord\|${r})(?:$PRP$a)(?:$NOUN$a)/g);
$Rel =  "TermR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($PRP$a)(?:$NOUN$a)(?:$Fc$a)(?:$PRP$a)(?:$NOUN$a)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a)(?:$NOUN$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$PRP$a)(?:$NOUN$a)($Fc$a)(?:$PRP$a)(?:$NOUN$a)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a)(?:$NOUN$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($PRP$a)($NOUN$a)($Fc$a)($PRP$a)($NOUN$a)($CONJ${l}lemma:$CCord\|${r})($PRP$a)($NOUN$a)/$4$5$6$7$8/g;
(@temp) = ($listTags =~ /($PRP$a)($NOUN$a)(?:$Fc$a)(?:$PRP$a)(?:$NOUN$a)(?:$CONJ${l}lemma:$CCord\|${r})(?:$PRP$a)(?:$NOUN$a)/g);
$Rel =  "TermR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($PRP$a)(?:$NOUN$a)(?:$Fc$a)(?:$PRP$a)(?:$NOUN$a)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a)(?:$NOUN$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$PRP$a)(?:$NOUN$a)($Fc$a)(?:$PRP$a)(?:$NOUN$a)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a)(?:$NOUN$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($PRP$a)($NOUN$a)($Fc$a)($PRP$a)($NOUN$a)($CONJ${l}lemma:$CCord\|${r})($PRP$a)($NOUN$a)/$4$5$6$7$8/g;
(@temp) = ($listTags =~ /($PRP$a)($NOUN$a)(?:$Fc$a)(?:$PRP$a)(?:$NOUN$a)(?:$CONJ${l}lemma:$CCord\|${r})(?:$PRP$a)(?:$NOUN$a)/g);
$Rel =  "TermR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($PRP$a)(?:$NOUN$a)(?:$Fc$a)(?:$PRP$a)(?:$NOUN$a)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a)(?:$NOUN$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$PRP$a)(?:$NOUN$a)($Fc$a)(?:$PRP$a)(?:$NOUN$a)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a)(?:$NOUN$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($PRP$a)($NOUN$a)($Fc$a)($PRP$a)($NOUN$a)($CONJ${l}lemma:$CCord\|${r})($PRP$a)($NOUN$a)/$4$5$6$7$8/g;

# CoordL: [Fc]? PRP [NOUN] CONJ<lemma:$CCord> [PRP] [NOUN]
# NEXT
# TermR: [Fc]? [PRP] [NOUN] [CONJ<lemma:$CCord>] PRP NOUN
# NEXT
# TermR: [Fc]? PRP NOUN [CONJ<lemma:$CCord>] [PRP] [NOUN]
# NEXT
# CoordR: [Fc]? [PRP] [NOUN] CONJ<lemma:$CCord> PRP [NOUN]
# Add: coord:cprep
(@temp) = ($listTags =~ /(?:$Fc$a)?($PRP$a)(?:$NOUN$a)($CONJ${l}lemma:$CCord\|${r})(?:$PRP$a)(?:$NOUN$a)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?(?:$PRP$a)(?:$NOUN$a)(?:$CONJ${l}lemma:$CCord\|${r})($PRP$a)($NOUN$a)/g);
$Rel =  "TermR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?($PRP$a)($NOUN$a)(?:$CONJ${l}lemma:$CCord\|${r})(?:$PRP$a)(?:$NOUN$a)/g);
$Rel =  "TermR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?(?:$PRP$a)(?:$NOUN$a)($CONJ${l}lemma:$CCord\|${r})($PRP$a)(?:$NOUN$a)/g);
$Rel =  "CoordR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($Fc$a)?($PRP$a)($NOUN$a)($CONJ${l}lemma:$CCord\|${r})($PRP$a)($NOUN$a)/$1$4/g;
Add("HeadDep","coord:cprep",@temp);

# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /(?:$NOUNSINGLE$a)(?:$PRP$a)(?:$NOUNSINGLE$a)(?:$PRP$a)(?:$NOUNSINGLE$a)(?:$PRP$a)(?:$NOUNSINGLE$a)(?:$PRP$a)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP$a)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7$8$9/g;

# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /(?:$NOUNSINGLE$a)(?:$PRP$a)(?:$NOUNSINGLE$a)(?:$PRP$a)(?:$NOUNSINGLE$a)(?:$PRP$a)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP$a)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7/g;

# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /(?:$NOUNSINGLE$a)(?:$PRP$a)(?:$NOUNSINGLE$a)(?:$PRP$a)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP$a)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;

# CprepR: [NOUNSINGLE] [PRP] NOUN<type:C> PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /(?:$NOUNSINGLE$a)(?:$PRP$a)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($NOUNSINGLE$a)($PRP$a)($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3/g;

# CprepR: NOUN<type:C> PRP<lemma:$PrepRA> NOUNSINGLE|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($NOUN${l}type:C\|${r})($PRP${l}lemma:$PrepRA\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUNSINGLE PRP<lemma:de> NOUNSINGLE|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /(?:$NOUNSINGLE$a)(?:$PRP$a)(?:$NOUNSINGLE$a)(?:$PRP$a)(?:$NOUNSINGLE$a)(?:$PRP$a)(?:$NOUNSINGLE$a)(?:$PRP$a)($NOUNSINGLE$a)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7$8$9/g;

# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUNSINGLE PRP<lemma:de> NOUNSINGLE|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /(?:$NOUNSINGLE$a)(?:$PRP$a)(?:$NOUNSINGLE$a)(?:$PRP$a)(?:$NOUNSINGLE$a)(?:$PRP$a)($NOUNSINGLE$a)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5$6$7/g;

# CprepR: [NOUNSINGLE] [PRP] [NOUNSINGLE] [PRP] NOUNSINGLE PRP<lemma:de> NOUNSINGLE|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /(?:$NOUNSINGLE$a)(?:$PRP$a)(?:$NOUNSINGLE$a)(?:$PRP$a)($NOUNSINGLE$a)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;

# CprepR: [NOUNSINGLE] [PRP] NOUNSINGLE PRP<lemma:de> NOUNSINGLE|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /(?:$NOUNSINGLE$a)(?:$PRP$a)($NOUNSINGLE$a)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($NOUNSINGLE$a)($PRP$a)($NOUNSINGLE$a)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3/g;

# CprepR: NOUNSINGLE PRP<lemma:de> NOUNSINGLE|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /($NOUNSINGLE$a)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($NOUNSINGLE$a)($PRP${l}lemma:de\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# CprepR: X<lemma:uno>|PRO<type:[DI]> PRP NOUNSINGLE|PRO<type:D|P|I|X>
# Add: tag:PRO
(@temp) = ($listTags =~ /($X${l}lemma:uno\|${r}|$PRO${l}type:[DI]\|${r})($PRP$a)($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($X${l}lemma:uno\|${r}|$PRO${l}type:[DI]\|${r})($PRP$a)($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
Add("HeadRelDep","tag:PRO",@temp);

# TermR: PRP<nomin:yes> NOUNSINGLE|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /($PRP${l}nomin:yes\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "TermR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($PRP${l}nomin:yes\|${r})($NOUNSINGLE$a|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# CoordL: NP [Fc] [NP] CONJ<(type:C)|(lemma:$CCord)> [NP]
# NEXT
# PunctL: [NP] Fc [NP] CONJ<(type:C)|(lemma:$CCord)> [NP]
# Recursivity: 10
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;

# CoordL: [Fc]? NP CONJ<(type:C)|(lemma:$CCord)> [NP]
# NEXT
# CoordR: [Fc]? [NP] CONJ<(type:C)|(lemma:$CCord)> NP
# Add: coord:noun
(@temp) = ($listTags =~ /(?:$Fc$a)?($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/g);
$Rel =  "CoordR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($Fc$a)?($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$1$3/g;
Add("HeadDep","coord:noun",@temp);

# PunctL: Fc CONJ<coord:noun>
(@temp) = ($listTags =~ /($Fc$a)($CONJ${l}coord:noun\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($Fc$a)($CONJ${l}coord:noun\|${r})/$2/g;

# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc|Fpa|Fca NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
# NEXT
# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] NOUNCOORD|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
# NEXT
# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
(@temp) = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a|$Fpa$a|$Fca$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a)(?:$Fc$a|$Fpt$a|$Fct$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a|$Fpa$a|$Fca$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a)($Fc$a|$Fpt$a|$Fct$a)/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a|$Fpa$a|$Fca$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a)(?:$Fc$a|$Fpt$a|$Fct$a)/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a|$Fpa$a|$Fca$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a)($Fc$a|$Fpt$a|$Fct$a)/$1/g;

# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc|Fpa|Fca [PRP] NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
# NEXT
# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] [PRP] NOUNCOORD|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
# NEXT
# CprepR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] PRP NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
(@temp) = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a|$Fpa$a|$Fca$a)(?:$PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a)(?:$Fc$a|$Fpt$a|$Fct$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a|$Fpa$a|$Fca$a)(?:$PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a)($Fc$a|$Fpt$a|$Fct$a)/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a|$Fpa$a|$Fca$a)($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a)(?:$Fc$a|$Fpt$a|$Fct$a)/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a|$Fpa$a|$Fca$a)($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a)($Fc$a|$Fpt$a|$Fct$a)/$1/g;

# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] VERB<mode:P> [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [X]? [Fc|Fpt|Fct]
# NoUniq
(@temp) = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a|$Fpa$a|$Fca$a)($VERB${l}mode:P\|${r})(?:$X$a)?(?:$X$a)?(?:$X$a)?(?:$X$a)?(?:$X$a)?(?:$X$a)?(?:$X$a)?(?:$X$a)?(?:$X$a)?(?:$X$a)?(?:$Fc$a|$Fpt$a|$Fct$a)/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a|$Fpa$a|$Fca$a)($VERB${l}mode:P\|${r})($X$a)?($X$a)?($X$a)?($X$a)?($X$a)?($X$a)?($X$a)?($X$a)?($X$a)?($X$a)?($Fc$a|$Fpt$a|$Fct$a)/$1$2$3$4$5$6$7$8$9$10$11$12$13$14/g;

# Single: [VERB<lemma:$SubcatClaus>]  [PRP<lemma:a>] [NOUNCOORD|PRO<type:D|P|I|X>] PRO<type:R>  [NOUNCOORD|PRO<type:D|P|I|X>]?  [VERB<mode:[^PNG]>]
# Corr: tag:CONJ, type:S
(@temp) = ($listTags =~ /(?:$VERB${l}lemma:$SubcatClaus\|${r})(?:$PRP${l}lemma:a\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRO${l}type:R\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?(?:$VERB${l}mode:[^PNG]\|${r})/g);
$Rel =  "Single";
Head($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatClaus\|${r})($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRO${l}type:R\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($VERB${l}mode:[^PNG]\|${r})/$1$2$3$4$5$6/g;
Corr("Head","tag:CONJ,type:S",@temp);

# Single: [VERB<lemma:$SubcatClaus>]  [ADJ] PRO<type:R>  [NOUNCOORD|PRO<type:D|P|I|X>]?  [VERB<mode:[^PNG]>]
# Corr: tag:CONJ, type:S
(@temp) = ($listTags =~ /(?:$VERB${l}lemma:$SubcatClaus\|${r})(?:$ADJ$a)($PRO${l}type:R\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?(?:$VERB${l}mode:[^PNG]\|${r})/g);
$Rel =  "Single";
Head($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatClaus\|${r})($ADJ$a)($PRO${l}type:R\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($VERB${l}mode:[^PNG]\|${r})/$1$2$3$4$5/g;
Corr("Head","tag:CONJ,type:S",@temp);

# SubjL: [NOUN] PRO<type:R|W> VERB|CONJ<coord:verb>
# NEXT
# AdjnR: NOUN [PRO<type:R|W>] VERB|CONJ<coord:verb>
# NoUniq
(@temp) = ($listTags =~ /(?:$NOUN$a)($PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "SubjL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($NOUN$a)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($NOUN$a)($PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})/$1$2$3/g;

# DobjL: [NOUN] PRO<type:R|W> [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>
# NEXT
# AdjnR: NOUN [PRO<type:R|W>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB|CONJ<coord:verb>
# NoUniq
(@temp) = ($listTags =~ /(?:$NOUN$a)($PRO${l}type:(?:R|W)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "DobjL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($NOUN$a)(?:$PRO${l}type:(?:R|W)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($NOUN$a)($PRO${l}type:(?:R|W)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})/$1$2$3$4/g;

# CircL: [NOUN|PRO<type:D|P|I|X>]  PRP PRO<type:R|W> VERB|CONJ<coord:verb>
# NEXT
# AdjnR: NOUN|PRO<type:D|P|I|X> [PRP] [PRO<type:R|W>] VERB|CONJ<coord:verb>
# NoUniq
(@temp) = ($listTags =~ /(?:$NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a)($PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "CircL";
RelDepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP$a)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a)($PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})/$1$2$3$4/g;

# AdjnR: NOUN|PRO<type:D|P|I|X>  VERB<mode:[GP]>|CONJ<coord:verb>
# NoUniq
(@temp) = ($listTags =~ /($NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/$1$2/g;

# CircR: VERB<mode:P> [NOUNCOORD|PRO<type:D|P|I|X>] PRP<lemma:por|by> NOUNCOORD|PRO<type:D|P|I|X>|ADV
(@temp) = ($listTags =~ /($VERB${l}mode:P\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:(?:por|by)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$ADV$a)/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}mode:P\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:(?:por|by)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$ADV$a)/$1$2/g;

# PunctR: VERB Fc [NOUNCOORD|PRO<type:D|P|I|X>] [PRP<lemma:$PrepMA>] [CARD|DATE]
# NEXT
# CircR: VERB [Fc]? [NOUNCOORD|PRO<type:D|P|I|X>] PRP<lemma:$PrepMA> CARD|DATE
(@temp) = ($listTags =~ /($VERB$a)($Fc$a)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP${l}lemma:$PrepMA\|${r})(?:$CARD$a|$DATE$a)/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a)(?:$Fc$a)?(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:$PrepMA\|${r})($CARD$a|$DATE$a)/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($Fc$a)?($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP${l}lemma:$PrepMA\|${r})($CARD$a|$DATE$a)/$1$3/g;

# CprepR: CARD PRP<lemma:de|entre|sobre|of|about|between> NOUNCOORD|PRO
(@temp) = ($listTags =~ /($CARD$a)($PRP${l}lemma:(?:de|entre|sobre|of|about|between)\|${r})($NOUNCOORD|$PRO$a)/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($CARD$a)($PRP${l}lemma:(?:de|entre|sobre|of|about|between)\|${r})($NOUNCOORD|$PRO$a)/$1/g;

# CprepR: PRO<type:P> PRP<lemma:de|of> NOUNCOORD|PRO
(@temp) = ($listTags =~ /($PRO${l}type:P\|${r})($PRP${l}lemma:(?:de|of)\|${r})($NOUNCOORD|$PRO$a)/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($PRO${l}type:P\|${r})($PRP${l}lemma:(?:de|of)\|${r})($NOUNCOORD|$PRO$a)/$1/g;

# CprepR: NOUNCOORD [PRP] [PRO<type:D|P|I|X>] PRP NOUNCOORD|ADV
# NEXT
# CprepR: NOUNCOORD PRP PRO<type:D|P|I|X> [PRP] [NOUNCOORD|ADV]
(@temp) = ($listTags =~ /($NOUNCOORD)(?:$PRP$a)(?:$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a)($NOUNCOORD|$ADV$a)/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($NOUNCOORD)($PRP$a)($PRO${l}type:(?:D|P|I|X)\|${r})(?:$PRP$a)(?:$NOUNCOORD|$ADV$a)/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($NOUNCOORD)($PRP$a)($PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a)($NOUNCOORD|$ADV$a)/$1/g;

# PrepR: VERB [NOUNCOORD|PRO<type:D|P|I|X>] CONJ<coord:cprep>
(@temp) = ($listTags =~ /($VERB$a)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($CONJ${l}coord:cprep\|${r})/g);
$Rel =  "PrepR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($CONJ${l}coord:cprep\|${r})/$1$2/g;

# PrepR: NOUNCOORD|PRO<type:D|P|I|X> CONJ<coord:cprep>
(@temp) = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($CONJ${l}coord:cprep\|${r})/g);
$Rel =  "PrepR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($CONJ${l}coord:cprep\|${r})/$1/g;

# SubjL: PRO<sust:yes>  VERB
# Add: nomin:yes
# Inherit: number, person
(@temp) = ($listTags =~ /($PRO${l}sust:yes\|${r})($VERB$a)/g);
$Rel =  "SubjL";
DepHead($Rel,"",@temp);
$listTags =~ s/($PRO${l}sust:yes\|${r})($VERB$a)/$2/g;
Inherit("DepHead","number,person",@temp);
Add("DepHead","nomin:yes",@temp);

# SubjL: [PRO<sust:yes>] NOUNCOORD|PRO<type:D|P|I|X> VERB
# NEXT
# DobjL: PRO<sust:yes> [NOUNCOORD|PRO<type:D|P|I|X>] VERB
# Add: nomin:yes
# Inherit: number, person
(@temp) = ($listTags =~ /(?:$PRO${l}sust:yes\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a)/g);
$Rel =  "SubjL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($PRO${l}sust:yes\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a)/g);
$Rel =  "DobjL";
DepHead($Rel,"",@temp);
$listTags =~ s/($PRO${l}sust:yes\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB$a)/$3/g;
Inherit("DepHead","number,person",@temp);
Add("DepHead","nomin:yes",@temp);

# DobjPrepR: VERB<lemma:$SubcatTr> PRP<lemma:a> NOUNCOORD|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatTr\|${r})($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "DobjPrepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatTr\|${r})($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# AtrR: VERB<lemma:ser> NOUNCOORD|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /($VERB${l}lemma:ser\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "AtrR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:ser\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# AtrR: VERB ADJ|CONJ<coord:adj>
(@temp) = ($listTags =~ /($VERB$a)($ADJ$a|$CONJ${l}coord:adj\|${r})/g);
$Rel =  "AtrR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($ADJ$a|$CONJ${l}coord:adj\|${r})/$1/g;

# DobjR: VERB NOUNCOORD|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /($VERB$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "DobjR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# IobjR: VERB<lemma:($SubcatIND)|(SubcatBitr)>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:a> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatIND\|${r}|$VERB${l}SubcatBitr\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "IobjR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatIND\|${r}|$VERB${l}SubcatBitr\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CregR: VERB<lemma:$SubcatA>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:a> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatA\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "CregR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatA\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CregR: VERB<lemma:$SubcatEN>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:en> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatEN\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:en\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "CregR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatEN\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:en\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CregR: VERB<lemma:$SubcatDE>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:de> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatDE\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:de\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "CregR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatDE\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:de\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CregR: VERB<lemma:$SubcatCON>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:con> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatCON\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:con\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "CregR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatCON\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:con\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CregR: VERB<lemma:$SubcatPOR>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:por> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatPOR\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:por\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "CregR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatPOR\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:por\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CregR: VERB<lemma:$SubcatHACIA>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:hacia> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatHACIA\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:hacia\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "CregR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatHACIA\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:hacia\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CregR: VERB<lemma:$SubcatSOBRE>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:sobre> NOUNCOORD|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatSOBRE\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:sobre\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "CregR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatSOBRE\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:sobre\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CoordL: NP [Fc] [NP] CONJ<(type:C)|(lemma:$CCord)> [NP]
# NEXT
# PunctL: [NP] Fc [NP] CONJ<(type:C)|(lemma:$CCord)> [NP]
# Recursivity: 5
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;

# CoordL: [Fc]? NP CONJ<(type:C)|(lemma:$CCord)> [NP]
# NEXT
# CoordR: [Fc]? [NP] CONJ<(type:C)|(lemma:$CCord)> NP
# Add: coord:noun
(@temp) = ($listTags =~ /(?:$Fc$a)?($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/g);
$Rel =  "CoordR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($Fc$a)?($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$1$3/g;
Add("HeadDep","coord:noun",@temp);

# PunctL: Fc CONJ<coord:noun>
(@temp) = ($listTags =~ /($Fc$a)($CONJ${l}coord:noun\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($Fc$a)($CONJ${l}coord:noun\|${r})/$2/g;

# CoordL: VERB<nomin:no> [Fc] [VERB<nomin:no>] CONJ<(type:C)|(lemma:$CCord)> [VERB<nomin:no>]
# NEXT
# PunctL: [VERB<nomin:no>] Fc [VERB<nomin:no>] CONJ<(type:C)|(lemma:$CCord)> [VERB<nomin:no>]
# Recursivity: 5
(@temp) = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
(@temp) = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
(@temp) = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
(@temp) = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
(@temp) = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
(@temp) = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;

# CoordL: [Fc]? VERB<nomin:no> CONJ<(type:C)|(lemma:$CCord)> [VERB<nomin:no>]
# NEXT
# CoordR: [Fc]? [VERB<nomin:no>] CONJ<(type:C)|(lemma:$CCord)> VERB<nomin:no>
# Add: coord:verb
# Inherit: mode, tense
(@temp) = ($listTags =~ /(?:$Fc$a)?($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($Fc$a)?($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$1$3/g;
Inherit("HeadDep","mode,tense",@temp);
Add("HeadDep","coord:verb",@temp);

# PunctL: Fc CONJ<coord:verb>
(@temp) = ($listTags =~ /($Fc$a)($CONJ${l}coord:verb\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($Fc$a)($CONJ${l}coord:verb\|${r})/$2/g;

# CircR: [VERB|CONJ<coord:verb>] [PRP] VERB|CONJ<coord:verb> [PRP] [CARD|NOUNCOORD|PRO<type:D|P|I|X>] PRP CARD|NOUNCOORD|PRO<type:D|P|I|X>
# Recursivity: 1
(@temp) = ($listTags =~ /(?:$VERB$a|$CONJ${l}coord:verb\|${r})(?:$PRP$a)($VERB$a|$CONJ${l}coord:verb\|${r})(?:$PRP$a)(?:$CARD$a|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a)($CARD$a|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($CARD$a|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a)($CARD$a|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;
(@temp) = ($listTags =~ /(?:$VERB$a|$CONJ${l}coord:verb\|${r})(?:$PRP$a)($VERB$a|$CONJ${l}coord:verb\|${r})(?:$PRP$a)(?:$CARD$a|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a)($CARD$a|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($CARD$a|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($PRP$a)($CARD$a|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1$2$3$4$5/g;

# CircR: [VERB|CONJ<coord:verb>] [PRP] VERB|CONJ<coord:verb> PRP CARD|NOUNCOORD|PRO<type:D|P|I|X>
# NEXT
# CircR: VERB|CONJ<coord:verb> PRP VERB|CONJ<coord:verb> [PRP] [CARD|NOUNCOORD|PRO<type:D|P|I|X>]
(@temp) = ($listTags =~ /(?:$VERB$a|$CONJ${l}coord:verb\|${r})(?:$PRP$a)($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($CARD$a|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($VERB$a|$CONJ${l}coord:verb\|${r})(?:$PRP$a)(?:$CARD$a|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($CARD$a|$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# CircR: VERB|CONJ<coord:verb>  PRP VERB<mode:[^PG]>|ADV|CARD
# Recursivity: 1
(@temp) = ($listTags =~ /($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($VERB${l}mode:[^PG]\|${r}|$ADV$a|$CARD$a)/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($VERB${l}mode:[^PG]\|${r}|$ADV$a|$CARD$a)/$1/g;
(@temp) = ($listTags =~ /($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($VERB${l}mode:[^PG]\|${r}|$ADV$a|$CARD$a)/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($VERB${l}mode:[^PG]\|${r}|$ADV$a|$CARD$a)/$1/g;

# SpecL: [VERB|CONJ<coord:verb>]  [PRP] DET<type:A>  VERB<mode:N>|ADV|CARD
# NEXT
# CircR: VERB|CONJ<coord:verb>  PRP  [DET<type:A>] VERB<mode:N>|ADV|CARD
# Recursivity: 1
(@temp) = ($listTags =~ /(?:$VERB$a|$CONJ${l}coord:verb\|${r})(?:$PRP$a)($DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a|$CARD$a)/g);
$Rel =  "SpecL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)(?:$DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a|$CARD$a)/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a|$CARD$a)/$1/g;
(@temp) = ($listTags =~ /(?:$VERB$a|$CONJ${l}coord:verb\|${r})(?:$PRP$a)($DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a|$CARD$a)/g);
$Rel =  "SpecL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)(?:$DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a|$CARD$a)/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($DET${l}type:A\|${r})($VERB${l}mode:N\|${r}|$ADV$a|$CARD$a)/$1/g;

# CircR: VERB|CONJ<coord:verb> PRP NOUNCOORD|PRO<type:D|P|I|X>
# Recursivity: 1
(@temp) = ($listTags =~ /($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;
(@temp) = ($listTags =~ /($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB$a|$CONJ${l}coord:verb\|${r})($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# PunctR: VERB Fc [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?
# NEXT
# PunctR: VERB [Fc] [PRP] [NOUNCOORD|PRO<type:D|P|I|X>] Fc
# NEXT
# TermR: [VERB] [Fc] PRP NOUNCOORD|PRO<type:D|P|I|X> [Fc]?
# NEXT
# CircR: VERB [Fc] PRP [NOUNCOORD|PRO<type:D|P|I|X>] [Fc]?
# Recursivity:2
(@temp) = ($listTags =~ /($VERB$a)($Fc$a)(?:$PRP$a)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a)(?:$Fc$a)(?:$PRP$a)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB$a)(?:$Fc$a)($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?/g);
$Rel =  "TermR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a)(?:$Fc$a)($PRP$a)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($Fc$a)($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)?/$1/g;
(@temp) = ($listTags =~ /($VERB$a)($Fc$a)(?:$PRP$a)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a)(?:$Fc$a)(?:$PRP$a)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB$a)(?:$Fc$a)($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?/g);
$Rel =  "TermR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a)(?:$Fc$a)($PRP$a)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($Fc$a)($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)?/$1/g;
(@temp) = ($listTags =~ /($VERB$a)($Fc$a)(?:$PRP$a)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a)(?:$Fc$a)(?:$PRP$a)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB$a)(?:$Fc$a)($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?/g);
$Rel =  "TermR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a)(?:$Fc$a)($PRP$a)(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($Fc$a)($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)?/$1/g;

# PunctL: [PRP<pos:0>] [NOUNCOORD|PRO<type:D|P|I|X>] Fc  VERB<mode:[^PNG]>|CONJ<coord:verb>
# NEXT
# CircL: PRP<pos:0> NOUNCOORD|PRO<type:D|P|I|X> [Fc]?  VERB<mode:[^PNG]>|CONJ<coord:verb>
(@temp) = ($listTags =~ /(?:$PRP${l}pos:0\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($PRP${l}pos:0\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "CircL";
RelDepHead($Rel,"",@temp);
$listTags =~ s/($PRP${l}pos:0\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/$4/g;

# PunctL: Fc [PRP] [NOUNCOORD|PRO<type:D|P|I|X> ] [Fc]?  VERB<mode:[^PNG]>|CONJ<coord:verb>
# NEXT
# PunctL: [Fc]? [PRP] [NOUNCOORD|PRO<type:D|P|I|X> ] Fc  VERB<mode:[^PNG]>|CONJ<coord:verb>
# NEXT
# CircL: [Fc]? PRP NOUNCOORD|PRO<type:D|P|I|X>  [Fc]?  VERB<mode:[^PNG]>|CONJ<coord:verb>
# Recursivity:1
(@temp) = ($listTags =~ /($Fc$a)(?:$PRP$a)([NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(])(?:$Fc$a)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?(?:$PRP$a)([NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(])($Fc$a)($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "CircL";
RelDepHead($Rel,"",@temp);
$listTags =~ s/($Fc$a)?($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/$5/g;
(@temp) = ($listTags =~ /($Fc$a)(?:$PRP$a)([NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(])(?:$Fc$a)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?(?:$PRP$a)([NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(])($Fc$a)($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "CircL";
RelDepHead($Rel,"",@temp);
$listTags =~ s/($Fc$a)?($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)?($VERB${l}mode:[^PNG]\|${r}|$CONJ${l}coord:verb\|${r})/$5/g;

# AtrR: VERB<lemma:$SubcatAtr>  VERB<mode:[PNG]>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatAtr\|${r})($VERB${l}mode:[PNG]\|${r})/g);
$Rel =  "AtrR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatAtr\|${r})($VERB${l}mode:[PNG]\|${r})/$1/g;

# Circ2R: VERB VERB<mode:[GP]>
(@temp) = ($listTags =~ /($VERB$a)($VERB${l}mode:[GP]\|${r})/g);
$Rel =  "Circ2R";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($VERB${l}mode:[GP]\|${r})/$1/g;

# DobjR: VERB VERB<mode:N>
(@temp) = ($listTags =~ /($VERB$a)($VERB${l}mode:N\|${r})/g);
$Rel =  "DobjR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($VERB${l}mode:N\|${r})/$1/g;

# AdjnR:  VERB<mode:[^PNG]> DATE
(@temp) = ($listTags =~ /($VERB${l}mode:[^PNG]\|${r})($DATE$a)/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}mode:[^PNG]\|${r})($DATE$a)/$1/g;

# PunctL: Fc [DATE] VERB<mode:[^PNG]>
# NEXT
# AdjnL:  [Fc]? DATE VERB<mode:[^PNG]>
(@temp) = ($listTags =~ /($Fc$a)(?:$DATE$a)($VERB${l}mode:[^PNG]\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?($DATE$a)($VERB${l}mode:[^PNG]\|${r})/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
$listTags =~ s/($Fc$a)?($DATE$a)($VERB${l}mode:[^PNG]\|${r})/$3/g;

# CprepR: NOUNCOORD PRP NOUNCOORD
(@temp) = ($listTags =~ /($NOUNCOORD)($PRP$a)($NOUNCOORD)/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($NOUNCOORD)($PRP$a)($NOUNCOORD)/$1/g;

# Single: [VERB<lemma:$SubcatClaus>]  PRO<type:R>  [NOUNCOORD|PRO<type:D|P|I|X>]?  [VERB<mode:[^PNG]>]
# Corr: tag:CONJ, type:S
(@temp) = ($listTags =~ /(?:$VERB${l}lemma:$SubcatClaus\|${r})($PRO${l}type:R\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?(?:$VERB${l}mode:[^PNG]\|${r})/g);
$Rel =  "Single";
Head($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatClaus\|${r})($PRO${l}type:R\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($VERB${l}mode:[^PNG]\|${r})/$1$2$3$4/g;
Corr("Head","tag:CONJ,type:S",@temp);

# SpecL: [VERB] CONJ<lemma:que|si> VERB<mode:[^PNG]>
# NEXT
# DobjR: VERB  [CONJ<lemma:que|si>] VERB<mode:[^PNG]>
(@temp) = ($listTags =~ /(?:$VERB$a)($CONJ${l}lemma:(?:que|si)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
$Rel =  "SpecL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a)(?:$CONJ${l}lemma:(?:que|si)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
$Rel =  "DobjR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($CONJ${l}lemma:(?:que|si)\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

# SpecL: [VERB]  CONJ<lemma:que|si>  [NOUNCOORD|PRO<type:D|P|I|X>] VERB<mode:[^PNG]>
# NEXT
# SubjL:  [VERB]  [CONJ<lemma:que|si>]  NOUNCOORD|PRO<type:D|P|I|X> VERB<mode:[^PNG]>
# NEXT
# DobjR: VERB   [CONJ<lemma:que|si>] [NOUNCOORD|PRO<type:D|P|I|X>] VERB<mode:[^PNG]>
(@temp) = ($listTags =~ /(?:$VERB$a)($CONJ${l}lemma:(?:que|si)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
$Rel =  "SpecL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB$a)(?:$CONJ${l}lemma:(?:que|si)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
$Rel =  "SubjL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a)(?:$CONJ${l}lemma:(?:que|si)\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
$Rel =  "DobjR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($CONJ${l}lemma:(?:que|si)\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

# SpecL: [VERB] [PRP] CONJ<lemma:que> VERB<mode:[^PNG]>
# NEXT
# CircR: VERB PRP [CONJ<lemma:que>] VERB<mode:[^PNG]>
(@temp) = ($listTags =~ /(?:$VERB$a)(?:$PRP$a)($CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
$Rel =  "SpecL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a)($PRP$a)(?:$CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/g);
$Rel =  "CircR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($PRP$a)($CONJ${l}lemma:que\|${r})($VERB${l}mode:[^PNG]\|${r})/$1/g;

# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc|Fpa|Fca VERB [Fc|Fpt|Fct]
# NEXT
# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] VERB Fc|Fpt|Fct
# NEXT
# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] VERB [Fc|Fpt|Fct]
(@temp) = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a|$Fpa$a|$Fca$a)($VERB$a)(?:$Fc$a|$Fpt$a|$Fct$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a|$Fpa$a|$Fca$a)($VERB$a)($Fc$a|$Fpt$a|$Fct$a)/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a|$Fpa$a|$Fca$a)($VERB$a)(?:$Fc$a|$Fpt$a|$Fct$a)/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a|$Fpa$a|$Fca$a)($VERB$a)($Fc$a|$Fpt$a|$Fct$a)/$1/g;

# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc|Fpa|Fca [PRP] NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
# NEXT
# PunctR: [NOUNCOORD|PRO<type:D|P|I|X>] [Fc|Fpa|Fca] [PRP] NOUNCOORD|PRO<type:D|P|I|X>|CARD Fc|Fpt|Fct
# NEXT
# CprepR: NOUNCOORD|PRO<type:D|P|I|X> [Fc|Fpa|Fca] PRP NOUNCOORD|PRO<type:D|P|I|X>|CARD [Fc|Fpt|Fct]
(@temp) = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a|$Fpa$a|$Fca$a)(?:$PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a)(?:$Fc$a|$Fpt$a|$Fct$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a|$Fpa$a|$Fca$a)(?:$PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a)($Fc$a|$Fpt$a|$Fct$a)/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a|$Fpa$a|$Fca$a)($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a)(?:$Fc$a|$Fpt$a|$Fct$a)/g);
$Rel =  "CprepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a|$Fpa$a|$Fca$a)($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$CARD$a)($Fc$a|$Fpt$a|$Fct$a)/$1/g;

# AdjnL: [Fc] VERB<mode:P> [Fc] VERB
# NEXT
# PunctL: Fc [VERB<mode:P>] [Fc] VERB
# NEXT
# PunctL: [Fc] [VERB<mode:P>] Fc VERB
(@temp) = ($listTags =~ /(?:$Fc$a)($VERB${l}mode:P\|${r})(?:$Fc$a)($VERB$a)/g);
$Rel =  "AdjnL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($Fc$a)(?:$VERB${l}mode:P\|${r})(?:$Fc$a)($VERB$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)(?:$VERB${l}mode:P\|${r})($Fc$a)($VERB$a)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($Fc$a)($VERB${l}mode:P\|${r})($Fc$a)($VERB$a)/$4/g;

# CoordL: NP [Fc] [NP] CONJ<(type:C)|(lemma:$CCord)> [NP]
# NEXT
# PunctL: [NP] Fc [NP] CONJ<(type:C)|(lemma:$CCord)> [NP]
# Recursivity: 10
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;
(@temp) = ($listTags =~ /($NP)(?:$Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NP)($Fc$a)(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NP)($Fc$a)($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$3$4$5/g;

# CoordL: [Fc]? NP CONJ<(type:C)|(lemma:$CCord)> [NP]
# NEXT
# CoordR: [Fc]? [NP] CONJ<(type:C)|(lemma:$CCord)> NP
# Add: coord:noun
(@temp) = ($listTags =~ /(?:$Fc$a)?($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$NP)/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?(?:$NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/g);
$Rel =  "CoordR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($Fc$a)?($NP)($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($NP)/$1$3/g;
Add("HeadDep","coord:noun",@temp);

# PunctL: Fc CONJ<coord:noun>
(@temp) = ($listTags =~ /($Fc$a)($CONJ${l}coord:noun\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($Fc$a)($CONJ${l}coord:noun\|${r})/$2/g;

# CoordL: VERB<nomin:no> [Fc] [VERB<nomin:no>] CONJ<(type:C)|(lemma:$CCord)> [VERB<nomin:no>]
# NEXT
# PunctL: [VERB<nomin:no>] Fc [VERB<nomin:no>] CONJ<(type:C)|(lemma:$CCord)> [VERB<nomin:no>]
# Recursivity: 5
(@temp) = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
(@temp) = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
(@temp) = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
(@temp) = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
(@temp) = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;
(@temp) = ($listTags =~ /($VERB${l}nomin:no\|${r})(?:$Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$VERB${l}nomin:no\|${r})($Fc$a)(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($VERB${l}nomin:no\|${r})($Fc$a)($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$3$4$5/g;

# CoordL: [Fc]? VERB<nomin:no> CONJ<(type:C)|(lemma:$CCord)> [VERB<nomin:no>]
# NEXT
# CoordR: [Fc]? [VERB<nomin:no>] CONJ<(type:C)|(lemma:$CCord)> VERB<nomin:no>
# Add: coord:verb
# Inherit: mode, tense
(@temp) = ($listTags =~ /(?:$Fc$a)?($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})(?:$VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$Fc$a)?(?:$VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/g);
$Rel =  "CoordR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($Fc$a)?($VERB${l}nomin:no\|${r})($CONJ${l}type:C\|${r}|$CONJ${l}lemma:$CCord\|${r})($VERB${l}nomin:no\|${r})/$1$3/g;
Inherit("HeadDep","mode,tense",@temp);
Add("HeadDep","coord:verb",@temp);

# PunctL: Fc CONJ<coord:verb>
(@temp) = ($listTags =~ /($Fc$a)($CONJ${l}coord:verb\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
$listTags =~ s/($Fc$a)($CONJ${l}coord:verb\|${r})/$2/g;

# SubjL: NOUN<type:P> VERB<mode:[^PG]>|CONJ<coord:verb&mode:[^PG]>
# Add: subj:yes
(@temp) = ($listTags =~ /($NOUN${l}type:P\|${r})($VERB${l}mode:[^PG]\|${r}|$CONJ${l}coord:verb\|${b}mode:[^PG]\|${r})/g);
$Rel =  "SubjL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NOUN${l}type:P\|${r})($VERB${l}mode:[^PG]\|${r}|$CONJ${l}coord:verb\|${b}mode:[^PG]\|${r})/$2/g;
Add("DepHead","subj:yes",@temp);

# SubjL: NOMINAL|PRO<type:D|P|I|X> VERB<mode:[^PG]>|CONJ<coord:verb&mode:[^PG]>
# Add: subj:yes
(@temp) = ($listTags =~ /($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PG]\|${r}|$CONJ${l}coord:verb\|${b}mode:[^PG]\|${r})/g);
$Rel =  "SubjL";
DepHead($Rel,"",@temp);
$listTags =~ s/($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})($VERB${l}mode:[^PG]\|${r}|$CONJ${l}coord:verb\|${b}mode:[^PG]\|${r})/$2/g;
Add("DepHead","subj:yes",@temp);

# DobjPrepR: VERB<lemma:$SubcatTr> PRP<lemma:a> NOMINAL|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatTr\|${r})($PRP${l}lemma:a\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "DobjPrepR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatTr\|${r})($PRP${l}lemma:a\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# AtrR: VERB<lemma:ser> NOMINAL|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /($VERB${l}lemma:ser\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "AtrR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:ser\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# DobjR: VERB NOMINAL|PRO<type:D|P|I|X>
(@temp) = ($listTags =~ /($VERB$a)($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/g);
$Rel =  "DobjR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})/$1/g;

# IobjR: VERB<lemma:($SubcatIND)|(SubcatBitr)>  [NOUNCOORD|PRO<type:D|P|I|X>]? PRP<lemma:a> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatIND\|${r}|$VERB${l}SubcatBitr\|${r})(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "IobjR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatIND\|${r}|$VERB${l}SubcatBitr\|${r})($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CregR: VERB<lemma:$SubcatA>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:a> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatA\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "CregR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatA\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:a\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CregR: VERB<lemma:$SubcatEN>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:en> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatEN\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:en\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "CregR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatEN\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:en\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CregR: VERB<lemma:$SubcatDE>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:de> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatDE\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:de\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "CregR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatDE\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:de\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CregR: VERB<lemma:$SubcatCON>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:con> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatCON\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:con\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "CregR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatCON\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:con\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CregR: VERB<lemma:$SubcatPOR>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:por> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatPOR\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:por\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "CregR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatPOR\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:por\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CregR: VERB<lemma:$SubcatHACIA>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:hacia> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatHACIA\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:hacia\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "CregR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatHACIA\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:hacia\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# CregR: VERB<lemma:$SubcatSOBRE>  [NOMINAL|PRO<type:D|P|I|X>]? PRP<lemma:sobre> NOMINAL|PRO<type:D|P|I|X>|VERB<mode:N>
(@temp) = ($listTags =~ /($VERB${l}lemma:$SubcatSOBRE\|${r})(?:$NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:sobre\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/g);
$Rel =  "CregR";
HeadRelDep($Rel,"",@temp);
$listTags =~ s/($VERB${l}lemma:$SubcatSOBRE\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r})?($PRP${l}lemma:sobre\|${r})($NOMINAL|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB${l}mode:N\|${r})/$1$2/g;

# PunctL: [NOUN|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>] VERB<subj:yes>|CONJ<subj:yes&coord:verb>    [Fc]?
# NEXT
# PunctR: [NOUN|PRO<type:D|P|I|X>] [Fc] [PRO<type:R|W>] VERB<subj:yes>|CONJ<subj:yes&coord:verb>   Fc
# NEXT
# DobjL: [NOUN|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W> VERB<subj:yes>|CONJ<subj:yes&coord:verb>    [Fc]?
# NEXT
# AdjnR: NOUN|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>] VERB<subj:yes>|CONJ<subj:yes&coord:verb>    [Fc]?
(@temp) = ($listTags =~ /(?:$NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)(?:$PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r}|$CONJ${l}subj:yes\|${b}coord:verb\|${r})(?:$Fc$a)?/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)(?:$PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r}|$CONJ${l}subj:yes\|${b}coord:verb\|${r})($Fc$a)/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?($PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r}|$CONJ${l}subj:yes\|${b}coord:verb\|${r})(?:$Fc$a)?/g);
$Rel =  "DobjL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?(?:$PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r}|$CONJ${l}subj:yes\|${b}coord:verb\|${r})(?:$Fc$a)?/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)?($PRO${l}type:(?:R|W)\|${r})($VERB${l}subj:yes\|${r}|$CONJ${l}subj:yes\|${b}coord:verb\|${r})($Fc$a)?/$1/g;

# PunctL: [NOUN|PRO<type:D|P|I|X>] Fc [PRO<type:R|W>] VERB|CONJ<coord:verb>   [Fc]?
# NEXT
# PunctR: [NOUN|PRO<type:D|P|I|X>] [Fc]? [PRO<type:R|W>] VERB|CONJ<coord:verb> Fc
# NEXT
# SubjL: [NOUN|PRO<type:D|P|I|X>] [Fc]? PRO<type:R|W> VERB|CONJ<coord:verb>   [Fc]?
# NEXT
# AdjnR: NOUN|PRO<type:D|P|I|X> [Fc]? [PRO<type:R|W>] VERB|CONJ<coord:verb>  [Fc]?
(@temp) = ($listTags =~ /(?:$NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})(?:$Fc$a)?/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})($Fc$a)/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?($PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})(?:$Fc$a)?/g);
$Rel =  "SubjL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})(?:$Fc$a)?/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)?($PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})($Fc$a)?/$1/g;

# PunctL: [NOUN|PRO<type:D|P|I|X>] Fc [PRP] [PRO<type:R|W>] VERB|CONJ<coord:verb>   [Fc]?
# NEXT
# PunctR: [NOUN|PRO<type:D|P|I|X>] [Fc]?  [PRP] [PRO<type:R|W>] VERB|CONJ<coord:verb> Fc
# NEXT
# CircL: [NOUN|PRO<type:D|P|I|X>] [Fc]? PRP PRO<type:R|W> VERB|CONJ<coord:verb>  [Fc]?
# NEXT
# AdjnR: NOUN|PRO<type:D|P|I|X> [Fc]? [PRP] [PRO<type:R|W>] VERB|CONJ<coord:verb>  [Fc]?
(@temp) = ($listTags =~ /(?:$NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)(?:$PRP$a)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})(?:$Fc$a)?/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?(?:$PRP$a)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})($Fc$a)/g);
$Rel =  "PunctR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /(?:$NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?($PRP$a)($PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})(?:$Fc$a)?/g);
$Rel =  "CircL";
RelDepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?(?:$PRP$a)(?:$PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})(?:$Fc$a)?/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($NOUN$a|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)?($PRP$a)($PRO${l}type:(?:R|W)\|${r})($VERB$a|$CONJ${l}coord:verb\|${r})($Fc$a)?/$1/g;

# PunctL: [NOUNCOORD|PRO<type:D|P|I|X>] Fc VERB<mode:[GP]>|CONJ<coord:verb>
# NEXT
# AdjnR: NOUNCOORD|PRO<type:D|P|I|X> [Fc]? VERB<mode:[GP]>|CONJ<coord:verb>
(@temp) = ($listTags =~ /(?:$NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "PunctL";
DepHead($Rel,"",@temp);
(@temp) = ($listTags =~ /($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})(?:$Fc$a)?($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r})($Fc$a)?($VERB${l}mode:[GP]\|${r}|$CONJ${l}coord:verb\|${r})/$1/g;

# AdjnR: VERB CONJ<type:S> [VERB]
# NEXT
# AdjnR: VERB [CONJ<type:S>] VERB
(@temp) = ($listTags =~ /($VERB$a)($CONJ${l}type:S\|${r})(?:$VERB$a)/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
(@temp) = ($listTags =~ /($VERB$a)(?:$CONJ${l}type:S\|${r})($VERB$a)/g);
$Rel =  "AdjnR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($VERB$a)($CONJ${l}type:S\|${r})($VERB$a)/$1/g;

# TermR: PRP NOUNCOORD|PRO<type:D|P|I|X>|VERB
# NoUniq
(@temp) = ($listTags =~ /($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB$a)/g);
$Rel =  "TermR";
HeadDep($Rel,"",@temp);
$listTags =~ s/($PRP$a)($NOUNCOORD|$PRO${l}type:(?:D|P|I|X)\|${r}|$VERB$a)/$1$2/g;

############################## END GRAMMAR  ###############################

if ($ListInit eq $listTags) {
       $STOP = 1;
   }
  }
    #print STDERR "Iterations: $iteration\n";

#########SAIDA CORRECTOR TAGGER

   if ($flag eq "-c") {

       for  ($i=0;$i<=$#Token;$i++) {
          print "$Token[$i]\t";
          $OrdTags{"tag"} = $Tag[$i]; 
          foreach $feat (keys %{$ATTR[$i]}) {
              $OrdTags{$feat} = $ATTR[$i]{$feat};
	  }
          foreach $feat (sort keys %OrdTags) {
                 print "$feat:$OrdTags{$feat}|";
                 delete $OrdTags{$feat};
          }
       print "\n";
       ##Colocar a zero os vectores de cada oraçao
       delete  $Token[$i];
       delete  $Tag[$i];
       delete  $Lemma[$i];
       delete  $Attributes[$i];
       delete  $ATTR[$i];
       }
       
    }
#########SAIDA STANDARD DO ANALISADOR 

    elsif ($flag eq "-a") {

      ##Escrever a oraçao que vai ser analisada:
      print "SENT::$seq\n";
      #print STDERR "LIST:: $listTags\n";
      ####imprimir Hash de dependencias ordenado:
      foreach $triplet (sort {$Ordenar{$a} <=>
                              $Ordenar{$b} }
                         keys %Ordenar ) {
         $triplet =~ s/^\(//;
         $triplet =~ s/\)$//;
         ($re, $he, $de) =  split (";", $triplet) ;
         if ($re !~ /($DepLex)/) {
           ($he ,$ta1, $pos1) = split ("_", $he);
            $he = $Lemma[$pos1];
            ($de ,$ta2, $pos2) = split ("_", $de);
            $de = $Lemma[$pos2];
            $triplet = "$re;$he\_$ta1\_$pos1;$de\_$ta2\_$pos2" ;
         }
         print "($triplet)\n";
       }
       ##final de analise de frase:
       print "---\n";
     }


  ###SAIDA ANALISADOR COM ESTRUTURA ATRIBUTO-VALOR (full analysis)
   elsif ($flag eq "-fa") {

      ##Escrever a oraçao que vai ser analisada:
      print "SENT::$seq\n";
      #print STDERR "LIST:: $listTags\n";
      ####imprimir Hash de dependencias ordenado:
      $re="";
      foreach $triplet (sort {$Ordenar{$a} <=>
                              $Ordenar{$b} }
                         keys %Ordenar ) {
           # print "$triplet\n";
         $triplet =~ s/^\(//;
         $triplet =~ s/\)$//;
         ($re, $he, $de) =  split (";", $triplet) ;

         if ($re !~ /($DepLex)/) { ##se rel nao e lexical
           ($he1, $ta1, $pos1) = split ("_", $he);
            $he1 = $Lemma[$pos1];
            ($de2 ,$ta2, $pos2) = split ("_", $de);
            $de2 = $Lemma[$pos2];
            $triplet = "$re;$he1\_$ta1\_$pos1;$de2\_$ta2\_$pos2" ;
         }
         print "($triplet)\n";
         ($he, ,$ta, $pos) = split ("_", $he);
         print "HEAD::$he\_$ta\_$pos<";
         $ATTR[$pos]{"lemma"} = $Lemma[$pos];
         $ATTR[$pos]{"token"} = $Token[$pos];
         foreach $feat (sort keys %{$ATTR[$pos]}) {
           print "$feat:$ATTR[$pos]{$feat}|" ;
         }
         print ">\n";
         ($de, $ta, $pos) = split ("_", $de);
         print "DEP::$de\_$ta\_$pos<";
         $ATTR[$pos]{"lemma"} = $Lemma[$pos];
         $ATTR[$pos]{"token"} = $Token[$pos];
         foreach $feat (sort keys %{$ATTR[$pos]}) {
           print "$feat:$ATTR[$pos]{$feat}|" ;
         }
         print ">\n";

         if ($re =~ /\//) {
          ($depName, $reUnit) = split ('\/', $re);
          ($reLex, ,$ta, $pos) = split ("_", $reUnit);
          print "REL::$reLex\_$ta\_$pos<";
          $ATTR[$pos]{"lemma"} = $Lemma[$pos];
          $ATTR[$pos]{"token"} = $Token[$pos];
          foreach $feat (sort keys %{$ATTR[$pos]}) {
           print "$feat:$ATTR[$pos]{$feat}|" ;
          }
         print ">\n";
        }
      }
       ##final de analise de frase:
       print "---\n";
     }



      
      ##Colocar numa lista vazia os strings com os tags (listTags) e a oraçao (seq)
      ##Borrar hash ordenado de triplets
      
      $i=0;
      $j=0;
      $listTags="";
      $seq="";
      foreach $t (keys %Ordenar) {
         delete  $Ordenar{$t};
      }
      for  ($i=0;$i<=$#Token;$i++) {
         delete  $Token[$i];
         delete  $Tag[$i];
         delete  $Lemma[$i];
         delete  $Attributes[$i];
         delete  $ATTR[$i];
       }
   
    

  } ##fim do elsif


 
}

#print "\n";
print STDERR "Fim do parsing...\n";





sub HeadDep {

    my ($y,$z, @x) = @_ ;
    my $n1=0;
    my $n2=0;
    my $found=0;
    my @z;

    (@z) = split (",", $z);

    for ($m=0;$m<=$#x;$m++) {
            $Head = $x[$m];
            $m++;
            $Dep = $x[$m];
           ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
           ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);


           if ($z eq "") {
              $Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
              $Rel =  $y ;
              $Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;

              $Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;

            }
            else {
             foreach $atr (@z) {
	
		if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && 
                      ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) && ##a modificar: so no caso de que atr = number or genre (N = invariable or neutral)
		     ($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "") ) {
                      
		       $found++;

                }
             }
	
	     # print STDERR "Found: $found\n";
              if ($found > 0) {
               	$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
                $listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
                $found=0;
             }
             else {

               $listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
               $listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
               $found=0;


               $Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
               $Rel =  $y ;
               $Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;

               $Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
            }
	   }

    }


}


sub DepHead {

    my ($y, $z, @x) = @_ ;
    my $n1=0;
    my $n2=0;
    my $found=0;
    my @z;

    (@z) = split (",", $z);

   # print STDERR "-$y-, -$z-, -@x-\n";

    for ($m=0;$m<=$#x;$m++) {
            $Dep = $x[$m];
            $m++;
            $Head = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

            if ($z eq "") {
              $Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
              $Rel =  $y ;
              $Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;

              $Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;

            }
            else {
	     
              foreach $atr (@z) {
	      
                 if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && 
                       ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) &&
		      ($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "") ) {
		       $found++ ;
                 }
	        
              }
	    
            #  print STDERR "Found: $found\n";
             if ($found > 0) {
               	$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
                $listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
                $found=0;

             }
             else  {

               $listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
               $listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
               $found=0;


               $Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
               $Rel =  $y ;
               $Dep =  "$Lemma[$n2]_$Tag[$n2]_${n2}" ;

               $Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
	     }
          }

    }


}


sub DepRelHead {

    my ($y, $z, @x) = @_ ;
    my $n1=0;
    my $n2=0;
    my $n3=0;
    my $found=0;
    my @z;

    (@z) = split (",", $z);

     for ($m=0;$m<=$#x;$m++) {
            $Dep = $x[$m];
            $m++;
            $Rel = $x[$m];
            $m++;
            $Head = $x[$m];
           ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
           ($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
           ($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

            if ($z eq "") {
               $Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
               $Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
               $Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

               $Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;

            }
            else {
             foreach $atr (@z) {
	
                if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
                       ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
		      ($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
		       $found++ ;
                }
		
             }
	
             if ($found > 0) {
               	$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
                $listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
                $found=0;
             }
             else {

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



sub HeadRelDep {

    my ($y, $z, @x) = @_ ;
    my $n1=0;
    my $n2=0;
    my $n3=0;
    my $found=0;
    my @z;

    (@z) = split (",", $z);

    for ($m=0;$m<=$#x;$m++) {
            $Head = $x[$m];
            $m++;
            $Rel = $y . "_" . $x[$m];
            $m++;
            $Dep = $x[$m];
           ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
           ($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
           ($n3) = ($Dep =~ /[\w]+_([0-9]+)/);


             if ($z eq "") {
               $Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
               $Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
               $Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

                $Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;

            }
            else {
             foreach $atr (@z) {
	
                 if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
                       ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) && 
		      ($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
		       $found++ ;
                }
	

             }
	
             if ($found > 0)  {
               	$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
                $listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
                $found=0;
             }
             else {

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





sub RelDepHead {

    my ($y, $z, @x) = @_ ;
    my $n1=0;
    my $n2=0;
    my $n3=0;
    my $found=0;
    my @z;

    (@z) = split (",", $z);

     for ($m=0;$m<=$#x;$m++) {
            $Rel = $x[$m];
            $m++;
            $Dep = $x[$m];
            $m++;
            $Head = $x[$m];
           ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
           ($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
           ($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

            if ($z eq "") {
               $Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
               $Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
               $Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

               $Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;

            }
            else {
             foreach $atr (@z) {
	
                if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
                       ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
		      ($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
		       $found++ ;
                }
		
             }
	
             if ($found > 0) {
               	$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
                $listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
                $found=0;
             }
             else {

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


sub RelHeadDep {

    my ($y, $z, @x) = @_ ;
    my $n1=0;
    my $n2=0;
    my $n3=0;
    my $found=0;
    my @z;

    (@z) = split (",", $z);

     for ($m=0;$m<=$#x;$m++) {
            $Rel = $x[$m];
            $m++;
            $Head = $x[$m];
            $m++;
            $Dep = $x[$m];
           ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
           ($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
           ($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

            if ($z eq "") {
               $Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
               $Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
               $Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

               $Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;

            }
            else {
             foreach $atr (@z) {
	
                if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
                       ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
		      ($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
		       $found++ ;
                }
		
             }
	
             if ($found > 0) {
               	$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
                $listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
                $found=0;
             }
             else {

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


sub DepHeadRel {

    my ($y, $z, @x) = @_ ;
    my $n1=0;
    my $n2=0;
    my $n3=0;
    my $found=0;
    my @z;

    (@z) = split (",", $z);

     for ($m=0;$m<=$#x;$m++) {
            $Dep = $x[$m];
            $m++;
            $Head = $x[$m];
            $m++;
            $Rel = $x[$m];
           ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
           ($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
           ($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

            if ($z eq "") {
               $Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
               $Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
               $Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

               $Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;

            }
            else {
             foreach $atr (@z) {
	
                if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
                       ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
		      ($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
		       $found++ ;
                }
		
             }
	
             if ($found > 0) {
               	$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
                $listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
                $found=0;
             }
             else {

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


sub HeadDepRel {

    my ($y, $z, @x) = @_ ;
    my $n1=0;
    my $n2=0;
    my $n3=0;
    my $found=0;
    my @z;

    (@z) = split (",", $z);

     for ($m=0;$m<=$#x;$m++) {
            $Head = $x[$m];
            $m++;
            $Rel = $x[$m];
            $m++;
            $Rel = $x[$m];
           ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
           ($n2) = ($Rel =~ /[\w]+_([0-9]+)/);
           ($n3) = ($Dep =~ /[\w]+_([0-9]+)/);

            if ($z eq "") {
               $Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
               $Rel =  "$y/$Lemma[$n2]_$Tag[$n2]_${n2}" ;
               $Dep =  "$Lemma[$n3]_$Tag[$n3]_${n3}" ;

               $Ordenar{"($Rel;$Head;$Dep)"} = $n3 ;

            }
            else {
             foreach $atr (@z) {
	
                if ( ($ATTR[$n1]{$atr} ne $ATTR[$n3]{$atr}) && 
                       ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n3]{$atr}  !~  /^[NC0]$/) &&
		      ($ATTR[$n1]{$atr} ne "" && $ATTR[$n3]{$atr} ne  "") ) {
		       $found++ ;
                }
		
             }
	
             if ($found > 0) {
               	$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
                $listTags =~ s/($Tag[$n3]_${n3}_<)/$1concord:0\|/;
                $found=0;
             }
             else {

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

    my ($y,$z, @x) = @_ ;
    my $n1=0;
    my $n2=0;
    my $found=0;
    my @z;


    (@z) = split (",", $z);

    for ($m=0;$m<=$#x;$m++) {
            $Head = $x[$m];
            $m++;
            $Dep = $x[$m];
           ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
           ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

           if ($z eq "") {
              #$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
              $Head = "$ATTR[$n1]{\"lemma\"}_$Tag[$n1]_${n1}" ;
              $Rel =  $y ;
              #$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
              $Dep =  "$ATTR[$n2]{\"lemma\"}_$Tag[$n2]_${n2}" ;

              $Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;
              #print STDERR "head::$Head -- dep:::$Dep\n";

	      if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
                  $ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} . "\@$Lemma[$n2]" ;
                 # $ATTR_token{$n1} = $ATTR[$n1]{"token"} .  "\@$Token[$n2]";

                  $IDF{$n1}++;

	      }

              elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
                  $ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} .  "\@$ATTR_lemma{$n2}" ;
                  #$ATTR_token{$n1} = $ATTR[$n1]{"token"} .   "\@$ATTR_token{$n2}";

                  $IDF{$n1}++;

	      }
              elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
                  $ATTR_lemma{$n1} .=   "\@$Lemma[$n2]" ;
                  #$ATTR_token{$n1} .=   "\@$Token[$n2]";


	      }
              else {

                     $ATTR_lemma{$n1} .=    "\@$ATTR_lemma{$n2}" ;
                   #  $ATTR_token{$n1} .=    "\@$ATTR_token{$n2}" ;

		
             }

            #print STDERR "$n1::: $ATTR_lemma{$n1} -- $ATTR_token{$n1} \n";

            }
            else {
             foreach $atr (@z) {
	
		if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && 
                       ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) &&
		      ($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "") ) {
		       $found++;

                }
             }
	
	     # print STDERR "Found: $found\n";
              if ($found > 0) {
               	$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
                $listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
                $found=0;
             }
             else {

               $listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
               $listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
               $found=0;

               #$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
               $Head = "$ATTR[$n1]{\"lemma\"}_$Tag[$n1]_${n1}" ;
               $Rel =  $y ;
               #$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
               $Dep =  "$ATTR[$n2]{\"lemma\"}_$Tag[$n2]_${n2}" ;

               $Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;


               if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
                  $ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} . "\@$Lemma[$n2]" ;
                 # $ATTR_token{$n1} = $ATTR[$n1]{"token"} .  "\@$Token[$n2]";

                  $IDF{$n1}++;

	       }

               elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
                  $ATTR_lemma{$n1} = $ATTR[$n1]{"lemma"} .  "\@$ATTR_lemma{$n2}" ;
                 # $ATTR_token{$n1} = $ATTR[$n1]{"token"} .   "\@$ATTR_token{$n2}";

                  $IDF{$n1}++;

	       }
               elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
                  $ATTR_lemma{$n1} .=   "\@$Lemma[$n2]" ;
                 # $ATTR_token{$n1} .=   "\@$Token[$n2]";


	       }
               else {

                     $ATTR_lemma{$n1} .=    "\@$ATTR_lemma{$n2}" ;
                  #   $ATTR_token{$n1} .=    "\@$ATTR_token{$n2}" ;

		
              }


            }

	   }
           $Lemma[$n1] = $ATTR_lemma{$n1} ;
          # $Token[$n1] = $ATTR_token{$n1} ;

    }



}


sub DepHead_lex {

 my ($y,$z, @x) = @_ ;
    my $n1=0;
    my $n2=0;
    my $found=0;
    my @z;


    (@z) = split (",", $z);

    for ($m=0;$m<=$#x;$m++) {
            $Dep = $x[$m];
            $m++;
            $Head = $x[$m];

           ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
           ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);

           if ($z eq "") {
              #$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
              $Head = "$ATTR[$n1]{\"lemma\"}_$Tag[$n1]_${n1}" ;
              $Rel =  $y ;
              #$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
              $Dep =  "$ATTR[$n2]{\"lemma\"}_$Tag[$n2]_${n2}" ;

              $Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;

              #print STDERR "OKKKK: #$Dep - $n2#\n";
               if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
                  $ATTR_lemma{$n1} = $ATTR[$n2]{"lemma"} . "\@$Lemma[$n1]" ;
           #       $ATTR_token{$n1} = $ATTR[$n2]{"token"} .  "\@$Token[$n1]";

                  $IDF{$n1}++;

	       }

               elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
                  $ATTR_lemma{$n1} =   "$ATTR_lemma{$n2}\@"  . $ATTR[$n1]{"lemma"}  ;
            #      $ATTR_token{$n1} =   "$ATTR_token{$n2}\@" .  $ATTR[$n1]{"token"};

                  $IDF{$n1}++;

	       }
               elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
                  $ATTR_lemma{$n1} .=   "$Lemma[$n2]\@" ;
             #     $ATTR_token{$n1} .=   "$Token[$n2]\@" ;

	       }
               else {
                     $ATTR_lemma{$n1} .=    "$ATTR_lemma{$n1}\@" ;
              #       $ATTR_token{$n1} .=    "$ATTR_token{$n1}\@" ;

              }

	
            }
            else {
             foreach $atr (@z) {
	
		if ( ($ATTR[$n1]{$atr} ne $ATTR[$n2]{$atr}) && 
                        ($ATTR[$n1]{$atr} !~  /^[NC0]$/ && $ATTR[$n2]{$atr}  !~  /^[NC0]$/) &&
                       ($ATTR[$n1]{$atr} ne "" && $ATTR[$n2]{$atr} ne  "")  ) {
		       $found++;

                }
             }
	
	     # print STDERR "Found: $found\n";
              if ($found > 0) {
               	$listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:0\|/;
                $listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:0\|/;
                $found=0;
             }
             else {

               $listTags =~ s/($Tag[$n1]_${n1}_<)/$1concord:1\|/;
               $listTags =~ s/($Tag[$n2]_${n2}_<)/$1concord:1\|/;
               $found=0;

               #$Head = "$Lemma[$n1]_$Tag[$n1]_${n1}" ;
               $Head = "$ATTR[$n1]{\"lemma\"}_$Tag[$n1]_${n1}" ;
               $Rel =  $y ;
               #$Dep = "$Lemma[$n2]_$Tag[$n2]_${n2}" ;
               $Dep =  "$ATTR[$n2]{\"lemma\"}_$Tag[$n2]_${n2}" ;

               $Ordenar{"($Rel;$Head;$Dep)"} = $n2 ;

               if (!defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
                  $ATTR_lemma{$n1} = $ATTR[$n2]{"lemma"} . "\@$Lemma[$n1]" ;
               #   $ATTR_token{$n1} = $ATTR[$n2]{"token"} .  "\@$Token[$n1]";

                  $IDF{$n1}++;

	       }

                elsif (!defined $ATTR_lemma{$n1} && defined $ATTR_lemma{$n2} ) {
                  $ATTR_lemma{$n1} =   "$ATTR_lemma{$n2}\@"  . $ATTR[$n1]{"lemma"}  ;
                #  $ATTR_token{$n1} =   "$ATTR_token{$n2}\@" .  $ATTR[$n1]{"token"};

                  $IDF{$n1}++;

	       }
               elsif (defined $ATTR_lemma{$n1} && !defined $ATTR_lemma{$n2} ) {
                  $ATTR_lemma{$n1} .=   "$Lemma[$n2]\@" ;
                 # $ATTR_token{$n1} .=   "$Token[$n2]\@" ;

	       }
               else {
                     $ATTR_lemma{$n1} .=    "$ATTR_lemma{$n1}\@" ;
                  #   $ATTR_token{$n1} .=    "$ATTR_token{$n1}\@" ;

              }

            }
	   }
           $Lemma[$n1] = $ATTR_lemma{$n1} ;
          # $Token[$n1] = $ATTR_token{$n1} ;

    }

}



sub Head {

    my ($y, $z, @x) = @_ ;

   return 1

}




sub LEX {
    my $idf=0 ;
    foreach $idf (keys %IDF) {
       #print STDERR "idf = $idf";

       ##parche para \2... \pi...:
      # $ATTR[$idf]{"lemma"}  =~ s/[\\]/\\\\/g ;
      # $ATTR[$idf]{"token"}  =~ s/[\\]/\\\\/g ;
       
       $listTags =~ s/($Tag[$idf]_${idf}${l})lemma:$ATTR[$idf]{"lemma"}/${1}lemma:$ATTR_lemma{$idf}/;
      # $listTags =~ s/($Tag[$idf]_${idf}${l})token:$ATTR[$idf]{"token"}/${1}token:$ATTR_token{$idf}/;

       delete $IDF{$idf};
       delete $ATTR_lemma{$idf};
       #delete $ATTR_token{$idf};


    }


}


##Operaçoes Corr, Inherit, Add, 

sub Corr {

    my ($z, $y, @x) = @_ ;
    my $n1=0;
    my $n2=0;
    my @y="";
    my $atr="";
    my $value="";
    my $info="";
    my $attribute="";
    my $entry="";

    (@y) = split (",", $y);


    if ($z eq "Head") {
      for ($m=0;$m<=$#x;$m++) {
            $Head = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
		
            foreach $info (@y) {
	       ($atr, $value) = split (":", $info) ;
            
               ##token:=lemma / lemma:=token
               if ($value =~ /^=/) {
		   $value =~ s/^=//;
                  $ATTR[$n1]{$atr} = $ATTR[$n1]{$value} ;
		   if ($value eq "token") {
                     $Lemma[$n1] = $ATTR[$n1]{$value} ;
		   }
                   elsif ($value eq "lemma") {
                     $Token[$n1] = $ATTR[$n1]{$value} ;
		   }
               } 
              

               ##change the PoS tag:
               elsif ($atr =~ /^tag/) {
                  $ATTR[$n1]{$atr} = $value;
                  $entry = "${value}_${n1}_<";

                  if (activarTags($value,$n1)) {
                    
                   foreach $attribute (sort keys %{$ATTR[$n1]}) {
		        # print STDERR "--atribs: $attribute\n";      
		      if (defined $TagStr{$attribute}) {
                        $entry .= "$attribute:$ATTR[$n1]{$attribute}|" ;
                        #print STDERR "atribute defined : $attribute --$entry\n";
		      }
                      else {
			#$entry .= "$attribute:$TagStr{$attribute}|" ;
			  delete $ATTR[$n1]{$attribute} ;
                          #print STDERR "++entry : $entry\n";
		      } 
                     
                    }

                    foreach $attribute (sort keys %TagStr) {
		        # print STDERR "++atribs: $attribute\n";      
		      if (!defined $ATTR[$n1]{$attribute}) {
                        $entry .= "$attribute:$ATTR[$n1]{$attribute}|" ;
			$ATTR[$n1]{$attribute} = $TagStr{$attribute};
                        #print STDERR "++atribute defined : $attribute --$entry\n";
		      }
                      
                     
                    }
		  }

	          $entry .= ">";
                  #print STDERR  "--$entry\n" ;
                  $listTags =~ s/$Tag[$n1]_$n1$a/$entry/;
                  $Tag[$n1] = $value;
                  desactivarTags($value);
               }

	       elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr/) {
                  $ATTR[$n1]{$atr} = $value;
                  if ($atr eq "lemma") {
                    $Lemma[$n1] = $ATTR[$n1]{"lemma"};
		  }
                  if ($atr eq "token") {
                    $Token[$n1] = $ATTR[$n1]{"token"};
		  }
                  $listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
                
	       }
               else {
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

    my ($z, $y, @x) = @_ ;
    my $n1=0;
    my $n2=0;
    my @y="";


    (@y) = split (",", $y);


    if ($z eq "DepHead") {
      for ($m=0;$m<=$#x;$m++) {
            $Dep = $x[$m];
            $m++;
            $Head = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  
		
             foreach $atr (@y) {
		 if (!$ATTR[$n1]{$atr}) {
                    $listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
                 }
                 else {
                  $listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
		 }
                 $ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
	     }

      }
   }

   elsif ($z eq "HeadDep") {
      for ($m=0;$m<=$#x;$m++) {
            $Head = $x[$m];
            $m++;
            $Dep = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  
		
             foreach $atr (@y) {
                  if (!$ATTR[$n1]{$atr}) {
                    $listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
                 }
                 else {
                  $listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
		 }
                 $ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};

	     }

      }
   }

   elsif ($z eq "DepRelHead") {
      for ($m=0;$m<=$#x;$m++) {
            $Dep = $x[$m];
            $m +=2;
            $Head = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
		
             foreach $atr (@y) {
                 if (!$ATTR[$n1]{$atr}) {
                    $listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
                 }
                 else {
                  $listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
		 }
                 $ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};

	     }

      }
   }

    elsif ($z eq "HeadRelDep") {
      for ($m=0;$m<=$#x;$m++) {
            $Head = $x[$m];
            $m +=2;
            $Dep = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
		
             foreach $atr (@y) {
                 if (!$ATTR[$n1]{$atr}) {
                    $listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
                 }
                 else {
                  $listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
		 }
                 $ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};

	     }

      }
   }

   elsif ($z eq "RelDepHead") {
      for ($m=0;$m<=$#x;$m++) {
	    $m++;
            $Dep = $x[$m];
            $m++;
            $Head = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
		
             foreach $atr (@y) {
                if (!$ATTR[$n1]{$atr}) {
                    $listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
                 }
                 else {
                  $listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
		 }
                 $ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};
                 
	     }

      }
   }

   elsif ($z eq "RelHeadDep") {
      for ($m=0;$m<=$#x;$m++) {
	    $m++;
            $Head = $x[$m];
            $m++;
            $Dep = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
		
             foreach $atr (@y) {
                 if (!$ATTR[$n1]{$atr}) {
                    $listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
                 }
                 else {
                  $listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
		 }
                 $ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};

	     }

      }
   }


   elsif ($z eq "DepHeadRel") {
      for ($m=0;$m<=$#x;$m++) {
            $Dep = $x[$m];
            $m++;
            $Head = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
		
             foreach $atr (@y) {
                if (!$ATTR[$n1]{$atr}) {
                    $listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
                 }
                 else {
                  $listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
		 }
                 $ATTR[$n1]{$atr} = $ATTR[$n2]{$atr};               
	     }

      }
   }

   elsif ($z eq "HeadDepRel") {
      for ($m=0;$m<=$#x;$m++) {
            $Head = $x[$m];
            $m++;
            $Dep = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
		
             foreach $atr (@y) {
                 if (!$ATTR[$n1]{$atr}) {
                    $listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
                 }
                 else {
                  $listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
		 }
                 $ATTR[$n1]{$atr} = $ATTR[$n2]{$atr}; 
                 
	     }

      }
   }

   elsif ($z eq "DepHead_lex") {
      for ($m=0;$m<=$#x;$m++) {
            $Dep = $x[$m];
            $m++;
            $Head = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  
		
             foreach $atr (@y) {
                 if (!$ATTR[$n1]{$atr}) {
                    $listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
                 }
                 else {
                  $listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
		 }
                 $ATTR[$n1]{$atr} = $ATTR[$n2]{$atr}; 
                 
	     }

      }
   }

   elsif ($z eq "HeadDep_lex") {
      for ($m=0;$m<=$#x;$m++) {
            $Head = $x[$m];
            $m++;
            $Dep = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  
		
             foreach $atr (@y) {
                 if (!$ATTR[$n1]{$atr}) {
                    $listTags =~ s/($Tag[$n1]_${n1}${l})/${1}$atr:$ATTR[$n2]{$atr}\|/;
                 }
                 else {
                  $listTags =~ s/($Tag[$n1]_${n1}${l})$atr:$ATTR[$n1]{$atr}/${1}$atr:$ATTR[$n2]{$atr}/;
		 }
                 $ATTR[$n1]{$atr} = $ATTR[$n2]{$atr}; 

	     }

      }
   }
}


sub Add {

    my ($z, $y, @x) = @_ ;
    my $n1=0;
    my $n2=0;
    my @y="";
    my $atr="";
    my $value="";
    my $info="";

    (@y) = split (",", $y);


 
  
  if ($z eq "Head") {
      for ($m=0;$m<=$#x;$m++) {
            $Head = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            

            foreach $info (@y) {
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
               }
               else {
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

   elsif ($z eq "DepHead") {
      for ($m=0;$m<=$#x;$m++) {
            $Dep = $x[$m];
            $m++;
            $Head = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  
		
            foreach $info (@y) {
	       ($atr, $value) = split (":", $info) ;

               ##change the PoS tag:
               if ($atr =~ /^tag/) {
                  $ATTR[$n1]{$atr} = $value;
                  $listTags =~ s/$Tag[$n1]/$value/;
                   $Tag[$n1] = $value;
               }
	       elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
                  $ATTR[$n1]{$atr} = $value;
                  if ($atr eq "lemma") {
                    $Lemma[$n1] = $ATTR[$n1]{"lemma"};
		  }
                  if ($atr eq "token") {
                    $Token[$n1] = $ATTR[$n1]{"token"};
		  }
                  $listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
                 # print STDERR "$atr - $value : #$l# - #$r#";
	       }
               else {
                 $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
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

   elsif ($z eq "HeadDep") {
      for ($m=0;$m<=$#x;$m++) {
            $Head = $x[$m];
            $m++;
            $Dep = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  
	
            foreach $info (@y) {
	       ($atr, $value) = split (":", $info) ;
               
                ##change the PoS tag:
                if ($atr =~ /^tag/) {
                  $ATTR[$n1]{$atr} = $value;
                  $listTags =~ s/$Tag[$n1]/$value/;
                  $Tag[$n1] = $value;
               }
               elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
                  $ATTR[$n1]{$atr} = $value;
                  if ($atr eq "lemma") {
                    $Lemma[$n1] = $ATTR[$n1]{"lemma"};
		  }
                  if ($atr eq "token") {
                    $Token[$n1] = $ATTR[$n1]{"token"};
		  }
                  $listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
	       }
               else {
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

   elsif ($z eq "DepRelHead") {
      for ($m=0;$m<=$#x;$m++) {
            $Dep = $x[$m];
            $m+=2;
            $Head = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
		
            foreach $info (@y) {
	       ($atr, $value) = split (":", $info) ;
	       
                ##change the PoS tag:
                if ($atr =~ /^tag/) {
                  $ATTR[$n1]{$atr} = $value;
                  $listTags =~ s/$Tag[$n1]/$value/;
                   $Tag[$n1] = $value;
               }
               elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
                  $ATTR[$n1]{$atr} = $value;
                  if ($atr eq "lemma") {
                    $Lemma[$n1] = $ATTR[$n1]{"lemma"};
		  }
                  if ($atr eq "token") {
                    $Token[$n1] = $ATTR[$n1]{"token"};
		  }
                  $listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
	       }
               else {
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

    
    elsif ($z eq "HeadRelDep") {
      for ($m=0;$m<=$#x;$m++) {
            $Head = $x[$m];
            $m +=2;
            $Dep = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
	
            foreach $info (@y) {
	       ($atr, $value) = split (":", $info) ;
	       
                ##change the PoS tag:
               if ($atr =~ /^tag/) {
                  $ATTR[$n1]{$atr} = $value;
                  $listTags =~ s/$Tag[$n1]/$value/;
                  $Tag[$n1] = $value;
               }
               elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
                  $ATTR[$n1]{$atr} = $value;
                  if ($atr eq "lemma") {
                    $Lemma[$n1] = $ATTR[$n1]{"lemma"};
		  }
                  if ($atr eq "token") {
                    $Token[$n1] = $ATTR[$n1]{"token"};
		  }
                  $listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
	       }
               else {
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


   elsif ($z eq "RelDepHead") {
      for ($m=0;$m<=$#x;$m++) {
            $m++;
            $Dep = $x[$m];
            $m++;
            $Head = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
		
            foreach $info (@y) {
	       ($atr, $value) = split (":", $info) ;
	       
                ##change the PoS tag:
               if ($atr =~ /^tag/) {
                  $ATTR[$n1]{$atr} = $value;
                  $listTags =~ s/$Tag[$n1]/$value/;
                  $Tag[$n1] = $value;
               }
               elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
                  $ATTR[$n1]{$atr} = $value;
                  if ($atr eq "lemma") {
                    $Lemma[$n1] = $ATTR[$n1]{"lemma"};
		  }
                  if ($atr eq "token") {
                    $Token[$n1] = $ATTR[$n1]{"token"};
		  }
                  $listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
	       }
               else {
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


   elsif ($z eq "RelHeadDep") {
      for ($m=0;$m<=$#x;$m++) {
            $m++;
            $Head = $x[$m];
            $m++;
            $Dep = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
		
            foreach $info (@y) {
	       ($atr, $value) = split (":", $info) ;
	       
                ##change the PoS tag:
                if ($atr =~ /^tag/) {
                  $ATTR[$n1]{$atr} = $value;
                  $listTags =~ s/$Tag[$n1]/$value/;
                  $Tag[$n1] = $value;
               }
               elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
                  $ATTR[$n1]{$atr} = $value;
                  if ($atr eq "lemma") {
                    $Lemma[$n1] = $ATTR[$n1]{"lemma"};
		  }
                  if ($atr eq "token") {
                    $Token[$n1] = $ATTR[$n1]{"token"};
		  }
                  $listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
	       }
               else {
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


   elsif ($z eq "DepHeadRel") {
      for ($m=0;$m<=$#x;$m++) {
            $Dep = $x[$m];
            $m++;
            $Head = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
		
            foreach $info (@y) {
	       ($atr, $value) = split (":", $info) ;
	       
                ##change the PoS tag:
               if ($atr =~ /^tag/) {
                  $ATTR[$n1]{$atr} = $value;
                  $listTags =~ s/$Tag[$n1]/$value/;
                  $Tag[$n1] = $value;
               }
	       elsif ($listTags  =~ /($Tag[$n1]_${n1}${l})$atr:/) {
                  $ATTR[$n1]{$atr} = $value;
                  if ($atr eq "lemma") {
                    $Lemma[$n1] = $ATTR[$n1]{"lemma"};
		  }
                  if ($atr eq "token") {
                    $Token[$n1] = $ATTR[$n1]{"token"};
		  }
                  $listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
	       }
               else {
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


   elsif ($z eq "HeadDepRel") {
      for ($m=0;$m<=$#x;$m++) {
            $Head = $x[$m];
            $m++;
            $Dep = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);
		
            foreach $info (@y) {
	       ($atr, $value) = split (":", $info) ;
	       
                 ##change the PoS tag:
               if ($atr =~ /^tag/) {
                  $ATTR[$n1]{$atr} = $value;
                  $listTags =~ s/$Tag[$n1]/$value/;
                  $Tag[$n1] = $value;
               }
               elsif ($listTags =~ /($Tag[$n1]_${n1}${l})$atr:/) {
                  $ATTR[$n1]{$atr} = $value;
                  if ($atr eq "lemma") {
                    $Lemma[$n1] = $ATTR[$n1]{"lemma"};
		  }
                  if ($atr eq "token") {
                    $Token[$n1] = $ATTR[$n1]{"token"};
		  }
                  $listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
	       }
               else {
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



   elsif ($z eq "DepHead_lex") {
      for ($m=0;$m<=$#x;$m++) {
            $Dep = $x[$m];
            $m++;
            $Head = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  
		
            foreach $info (@y) {
	       ($atr, $value) = split (":", $info) ;
              
                ##change the PoS tag:
               if ($atr =~ /^tag/) {
                  $ATTR[$n1]{$atr} = $value;
                  $listTags =~ s/$Tag[$n1]/$value/;
                  $Tag[$n1] = $value;
               }
	       elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
                  $ATTR[$n1]{$atr} = $value;
                  if ($atr eq "lemma") {
                    $Lemma[$n1] = $ATTR[$n1]{"lemma"};
		  }
                  if ($atr eq "token") {
                    $Token[$n1] = $ATTR[$n1]{"token"};
		  }
                  $listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}$info\|/;
	       }
               else {
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

   if ($z eq "HeadDep_lex") {
      for ($m=0;$m<=$#x;$m++) {
            $Head = $x[$m];
            $m++;
            $Dep = $x[$m];
            ($n1) = ($Head =~ /[\w]+_([0-9]+)/) ;
            ($n2) = ($Dep =~ /[\w]+_([0-9]+)/);  
		
            foreach $info (@y) {
	       ($atr, $value) = split (":", $info) ;
	       
                ##change the PoS tag:
               if ($atr =~ /^tag/) {
                  $ATTR[$n1]{$atr} = $value;
                  $listTags =~ s/$Tag[$n1]/$value/;
                  $Tag[$n1] = $value;
               }
               elsif ($listTags =~ /$Tag[$n1]_${n1}${l}$atr:/) {
                  $ATTR[$n1]{$atr} = $value;
                  if ($atr eq "lemma") {
                    $Lemma[$n1] = $ATTR[$n1]{"lemma"};
		  }
                  if ($atr eq "token") {
                    $Token[$n1] = $ATTR[$n1]{"token"};
		  }
                  $listTags =~ s/($Tag[$n1]_${n1}${l})${atr}:[^|]*\|/${1}${info}\|/;
	       }
               else {

                 $listTags =~ s/($Tag[$n1]_${n1}_<)/${1}$info\|/;
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

    my ($x) = @_ ;
    my $expr="";
    my $ref="";
    my $CAT="";
  
    ($CAT, $ref) = split ("_", $x);  
    $expr = "(?<!${CAT})\\_$ref";
  

   return $expr
}

sub negR {

    my ($x) = @_ ;
    my $expr="";
    my $ref="";
    my $CAT="";
 
    ($CAT, $ref) = split ("_", $x); 
    $expr = "?!${CAT}\\_$ref";
 
   return $expr
}



sub activarTags {

   my ($x, $pos) = @_ ; 

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
      return 1 ;
   }

     ##conjunctions:
    elsif ($x =~ /^C/) {
      
       $TagStr{"type"} =  0;
       $TagStr{"pos"} = $pos;
        return 1 ;
    }

    ##interjections:
    elsif ($x =~ /^I/) {
   
       $TagStr{"type"} = 0;
       $TagStr{"pos"} = $pos;
       return 1 ;
    }

   ##numbers
   elsif ($x =~  /^CARD/) {
       
       $TagStr{"number"} = "P";
       $TagStr{"person"} = 0;
       $TagStr{"gender"} = 0;
       $TagStr{"pos"} = $pos;
       return 1 ;
   }


    elsif ($x =~ /^ADJ/) {
       
       $TagStr{"type"} = 0;
       $TagStr{"degree"} = 0;
       $TagStr{"gender"} = 0;
       $TagStr{"number"} = 0;
       $TagStr{"function"} = 0;
       $TagStr{"pos"} = $pos;
       return 1 ;
   }


   elsif ($x =~ /^ADV/) {
       
       $TagStr{"type"} = 0;
       $TagStr{"pos"} = $pos;
       return 1 ;
   }


   elsif ($x =~ /^PRP/) {
       
       $TagStr{"type"} = 0;
       $TagStr{"pos"} = $pos;
       return 1 ;
   }


   elsif ($x =~ /^NOUN/) {
      
       $TagStr{"type"} = 0 ;
       $TagStr{"gender"} = 0;
       $TagStr{"number"} = 0;
       $TagStr{"person"} = 0;
       $TagStr{"pos"} = $pos;
       return 1 ;
   }

   elsif ($x =~ /^DT/) {
 
       $TagStr{"type"} = 0;
       $TagStr{"person"} = 0;
       $TagStr{"gender"} = 0;
       $TagStr{"number"} = 0;
       $TagStr{"possessor"} = 0;
       $TagStr{"pos"} = $pos;
       return 1 ;
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
       return 1 ;  
   }
   else {
     return 0
   }

}


sub desactivarTags {

   my ($x) = @_ ; 

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
     return 1
}


sub ConvertChar {

    my ($x, $y) = @_ ;


    $info =~ s/lemma:$x/lemma:\*$y\*/g; 
    $info =~ s/token:$x/token:\*$y\*/g;

}

sub ReConvertChar {

    my ($x, $y, $z) = @_ ;

     $Attributes[$z] =~ s/lemma:\*$y\*/lemma:$x/g;
     $Attributes[$z] =~ s/token:\*$y\*/token:$x/g;
     $ATTR[$z]{"lemma"} =~ s/\*$y\*/$x/g;
     $ATTR[$z]{"token"} =~ s/\*$y\*/$x/g;
     $Token[$z] =~ s/\*$y\*/$x/g;
     $Lemma[$z] =~ s/\*$y\*/$x/g;

}
