-module(snmpcl).

-behaviour(application).

%% application callbacks
-export([start/2, stop/1]).

%% API
-export([walk/2, walk/3, walk/4]).

start(normal, _StartArgs) ->
    snmpm:start(),
    snmpm:register_user(snmpcl_user, snmpcl_user, undefined),
    {ok, self()}.

stop(_State) -> ok.

walk(Address, Oid) ->
    walk(v2, Address, "public", Oid).
    
b_walk(Hosts,Community,Oid) ->
	[ walk(H, Community, Oid) || H <- Hosts ].

walk(Address, Community, Oid) ->
    walk(v2, Address, Community, Oid).

walk(Version, Address, Community, Oid) ->
    Options =
	[{engine_id, "the engine"},
	 {community, Community},
	 {version, Version}
	| case Address of
	      {Host, Port} ->
		  [{address, Host},
		   {port, Port}
		  ];
	      Host ->
		  [{address, Host}]
	  end
	],
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
            error_logger:error_msg("Can't send request to ~s due to ~p~n",
                [Address, Reason])
    end.
