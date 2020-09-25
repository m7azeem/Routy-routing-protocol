%%%-------------------------------------------------------------------
%%% @author m.azeem
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(hist).
-author("m.azeem").

%% API
-export([new/1, update/3]).

new(Name) ->
  [{Name, 0}].

update(Node, N, History) ->
  io:format("update(~w, ~w, ~w) ~n", [Node, N, History]),
  case lists:keyfind(Node, 1, History) of
    {_, CurrentNumber} ->
      case N > CurrentNumber of
        true ->
          {new, lists:keyreplace(Node, 1, History, {Node, N})};
        false ->
          {old}
      end;
    false ->
      {new, [new(Node) | History]}
  end.