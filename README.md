SNMPcl: Simple SNMP client like snmpwalk
========================================

Compile & usage
---------------

    $ rebar3 shell
    Erlang/OTP 20 [erts-9.1] [source] [64-bit] [smp:8:8] [ds:8:8:10] [async-threads:0] [hipe] [kernel-poll:false]

    Eshell V9.1  (abort with ^G)
    1> snmpcl:walk({127,0,0,1}, [1,3,6,1,2,1,1,5,0]).
    {[1,3,6,1,2,1,1,5,0],'OCTET STRING',"myhost"}


License
-------

All parts of this software distributed under GPLv3 terms.
