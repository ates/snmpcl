{application, snmpcl, [
    {description, "Simple SNMP client"},
    {vsn, "0.1"},
    {modules, [
        snmpcl,
        snmpcl_user
    ]},
    {registered, []},
    {applications, [kernel, stdlib]},
    {mod, {snmpcl, []}}
]}.
