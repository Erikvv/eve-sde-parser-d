module sde.fetchzip;

import std.zip;
import std.stdio : writeln;
import requests;
import std.conv;

ZipArchive fetchZip(string url = "https://cdn1.eveonline.com/data/sde/tranquility/sde-20180713-TRANQUILITY.zip") {
    auto content = getContent(url).data;
    return new ZipArchive(content);
}

unittest {
    auto archive = fetchZip();
    assert(archive.numEntries > 5);
}