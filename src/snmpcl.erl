-module(snmpcl).

-behaviour(application).

%% application callbacks
-export([start/2, stop/1]).

%% API
-export([walk/2]).
-export([walk/3]).
-export([walk/4]).
-export([b_walk/3]).

start(_Type, _Args) ->
    snmpm:start(),
    snmpm:register_user(snmpcl_user, snmpcl_user, []),
    {ok, self()}.

stop(_State) -> ok.

walk(Address, BaseOid) ->
    walk(v2, Address, "public", BaseOid).
    
b_walk(Hosts, Community, BaseOid) ->
	[ walk(H, Community, BaseOid) || H <- Hosts ].

walk(Address, Community, BaseOid) ->
    walk(v2, Address, Community, BaseOid).

walk(Version, Address, Community, BaseOid) ->
    Options = [
	    {engine_id, "snmpcl"},
	    {community, Community},
	    {version, Version}
    ] ++
        case Address of
            {Host, Port} ->
                [
                    {taddress, Host},
                    {port, Port}
                ];
            Host -> [{taddress, Host}]
        end,
    case snmpm:which_agents(snmpcl_user) of
        [] -> ok;
        _ ->
            snmpm:unregister_agent(snmpcl_user, "snmpcl_user")
    end,
    snmpm:register_agent(snmpcl_user, "snmpcl_user", Options),

    case snmpm:sync_get_next(snmpcl_user, "snmpcl_user", [BaseOid]) of
        {ok,  {_, _, Result}, _Remaining} ->
            [{_, Oid, Type, Value, _}] = Result,
            walk_next(Oid, [{Oid, Type, Value}]);
        {error, Reason} ->
            error_logger:error_msg("Can't send request to ~p due to ~p~n", [Address, Reason])
    end.

walk_next(BaseOid, Acc) ->
    walk_next(lists:droplast(BaseOid), lists:last(BaseOid), Acc).

walk_next(BaseOid, Index, Acc) ->
    case snmpm:sync_get_next(snmpcl_user, "snmpcl_user", [BaseOid ++ [Index]]) of
        {ok,  {_, _, Result}, _Remaining} ->
            [{_, Oid, Type, Value, _}] = Result,
            case lists:droplast(Oid) of
                BaseOid -> walk_next(BaseOid, lists:last(Oid), [{Oid, Type, Value} | Acc]);
                _ -> Acc
            end;
        {error, Reason} ->
            error_logger:error_msg("Can't send request, reason: ~p~n", [Reason])
    end.
