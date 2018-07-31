
module sde.zipreader;

import dyaml;
import std.zip;
import std.stdio;
import std.conv;
import sde.fetchzip;

Node extractItemTypes(ZipArchive zipArchive) {
    auto zipMember = zipArchive.directory["sde/fsd/typeIDs.yaml"];
    ubyte[] bytes = zipArchive.expand(zipMember);

    Node rootNode = Loader.fromString(cast(char[]) bytes).load();
    return rootNode;
}

unittest {
    auto zip = fetchZip();
    auto rootNode = extractItemTypes(zip);
    auto numberOfItems = rootNode.length;
    assert(numberOfItems > 30_000);
}