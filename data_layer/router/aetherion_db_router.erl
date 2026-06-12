-module(aetherion_db_router).
-behaviour(gen_server).
-export([start_link/0, route_query/3]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
init([]) -> {ok, #{}}.
route_query(Key, Data, Paradigm) -> gen_server:call(?MODULE, {route, Key, Data, Paradigm}).

handle_call({route, Key, _Data, relational_acid}, _From, State) ->
    kernel_scheduler:dispatch_task(Key, #{engine => classical, route_target => cockroach}),
    {reply, {ok, cockroach, dispatched}, State};
handle_call({route, Key, _Data, wide_column_scale}, _From, State) ->
    kernel_scheduler:dispatch_task(Key, #{engine => classical, route_target => cassandra}),
    {reply, {ok, cassandra, dispatched}, State};
handle_call({route, Key, _Data, document_flexible}, _From, State) ->
    kernel_scheduler:dispatch_task(Key, #{engine => classical, route_target => mongo}),
    {reply, {ok, mongo, dispatched}, State};
handle_call({route, Key, _Data, astrophysical_lattice}, _From, State) ->
    kernel_scheduler:dispatch_task(Key, #{engine => quantum, route_target => lattice_core}),
    {reply, {ok, lattice_core, dispatched}, State};
handle_call({route, Key, _Data, _Default}, _From, State) ->
    kernel_scheduler:dispatch_task(Key, #{engine => classical, route_target => postgres}),
    {reply, {ok, postgres, dispatched}, State};
handle_call(_Req, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Info, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
