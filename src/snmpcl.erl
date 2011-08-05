-module(snmpcl).

-export([walk/2]).

walk(Address, Oid) ->
    snmpm:start(),
    snmpm:register_user(snmpcl_user, snmpcl_user, undefined),
    snmpm:register_agent(snmpcl_user, "snmpcl_user", [
            {engine_id, "12312312"}, {address, Address},
            {community, "public"},
            {version, v2},
            {sec_level, noAuthNoPriv},
            {sec_model, v2c}]),
    snmpm:sync_get(snmpcl_user, "snmpcl_user", [Oid]).
            
