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

walk(Address, Oid) ->
    walk(v2, Address, "public", Oid).
    
b_walk(Hosts, Community, Oid) ->
	[ walk(H, Community, Oid) || H <- Hosts ].

walk(Address, Community, Oid) ->
    walk(v2, Address, Community, Oid).

walk(Version, Address, Community, Oid) ->
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
    case snmpm:sync_get(snmpcl_user, "snmpcl_user", [Oid]) of
        {ok,  {_, _, Result}, _Remaining} ->
            [{_, Oid, Type, Value, _}] = Result,
            {Oid, Type, Value};
        {error, Reason} ->
            error_logger:error_msg("Can't send request to ~p due to ~p~n", [Address, Reason])
    end.
