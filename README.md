PROLOG:

querys validas:

flight(Place1, Place2, Day, Flight_num, Dep_time, Arr_time).

inderect_flight(Place1, Place2, Day, Rota ).

path(Placei, Placef, Day, [], [Placei / Placef / Fnum / Day / Deptime]).

findCircuit(Placei, Day, Destlist, Route).

JAVA:

Compilar com: javac Flights.java

Executar com: java Flights
