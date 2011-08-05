SNMPcl: Simple SNMP client like snmpwalk
========================================

Compile & usage
---------------

    $ cd snmpcl
    $ make
    $ erl -pa ebin
    Erlang R14A (erts-5.8) [source] [64-bit] [smp:2:2] [rq:2] [async-threads:0] [kernel-poll:false]

    Eshell V5.8  (abort with ^G)
    1> application:start(snmpcl).
    ok
    2> snmpcl:walk("10.10.0.101", [1,3,6,1,2,1,1,5,0]).
    {[1,3,6,1,2,1,1,5,0],'OCTET STRING',"des3528"}

License
-------

All parts of this software distributed under GPLv3 terms.
