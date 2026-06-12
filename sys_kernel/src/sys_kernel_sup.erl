-module(sys_kernel_sup).
-behaviour(supervisor).
-export([start_link/0, init/1]).

start_link() -> supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    Flags = #{strategy => one_for_all, intensity => 40, period => 1},
    Specs = [
        #{id => telemetry_router, start => {telemetry_router, start_link, []}, type => worker},
        #{id => kernel_scheduler, start => {kernel_scheduler, start_link, []}, type => worker},
        #{id => lattice_core, start => {lattice_core, start_link, []}, type => worker},
        #{id => aetherion_db_router, start => {aetherion_db_router, start_link, []}, type => worker},
        #{id => bus_config, start => {bus_config, start_link, []}, type => worker}
    ],
    {ok, {Flags, Specs}}.
