module sde.yamlutils;

import dyaml;

T getWithDefaultFallback(T)(Node yamlMap, string key) {
    if (yamlMap.containsKey(key)) {
        return yamlMap[key].as!T;
    } else {
        return T.init;
    }
}

Nullable!T getNullable(T)(Node yamlMap, string key) {
    if (yamlMap.containsKey(key)) {
        return Nullable!T(yamlMap[key].as!T);
    }

    return Nullable!T();
}