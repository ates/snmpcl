-module(snmpcl_user).

-behaviour(snmpm_user).

-export([handle_error/3, handle_agent/5, handle_pdu/4, handle_trap/3, handle_inform/3, handle_report/3]).

handle_error(ReqId, Reason, UserData) ->
    io:format("===========handle_error==========~n"),
    io:format("ReqId: ~p~nReason: ~p~nUserData: ~p~n", [ReqId, Reason, UserData]),
    io:format("==========end handle_error=======~n"),
    ignore.

handle_agent(Addr, Port, Type, SnmpInfo, UserData) ->
    io:format("===========handle_agent===========~n"),
    io:format("Addr: ~p~nPort: ~p~nType: ~p~nSnmpInfo: ~p~nUserData: ~p~n",
        [Addr, Port, Type, SnmpInfo, UserData]),
    io:format("==========end handle_agent========~n"),
    ignore.

handle_pdu(TargetName, ReqId, SnmpPduInfo, UserData) ->
        io:format("handle_pdu~n"),
        io:format("TargetName: ~p~nReqId: ~p~nSnmpPduInfo: ~p~nUserData: ~p~n", [TargetName, ReqId, SnmpPduInfo, UserData]).
handle_trap(TargetName, SnmpTrapInfo, UserData) ->
        io:format("TargetName: ~p~nSnmpInfomInfo: ~p~nUserData: ~p~n", [TargetName, SnmpTrapInfo, UserData]).
handle_inform(TargetName, SnmpInformInfo, UserData) ->
        io:format("TargetName: ~p~nSnmpInfomInfo: ~p~nUserData: ~p~n", [TargetName, SnmpInformInfo, UserData]).
handle_report(TargetName, SnmpReportInfo, UserData) ->
        io:format("TargetName: ~p~nSnmpReportInfo: ~p~nUserData: ~p~n", [TargetName, SnmpReportInfo, UserData]).

