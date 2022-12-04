import 'dart:math';

import 'package:flutter/material.dart';

class Partida{
  int dificultad = 0;
  int jugador = 0;
  List<int> casillas = [0];
  final List<List<int>> combinaciones = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ];

  Partida(this.dificultad){
    jugador = 1;
    casillas = [0,0,0,0,0,0,0,0,0];
  }

  comprueba_casilla(int casilla){
    if(casillas[casilla] != 0){
      return false;
    } else {
      casillas[casilla] = jugador;
      return true;
    }
  }

  turno(){
    bool empate = true;
    bool ultimo_movimiento = true;

    for(int i = 0; i < combinaciones.length; i++){
      for(int pos in combinaciones[i]){
        if(casillas[pos] != jugador){
          ultimo_movimiento = false;
        }
        if(casillas[pos] == 0){
          empate = false;
        }
      }
      if(ultimo_movimiento){
        return jugador;
      }
      ultimo_movimiento = true;
    }
    if(empate){
      return 3;
    }
    jugador++;

    if(jugador > 2){
      jugador = 1;
    }

    return 0;
  }

  int dosEnRaya(int jugador_en_turno){
    int casilla = -1;
    int cuantas_lleva = 0;

    for(int i = 0; i < combinaciones.length; i++){
      for(int pos in combinaciones[i]){
        if(casillas[pos] == jugador_en_turno){
          cuantas_lleva++;
        }

        if(casillas[pos] == 0){
          casilla = pos;
        }
      }
      if(cuantas_lleva == 2 && casilla != -1){
        return casilla;
      }
      cuantas_lleva = 0;
      casilla = -1;
    }
    return -1;
  }

  int ia(){
    int casilla = dosEnRaya(2);

    if(casilla != -1){
      return casilla;
    }

    if(dificultad > 0){
      casilla = dosEnRaya(1);
      if(casilla != -1){
        return casilla;
      }
    }

    if(dificultad == 2){
      if(casillas[0] == 0) return 0;
      if(casillas[2] == 0) return 2;
      if(casillas[6] == 0) return 6;
      if(casillas[8] == 0) return 8;
    }

    //generar un numero al azar entre 0 y 8
    casilla = (Random()).nextInt(9);

    return casilla;
  }
}