-module(telemetry_router).
-export([log_signal/2]).

log_signal(TaskID, EventType) ->
    Time = erlang:system_time(picosecond),
    io:format("[Telemetry Router] Trace:~p Event:~p TimePS:~p~n", [TaskID, EventType, Time]),
    ok.
