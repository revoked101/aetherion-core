-module(kernel_scheduler).
-behaviour(gen_server).
-export([start_link/0, dispatch_task/2]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

start_link() -> gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).
init([]) -> {ok, #{quantum_load => 0, classical_load => 0}}.

dispatch_task(ID, #{engine := quantum} = Task) -> gen_server:call(?MODULE, {q_alloc, ID, Task});
dispatch_task(ID, #{engine := classical} = Task) -> gen_server:call(?MODULE, {c_alloc, ID, Task}).

handle_call({q_alloc, ID, _T}, _From, State) ->
    QLoad = maps:get(quantum_load, State) + 1,
    telemetry_router:log_signal(ID, quantum_core_engaged),
    {reply, {ok, scheduled_on_qubits}, State#{quantum_load := QLoad}};
handle_call({c_alloc, ID, _T}, _From, State) ->
    CLoad = maps:get(classical_load, State) + 1,
    telemetry_router:log_signal(ID, classical_node_engaged),
    {reply, {ok, scheduled_on_bits}, State#{classical_load := CLoad}}.

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Info, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
