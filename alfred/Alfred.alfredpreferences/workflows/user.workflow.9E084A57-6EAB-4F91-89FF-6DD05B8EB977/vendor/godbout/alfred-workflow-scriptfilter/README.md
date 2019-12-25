<h1 align="center">PHP Alfred Workflow ScriptFilter</h1>

<p align="center">
    <a href="https://packagist.org/packages/godbout/alfred-workflow-scriptfilter"><img src="https://img.shields.io/packagist/v/godbout/alfred-workflow-scriptfilter.svg?style=flat-square" alt="Latest Version on Packagist"></a>
    <a href="https://travis-ci.org/godbout/alfred-workflow-scriptfilter"><img src="https://img.shields.io/travis/godbout/alfred-workflow-scriptfilter/master.svg?style=flat-square" alt="Build Status"></a>
    <a href="https://scrutinizer-ci.com/g/godbout/alfred-workflow-scriptfilter"><img src="https://img.shields.io/scrutinizer/g/godbout/alfred-workflow-scriptfilter.svg?style=flat-square" alt="Quality Score"></a>
    <a href="https://scrutinizer-ci.com/g/godbout/alfred-workflow-scriptfilter"><img src="https://scrutinizer-ci.com/g/godbout/alfred-workflow-scriptfilter/badges/coverage.png?b=master" alt="Code Coverage"></a>
    <a href="https://packagist.org/packages/godbout/alfred-workflow-scriptfilter"><img src="https://img.shields.io/packagist/dt/godbout/alfred-workflow-scriptfilter.svg?style=flat-square" alt="Total Downloads"></a>
</p>

___

## Why

Starting with Alfred 3.4.1 you can define [variables][1] for individual items and
variables and icon for each various modifiers (ctrl, cmd, shift, fn, alt) of each item.
That makes rendering the results for Alfred a little tougher than usual with the current tools
available, hence this package.

If you don't need the new fields introduced by Alfred 3.4.1 and 3.5, you might want to use
Joe Tannenbaum's [package][2]. His API might be a little less heavier than mine.

## Installation

```php
composer require godbout/alfred-workflow-scriptfilter
```

## Usage

The main `ScriptFilter` class is a singleton. You can create many
instances of all the other classes: `Item`, `Variable`, `Icon`, and the `Mod` classes: `Ctrl`, `Fn`, `Shift`, `Alt`, and `Cmd`.

You may check the structure and options of the Alfred Script Filter JSON Format here: https://www.alfredapp.com/help/workflows/inputs/script-filter/json/

```php
require __DIR__ . '/../vendor/autoload.php';

use Godbout\Alfred\Workflow\ScriptFilter;

echo ScriptFilter::output();
```

will result in:

```json
{"items":[]}
```

You can add items, variables, rerun automatically your script:

```php
ScriptFilter::add(
    Item::create()
        ->uid('uidd')
        ->title('titlee')
        ->subtitle('subtitlee')
        ->arg('argg')
        ->icon(
            Icon::create('icon path')
        )
        ->valid()
        ->match('matchh')
        ->autocomplete('autocompletee')
        ->mod(
            Ctrl::create()
                ->arg('ctrl arg')
                ->subtitle('ctrl subtitle')
                ->valid()
        )
        ->copy('copyy')
        ->largetype('largetypee')
        ->quicklookurl('quicklookurll')
);

ScriptFilter::add(
    Variable::create('food', 'chocolate'),
    Variable::create('dessert', 'red beans')
);

ScriptFilter::rerun(4.5);

$anotherItem = Item::create()
    ->icon(
        Icon::createFileicon('icon pathh')
    )
    ->mods(
        Shift::create()
            ->subtitle('shift subtitle'),
        Fn::create()
            ->arg('fn arg')
            ->valid(true)
    );

$thirdItem = Item::create()
    ->variables(
        Variable::create('guitar', 'fender'),
        Variable::create('amplifier', 'orange')
    )
    ->mod(
        Alt::create()
            ->icon(
                Icon::createFileicon('alt icon path')
            )
            ->variables(
                Variable::create('grade', 'colonel'),
                Variable::create('drug', 'power')
            )
    );

ScriptFilter::add($anotherItem, $thirdItem);

echo ScriptFilter::output();
```

will result in:

