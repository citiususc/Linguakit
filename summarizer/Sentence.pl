package Sentence;
use strict;



######################################################################
  #Constructor de la clase
  #
 sub new {
    my $this=shift; #Cogemos la clase que somos o una referencia a la clase (si soy un objeto)
    my $class = ref($this) || $this; #Averiguo la clase a la que pertenezco
    my $self={}; #Inicializamos a taboa hash que conterá as variables de instancia (PESO E VALOR)
    $self ->{PESO} = 0 ; #A clase Sentence nace con peso 0
    $self ->{KEYWORDS}   = 0 ;     #A clase nace con 0 keywords
    $self ->{MULTIWORDS}   = 0 ;     #A clase nace con 0 multiwords
    $self ->{VALOR}   = "" ;     #A clase nace cun valor en blanco
    $self ->{NUM_WORDS} = 0; #A clase nace con 0 palabras
    $self ->{NUM_KEYWORDS} = 0; #A clase nace con 0 palabras
    $self ->{NUM_MULTIWORDS} = 0; #A clase nace con 0 palabras

    bless $self, $class; #Perl ten que dar o visto bo a clase
    return ($self); #Devolvemos a clase recen construida
}

######################################################################
  #Métodos de acceso a los datos de la clase
  #

  #metodo para ver/cambiar o valor
  sub valor{
       my $self=shift; 

       if(@_){
          my $valor = shift;
          if($valor eq "."){
            chop($self->{VALOR});
            $self->{VALOR}= $self->{VALOR} .  $valor ;
          }elsif($valor eq ","){
            chop($self->{VALOR});
            $self->{VALOR}= $self->{VALOR} .  $valor ." ";
          }else{
            $self->{VALOR}= $self->{VALOR} .  $valor ." ";
          }
          
          $self->{NUM_WORDS}=$self->{NUM_WORDS}+1;
       }
       

       #Devolvemos el nombre
       return $self->{VALOR};
  }

  #metodo para ver/cambiar o peso
  sub peso{
       my $self=shift;
 
       $self->{PESO}=shift if (@_);

       #Devolvemos el peso
       #return ($self->{KEYWORDS} + $self->{MULTIWORDS}) / $self->{NUM_WORDS};#$self->{PESO}; $self->{NUM_WORDS} + $self->{MULTIWORDS};#
      if($self->{NUM_KEYWORDS}>0){
          my $density_kw = $self->{NUM_KEYWORDS}/$self->{NUM_WORDS};
          return $self->{KEYWORDS} * $density_kw;
      }else{
          return 0;#$self->{KEYWORDS}/ $self->{NUM_WORDS};   
      }

      #$self->{PESO}; $self->{NUM_WORDS} + $self->{MULTIWORDS};#
  }

  #metodo para ver/cambiar o numero keywords
  sub keywords{
       my $self=shift;

       if(@_){
          my $valor = shift;
          $self->{KEYWORDS}=$self->{KEYWORDS}+$valor ;
          if($valor>0){
            $self->{NUM_KEYWORDS}=$self->{NUM_KEYWORDS}+1;
          }
       }  

       #Devolvemos el nombre
       return $self->{KEYWORDS};
  }

  #metodo para ver/cambiar o numero multiwords
  sub multiwords{
       my $self=shift;
 
       if(@_){
          my $valor = shift;
          $self->{MULTIWORDS}=$self->{MULTIWORDS}+ $valor;
          if($valor>0){
            $self->{NUM_MULTIWORDS}=$self->{NUM_MULTIWORDS}+1;
          }
       }

       #Devolvemos el nombre
       return $self->{MULTIWORDS};
  }

  #metodo para ver/cambiar o numero palabras
  sub num_words{
       my $self=shift;
 
       $self->{NUM_WORDS}=shift if (@_);

       #Devolvemos el nombre
       return $self->{NUM_WORDS};
  }

  ######################################################################
  #Destructor
  #

  sub DESTROY {
        my $self=shift; #El primer parámetro de un metodo es la  clase
        delete ($self->{VALOR});  
        delete ($self->{PESO});  
        delete ($self->{KEYWORDS});  
        delete ($self->{MULTIWORDS});
        delete ($self->{NUM_WORDS});
  }

  #Fin
  1;

