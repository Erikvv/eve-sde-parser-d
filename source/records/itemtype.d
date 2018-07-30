module sde.records.itemtype;

import std.typecons;
import std.algorithm.iteration;
import std.stdio;
import std.range;
import std.array;
import dyaml;
import sde.yamlutils;

immutable struct ItemType {
    uint typeID;
    uint groupID;
    // optional members:
    string name;
    double mass;
    float volume;
    double basePrice;
    uint iconID;
    uint marketGroupID;

    static ItemType fromYamlPair(Node.Pair yamlPair) {
        auto value = yamlPair.value;

        return ItemType(
            yamlPair.key.get!uint,
            value["groupID"].as!uint,
            value["name"].getWithDefaultFallback!string("en"),
            value.getWithDefaultFallback!double("mass"),
            value.getWithDefaultFallback!float("volume"),
            value.getWithDefaultFallback!double("basePrice"),
            value.getWithDefaultFallback!uint("iconID"),
            value.getWithDefaultFallback!uint("marketGroupID"),
        );
    }

    static ItemType[] fromRootYaml(Node yamlRootNode) {
        return yamlRootNode
            .mapping()
            .map!(ItemType.fromYamlPair)
            .array;
    }
}

unittest {
    import std.string : strip;

    auto yamlString = strip("
222:
    groupID: 2
    name:
        de: Corporation
        en: Corporation
        fr: Corporation
        ja: コーポレーション
        ru: Corporation
        zh: 军团
    portionSize: 1
    published: false
333:
    groupID: 2
    name:
        de: Corporation
        en: Corporation
        fr: Corporation
        ja: コーポレーション
        ru: Corporation
        zh: 军团
    portionSize: 1
    published: false
");

    auto yamlRoot = Loader.fromString(yamlString).load();
    auto itemTypes = ItemType.fromRootYaml(yamlRoot);

    assert(itemTypes.length == 2);
}

unittest {
    import std.string : strip;
    import std.math : isNaN;

    auto yamlString = strip("
222:
    groupID: 2
    name:
        de: Corporation
        en: Corporation
        fr: Corporation
        ja: コーポレーション
        ru: Corporation
        zh: 军团
    portionSize: 1
    published: false
");

    auto yamlRoot = Loader.fromString(yamlString).load();
    auto itemType = ItemType.fromYamlPair(yamlRoot.mapping.front);

    assert(itemType.typeID == 222);
    assert(itemType.groupID == 2);
    assert(itemType.name == "Corporation");
    assert(isNaN(itemType.mass));
}
