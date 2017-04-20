:- op(50, xfy, :).


flight(Place1, Place2, Day, Flight_num, Dep_time, Arr_time):-
    timetable(Place1,Place2, Flights),
    member(Dep_time/Arr_time/Flight_num/List_of_Days, Flights),
    travelDay(Day, List_of_Days).

travelDay(Day, List_of_Days):-
  member(Day, List_of_Days).

travelDay(Day, alldays):-
  member(Day, [mo, tu, we, th, fr, sa, su]).

deptime([_/_/_/Dep_time], Dep_time).

transfer(Time1, Time2):-
  Time1 = Horas1:Min1,
  Time2 = Horas2:Min2,
  ((Horas2 * 60) + Min2) - ((Horas1 * 60) +Min1) >=  40.




route(Place1, Place2, Day, [Place1/Place2/Fnum/Dep_time/Arr_time], _Visitados, PrevTime):-
  flight(Place1,Place2,Day,Fnum, Dep_time, Arr_time),
  transfer(PrevTime, Dep_time).

route(Place1, Place2, Day, [Place1/Place3/Fnum/Dep_time/Arr_time| NextRoute], Visitados,PrevTime):-
  flight(Place1, Place3, Day, Fnum, Dep_time, Arr_time),
  transfer(PrevTime, Dep_time),
  \+member(Place3, Visitados),
  route(Place3, Place2, Day, NextRoute, [Place3|Visitados],Arr_time).

  % deptime(NextRoute, NextDep_time),
  % transfer(Arr_time, NextDep_time).

inderect_flight(Place1, Place2, Day, Rota ):-
  route(Place1, Place2, Day, Rota, [Place1], 00:00).


  % ----------------------------------------------------

findCircuit(Placei, Day, Destlist, Route) :- path(Placei, Placei, Day, Destlist, Route).


nextday(mo, tu).
nextday(tu, we).
nextday(we, th).
nextday(th, fr).
nextday(fr, sa).
nextday(sa, su).
nextday(su, mo).


path(Placei, Placef, Day, [], [Placei / Placef / Fnum / Day / Deptime]) :-
  flight(Placei, Placef, Day, Fnum, Deptime, _).


path(Placei,Placef, Day, DXs, [Placei / Nextdest / Fnumi / Day / Deptimei|RXs]) :-
  member(Nextdest, DXs),
  flight(Placei, Nextdest, Day, Fnumi, Deptimei, _),
  nextday(Day, Nday),
  delete(DXs,Nextdest, NDXs),
  path(Nextdest,Placef, Nday, NDXs, RXs).

% ---------------------------------------------------

  timetable(edinburgh,london,
  [ 9:40/10:50/ba4733/alldays,
  13:40/14:50/ba4773/alldays,
  19:40/20:50/ba4833/[mo,tu,we,th,fr,su]]).

  timetable(london,edinburgh,
  [ 9:40/10:50/ba4732/alldays,
  11:40/12:50/ba4752/alldays,
  18:40/19:50/ba4822/[mo,tu,we,th,fr]]).

  timetable(london,ljubljana,
  [13:20/16:20/ju201/[fr],
  13:20/16:20/ju213/[su]]).

  timetable(london,zurich,
  [ 9:10/11:45/ba614/alldays,
  14:45/17:20/sr805/alldays]).

  timetable(london,milan,
  [ 8:30/11:20/ba510/alldays,
  11:00/13:50/az459/alldays]).

  timetable(ljubljana,zurich,
  [11:30/12:40/ju322/[tu,th]]).

  timetable(ljubljana,london,
  [11:10/12:20/yu200/[fr],
  11:25/12:20/yu212/[su]]).

  timetable(milan,london,
  [ 9:10/10:00/az458/alldays,
  12:20/13:10/ba511/alldays]).

  timetable(milan,zurich,
  [ 9:25/10:15/sr621/alldays,
  12:45/13:35/sr623/alldays]).

  timetable(zurich,ljubljana,
  [13:30/14:40/yu323/[tu,th]]).

  timetable(zurich,london,
  [ 9:00/9:40/ba613/[mo,tu,we,th,fr,sa],
  16:10/16:55/sr806/[mo,tu,we,th,fr,su]]).

  timetable(zurich,milan,
  [ 7:55/8:45/sr620/alldays]).
