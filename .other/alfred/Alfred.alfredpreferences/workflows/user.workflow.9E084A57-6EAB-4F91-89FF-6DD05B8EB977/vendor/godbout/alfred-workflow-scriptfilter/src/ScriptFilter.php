<?php

namespace Godbout\Alfred\Workflow;

use Godbout\Alfred\Workflow\Traits\HasVariables;

class ScriptFilter
{
    use HasVariables;

    private static $instance = null;

    private $rerun = null;

    private $items = [];


    public static function getInstance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new self;
        }

        return self::$instance;
    }

    public static function create()
    {
        return self::getInstance();
    }

    public static function rerun($seconds = null)
    {
        if ($seconds >= 0.1 && $seconds <= 5.0) {
            self::getInstance()->rerun = $seconds;
        }

        return self::$instance;
    }

    public function item(Item $item)
    {
        self::getInstance()->add($item);

        return $this;
    }

    public function items(Item ...$items)
    {
        self::getInstance()->add(...$items);

        return $this;
    }

    public static function add(...$objects)
    {
        foreach ($objects as $object) {
            if ($object instanceof Variable) {
                self::getInstance()->variable($object);
            }

            if ($object instanceof Item) {
                self::getInstance()->items[] = $object;
            }
        }

        return self::$instance;
    }

    public static function filterItems($term = '', $field = 'title')
    {
        $items = &self::getInstance()->items;

        $items = array_values(
            array_filter($items, function ($item) use ($term, $field) {
                if (empty($term) || stripos($item->$field, $term) !== false) {
                    return $item;
                }
            })
        );

        return self::$instance;
    }

    public static function sortItems($direction = 'asc', $field = 'title')
    {
        $items = &self::getInstance()->items;

        usort($items, function ($a, $b) use ($direction, $field) {
            if ($direction !== 'asc') {
                return strtolower($b->$field) > strtolower($a->$field);
            }

            return strtolower($a->$field) > strtolower($b->$field);
        });

        return self::$instance;
    }

    public static function output()
    {
        if (self::getInstance()->rerun !== null) {
            $output['rerun'] = self::getInstance()->rerun;
        }

        if (self::getInstance()->variables !== null) {
            $output['variables'] = self::getInstance()->variables;
        }

        $output['items'] = array_map(function ($item) {
            return $item->toArray();
        }, self::getInstance()->items);

        return json_encode($output);
    }

    public static function destroy()
    {
        self::getInstance()->reset();

        self::$instance = null;
    }

    public static function reset()
    {
        self::getInstance()->rerun = null;
        self::getInstance()->variables = null;
        self::getInstance()->items = [];
    }
}
