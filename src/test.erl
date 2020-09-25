%%%-------------------------------------------------------------------
%%% @author m.azeem
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(test).
-author("m.azeem").
%% API
-export([testMap/0, testDijkstra/0, testHistory/0]).

testMap() ->
  NewMap = map:new(),
  io:format("Creating new map ~w~n", [NewMap]),
  UpdateResult = map:update(berlin, [london, stockholm], []),
  io:format("Update() returns ~w~n", [UpdateResult]),
  Reachable1 = map:reachable(berlin, [{berlin, [london, stockholm]}]),
  io:format("Reachable1 ~w~n", [Reachable1]),
  Reachable2 = map:reachable(london, [{berlin, [london, stockholm]}]),
  io:format("Reachable2 ~w~n", [Reachable2]),
  AllNodes = map:all_nodes([{berlin, [london, stockholm]}]),
  io:format("AllNodes() ~w~n", [AllNodes]),
  UpdateResult2 = map:update(berlin, [madrid], [{berlin, [london, stockholm]}]),
  io:format("Update2 returns ~w~n", [UpdateResult2]).

testDijkstra() ->
%%  Update1 = dijkstra:update(london, 2, amsterdam, []),
%%  io:format("Update1 -> ~w~n", [Update1]),
%%  Update2 = dijkstra:update(london, 2, amsterdam, [{london, 2, edinburgh}]),
%%  io:format("Update2 -> ~w~n", [Update2]),
%%  Update3 = dijkstra:update(london, 1, stockholm, [{berlin, 2, edinburgh}, {london, 3, edinburgh}]),
%%  io:format("Update3 -> ~w~n", [Update3]),
  IterateVal = dijkstra:iterate([{paris, 0, paris}, {berlin, inf, unknown}],[{paris, [berlin]}], []),
  io:format("Iterate() -> ~w~n", [IterateVal]),
  TableTest =  dijkstra:table([paris, madrid], [{madrid,[berlin]}, {paris, [rome,madrid]}]),
  io:format("Table() -> ~w~n", [TableTest]).

testHistory() ->
  NN = hist:new('Hey'),
  UU = hist:update(NN, 1, []),
  io:format("dshs ~w ~n", [UU]).

