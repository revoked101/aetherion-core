-module(aetherion_app).
-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    io:format("~n========================================~n"),
    io:format("[AETHERION] Initialising Hybrid Quantum OS Kernel...~n"),
    io:format("========================================~n"),
    %% This supervisor will keep our fault-tolerant nodes alive eternally
    sys_kernel_sup:start_link().

stop(_State) ->
    io:format("[AETHERION] System powering down clean.~n"),
    ok.
