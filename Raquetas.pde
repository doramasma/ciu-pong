class Raqueta {
  
  int jx,jy,grosor,altura;
  
  Raqueta(int jx,int jy,int grosor,int altura) {
     this.jx = jx;
     this.jy = jy;
     this.grosor = grosor;
     this.altura = altura;
  }
   // No se salga de la pantalla la barrita del jugador
  void drawRaqueta () {
    if (jy + 40   > height) {
      rect(jx,height - altura,grosor,altura);

    }else if (jy < 0) {
      rect(jx,0,grosor,altura);

   } else {
     rect(jx,jy,grosor,altura);
   }
  
  }
  
  void jyUp(){
    if (jy - 5 > 0) {
      this.jy = this.jy - 5;
    }
    
  }
  
  void jyDown(){
    if (jy + 5 < 400) {
      this.jy = this.jy + 5;
    }
     
  }
  
  void setJy(int number) {
      this.jy = number;
  }
   
}
