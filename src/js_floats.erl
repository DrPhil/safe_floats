-module(js_floats).
-export([multiply/2, add/2, subtract/2, divide/2, absolute_value/1,
  as_finite/1, is_infinite/1, is_nan/1,
  from_finite/1, infinity/0, negative_infinity/0]).
-on_load(init/0).

-define(APPNAME, js_floats).
-define(LIBNAME, js_floats).

multiply(_, _) -> not_loaded(?LINE).
add(_, _) -> not_loaded(?LINE).
subtract(_, _) -> not_loaded(?LINE).
divide(_, _) -> not_loaded(?LINE).
absolute_value(_) -> not_loaded(?LINE).

as_finite('Infinity') -> {error, nil};
as_finite('-Infinity') -> {error, nil};
as_finite('NaN') -> {error, nil};
as_finite(X) -> {ok, X}.

is_infinite('Infinity') -> true;
is_infinite('-Infinity') -> true;
is_infinite(_) -> false.

is_nan('NaN') -> true;
is_nan(_) -> false.

from_finite(X) -> X.
infinity() -> 'Infinity'.
negative_infinity() -> '-Infinity'.

init() ->
  SoName = case code:priv_dir(?APPNAME) of
             {error, bad_name} ->
               case filelib:is_dir(filename:join(["..", priv])) of
                 true ->
                   filename:join(["..", priv, ?LIBNAME]);
                 _ ->
                   filename:join([priv, ?LIBNAME])
               end;
             Dir ->
               filename:join(Dir, ?LIBNAME)
           end,
  erlang:load_nif(SoName, 0).

not_loaded(Line) ->
  erlang:nif_error({not_loaded, [{module, ?MODULE}, {line, Line}]}).
