#include "erl_nif.h"
#include <math.h>

ERL_NIF_TERM inf_atom;
ERL_NIF_TERM ninf_atom;
ERL_NIF_TERM nan_atom;

ERL_NIF_TERM true_atom;
ERL_NIF_TERM false_atom;

static ERL_NIF_TERM
mk_atom(ErlNifEnv* env, const char* atom)
{
    ERL_NIF_TERM ret;

    return enif_make_existing_atom(env, atom, &ret, ERL_NIF_LATIN1) ? ret : enif_make_atom(env, atom);
}

static int load(ErlNifEnv* env, void** priv, ERL_NIF_TERM load_info)
{
    inf_atom = mk_atom(env, "Infinity");
    ninf_atom = mk_atom(env, "-Infinity");
    nan_atom = mk_atom(env, "NaN");

    true_atom = mk_atom(env, "true");
    false_atom = mk_atom(env, "false");

    return 0;
}

static double get_double(ErlNifEnv* env, ERL_NIF_TERM term)
{
    if (term == inf_atom)
    {
        return INFINITY;
    }

    if (term == ninf_atom)
    {
        return -INFINITY;
    }

    double d = NAN;
    enif_get_double(env, term, &d);
    return d;
}

static ERL_NIF_TERM make_double(ErlNifEnv* env, double d)
{
    if (isinf(d))
    {
        return d > 0 ? inf_atom : ninf_atom;
    }

    if (isnan(d))
    {
        return nan_atom;
    }

    // This should never fail. Can we skip the enif safety checks somehow?
    return enif_make_double(env, d);
}

static ERL_NIF_TERM
multiply(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return make_double(env, get_double(env, argv[0]) * get_double(env, argv[1]));
}

static ERL_NIF_TERM
add(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return make_double(env, get_double(env, argv[0]) + get_double(env, argv[1]));
}

static ERL_NIF_TERM
subtract(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return make_double(env, get_double(env, argv[0]) - get_double(env, argv[1]));
}

static ERL_NIF_TERM
divide(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return make_double(env, get_double(env, argv[0]) / get_double(env, argv[1]));
}

static ERL_NIF_TERM
absolute_value(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    return make_double(env, fabs(get_double(env, argv[0])));
}

static ErlNifFunc nif_funcs[] = {
    {"multiply", 2, multiply},
    {"add", 2, add},
    {"subtract", 2, subtract},
    {"divide", 2, divide},
    {"absolute_value", 1, absolute_value},
};

ERL_NIF_INIT(js_floats, nif_funcs, load, NULL, NULL, NULL);