```json
{
    "rerun":4.5,
    "variables":{
        "food":"chocolate",
        "dessert":"red beans"
    },
    "items":[
        {
            "uid":"uidd",
            "title":"titlee",
            "subtitle":"subtitlee",
            "arg":"argg",
            "icon":{
                "path":"icon path"
            },
            "valid":true,
            "match":"matchh",
            "autocomplete":"autocompletee",
            "mods":{
                "ctrl":{
                    "arg":"ctrl arg",
                    "subtitle":"ctrl subtitle",
                    "valid":true
                }
            },
            "text":{
                "copy":"copyy",
                "largetype":"largetypee"
            },
            "quicklookurl":"quicklookurll"
        },
        {
            "icon":{
                "path":"icon pathh",
                "type":"fileicon"
            },
            "mods":{
                "shift":{
                    "subtitle":"shift subtitle"
                },
                "fn":{
                    "arg":"fn arg",
                    "valid":true
                }
            }
        },
        {
            "mods":{
                "alt":{
                    "icon":{
                        "path":"alt icon path",
                        "type":"fileicon"
                    },
                    "variables":{
                        "grade":"colonel",
                        "drug":"power"
                    }
                }
            },
            "variables":{
                "guitar":"fender",
                "amplifier":"orange"
            }
        }
    ]
}
```

You can sort your results ascendingly, descendingly, by title or anything else:

```php

/**
 * Will sort the items ascendingly
 * based on titles.
 */
ScriptFilter::add(...);
ScriptFilter::sortItems();
ScriptFilter::output();

/**
 * Will sort the items descendingly
 * based on subtitles.
 */
ScriptFilter::add(...);
ScriptFilter::sortItems('desc', 'subtitle');
ScriptFilter::output();
```

You can filter your results (you might want to do this with the input from the user) based on any field from your items:

```php

/**
 * Only items with a title that contains
 * 'start' will show up in the output.
 */
ScriptFilter::add(...);
ScriptFilter::filterItems('start');
ScriptFilter::output();

/**
 * Only items with a subtitle that contains
 * 'end' will show up in the output.
 */
ScriptFilter::add(...);
ScriptFilter::filterItems('end', 'subtitle');
ScriptFilter::output();
```

## Helpers

There's a couple of helpers that should make your code a bit more enjoyable to write. (Or not.)

### ScriptFilter

The ScriptFilter can be written using a fluent interface:

```php
ScriptFilter::create()
    ->item($item)
    ->variable(Variable::create('gender', 'undefined'))
    ->items($anotherItem, $oneMoreItem)
    ->variables($aVariable, $anotherVariable)
    ->rerun(4)
    ->item(Item::create());
```

### Item

```php
Item::createDefault();
// same same
Item::create()->default();
// same same
Item::create()->type('default');


Item::createFile();
// same same
Item::create()->file();
// same same
Item::create()->type('file');


Item::createSkipcheck();
// same same
Item::create()->skipcheck();
// same same
Item::create()->type('file:skipcheck');


Item::create()->copy('text to copy');
// same same
Item::create()->text('copy', 'text to copy');


Item::create()->largetype('show large');
// same same
Item::create()->text('largetype', 'show large');
```

### Icon

```php
Icon::create('~/Desktop');
// same same
Icon::create()->path('~/Desktop');


Icon::createFileicon('~/Desktop');
// same same
Icon::create('~/Desktop')->fileicon();


Icon::createFiletype('~/Desktop');
// same same
Icon::create()->path('~/Desktop')->filetype();
```

### Variable

```php
Variable::create('guitar', 'fender');
// same same
Variable::create()->name('guitar')->value('fender');


/**
 * Anywhere you use the ->variable(...) fluent interface
 * you can pass the name and value arguments directly
 * if this is your thing.
 */
...->variable(Variable::create('gender', 'unknown');
// same same
...->variable('gender', 'unknown');
```

## Full API

You might want to check the tests to see the full API: [tests][3]

The API should mostly help you avoid typing too much and putting wrong data
where Alfred is expecting something strict.

## Alternatives

* [alfred-workflow][2] by Joe Tannenbaum


[1]: https://www.alfredapp.com/help/workflows/inputs/script-filter/json/#variables
[2]: https://github.com/joetannenbaum/alfred-workflow
[3]: https://github.com/godbout/alfred-workflow-scriptfilter/tree/master/tests
