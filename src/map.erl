%%%-------------------------------------------------------------------
%%% @author m.azeem
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(map).
-author("m.azeem").

%% API
-export([new/0, update/3, reachable/2, all_nodes/1]).

new() ->
  [].

update(Node, Links, Map) ->
  case lists:keyfind(Node, 1, Map) of
    {_, _} ->
      lists:keyreplace(Node, 1, Map, {Node, Links});
    false ->
      [{Node, Links}]
  end.

reachable(Node, Map) ->
  case lists:keyfind(Node, 1, Map) of
    {_, Links} ->
      Links;
    false ->
      []
  end.

all_nodes(Map) ->
  ListOfLists = lists:map(fun({K, L}) -> [K | L] end, Map),
  FlatList = lists:flatten(ListOfLists),
  lists:usort(FlatList).