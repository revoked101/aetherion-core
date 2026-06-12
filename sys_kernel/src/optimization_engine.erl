-module(optimization_engine).
-export([optimize_matrix/2, check_battery/0]).

optimize_matrix(TaskID, Matrix) ->
    case length(Matrix) > 5000 of
        true -> kernel_scheduler:dispatch_task(TaskID, #{engine => quantum, task => optimization});
        false -> kernel_scheduler:dispatch_task(TaskID, #{engine => classical, task => brute_force})
    end.

check_battery() ->
    {ok, #{source => diamond_isotope, baseline_draw_watts => 0.05}}.
