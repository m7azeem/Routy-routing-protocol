%%%-------------------------------------------------------------------
%%% @author m.azeem
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(dijkstra).
-author("m.azeem").

%% API
%% exporting extra functions since they are being tested in the test module.
-export([update/4 ,table/2, route/2, iterate/3]).

entry(Node, Sorted) ->
  case lists:keyfind(Node, 1, Sorted) of
    {_, ShortestLength, _} ->
      ShortestLength;
    false ->
      0
  end.

replace(Node, N, Gateway, Sorted) ->
  case lists:keyfind(Node, 1, Sorted) of
    {Node, _, _} ->
      UpdatedList = lists:keyreplace(Node, 1, Sorted, {Node, N, Gateway}),
      lists:keysort(2, UpdatedList);
    false ->
      Sorted
  end.

update(Node, N, Gateway, Sorted) ->
  CurrentLength = entry(Node, Sorted),
  if
    N < CurrentLength ->
      replace(Node, N, Gateway, Sorted);
    true ->
      Sorted
  end.

iterate([], Map, Table) ->
  Table;
iterate([{_,inf, _}| _], Map, Table) ->
  Table;
iterate([{Node, N, Gateway} | Sorted], Map, Table) ->
  case map:reachable(Node, Map) of
    [] ->
      iterate(Sorted, Map, [{Node, Gateway} | Table]);
    Nodes ->
      UpdatedList = lists:foldl(fun(Nod, SList) -> update(Nod, N +1, Gateway, SList) end, Sorted, Nodes),
      UpdatedTable = [{Node, Gateway} | Table],
      iterate(UpdatedList, Map, UpdatedTable)
  end.

table(Gateways, Map) ->
  NodesList = lists:foldl(fun(X, Acc) ->
    case lists:member(X, Gateways) of
      true ->
        Temp = [{X, 0, X}],
        lists:append(Temp, Acc);
      false ->
        Temp = [{X, inf, unknown}],
        lists:append(Temp, Acc)
    end
  end, [], map:all_nodes(Map)),
  Sorted = lists:keysort(2, NodesList),
  iterate(Sorted, Map, []).

route(Node, Table) ->
  case lists:keyfind(Node, 1, Table) of
    {Node, Gateway} ->
      {ok, Gateway};
    false ->
      notfound
  end.
