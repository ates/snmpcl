-module(snmpcl_user).

-behaviour(snmpm_user).

-export([handle_error/3]).
-export([handle_agent/5]).
-export([handle_pdu/4]).
-export([handle_trap/3]).
-export([handle_inform/3]).
-export([handle_report/3]).

handle_error(ReqId, Reason, UserData) ->
    error_logger:info_msg("handle_error: req_id: ~p, reason: ~p, user_data: ~p~n", [
        ReqId, Reason, UserData
    ]),
    ignore.

handle_agent(Addr, Port, Type, SnmpInfo, UserData) ->
    error_logger:info_msg("handle_agent: addr: ~p, port: ~p, type: ~p, snmp_info: ~p, user_data: ~p~n", [
        Addr, Port, Type, SnmpInfo, UserData
    ]),
    ignore.

handle_pdu(TargetName, ReqId, SnmpPduInfo, UserData) ->
    error_logger:info_msg("handle_pdu: target_name: ~p, req_id: ~p, snmp_pdu_info: ~p, user_data: ~p~n", [
        TargetName, ReqId, SnmpPduInfo, UserData
    ]),
    ignore.

handle_trap(TargetName, SnmpTrapInfo, UserData) ->
    error_logger:info_smsg("handle_trap: target_name: ~p, snmp_trap_info: ~p, user_data: ~p~n", [
        TargetName, SnmpTrapInfo, UserData
    ]),
    ignore.

handle_inform(TargetName, SnmpInformInfo, UserData) ->
    error_logger:info_msg("handle_inform: target_name: ~p, snmp_inform_info: ~p, user_data: ~p~n", [
        TargetName, SnmpInformInfo, UserData
    ]),
    ignore.

handle_report(TargetName, SnmpReportInfo, UserData) ->
    error_logger:info_msg("handle_report: target_name: ~p, snmp_inform_info: ~p, user_data: ~p~n", [
        TargetName, SnmpReportInfo, UserData
    ]),
    ignore.
