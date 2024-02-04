import { Error, Ok } from "../prelude.mjs";

export function multiply(a, b) {
    return a * b;
}

export function divide(a, b) {
    return a / b;
}

export function add(a, b) {
    return a + b;
}

export function subtract(a, b) {
    return a - b;
}

export function absolute_value(a) {
    return Math.abs(a);
}


export function as_finite(a) {
    if (isFinite(a)) {
        return new Ok(a);
    }

    return new Error(undefined);
}

export function is_infinite(a) {
    return !isFinite(a);
}

export function is_nan(a) {
    return isNaN(a);
}


export function from_finite(a) {
    return a;
}

export function infinity() {
    return Infinity;
}

export function negative_infinity() {
    return -Infinity;
}
