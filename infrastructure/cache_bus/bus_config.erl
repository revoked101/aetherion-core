-module(bus_config).
-behaviour(gen_server).
-export([start_link/0, dispatch_telemetry/2, get_power_profile/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
init([]) -> {ok, #{redis_latency_ns => 150, scaling_factor => 1.0}}.

dispatch_telemetry(StreamID, Payload) -> gen_server:call(?MODULE, {burst, StreamID, Payload}).
get_power_profile() -> {ok, #{source => diamond_isotope, status => optimal}}.

handle_call({burst, _ID, Data}, _From, State) ->
    Factor = maps:get(scaling_factor, State),
    NewFactor = case length(Data) > 1000 of true -> Factor + 0.5; false -> Factor end,
    {reply, {ok, transmitted}, State#{scaling_factor := NewFactor}};
handle_call(_Req, _From, State) -> {reply, ok, State}.

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Info, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVsn, State, _Extra) -> {ok, State}.
