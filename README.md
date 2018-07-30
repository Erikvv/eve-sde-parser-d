# Eve SDE parser

Parser of the [Eve Online Static Data Export](https://developers.eveonline.com/resource/resources) for the [D programming language (dlang)](https://dlang.org)

Not all types are implemented but they can be added easily. 

## Installation

todo

## Usage

```D
import sde.fetchzip;
import sde.zipreader;
import sde.itemtype;

auto zip = fetchZip();
auto rootNode = extractItemTypes(zip);
auto itemTypes = ItemType.fromRootYaml(rootNode);
```
