<?php

namespace Godbout\Alfred\Workflow;

class Variable
{
    private $name = null;

    private $value = null;

    private function __construct($name = null, $value = null)
    {
        $this->name = $name;
        $this->value = $value;
    }

    public static function create($name = null, $value = null)
    {
        return new self($name, $value);
    }

    public function __call($name, $arguments)
    {
        if (property_exists($this, $name)) {
            $this->$name = reset($arguments);
        }

        return $this;
    }

    public function toArray()
    {
        if ($this->name === null || $this->value === null) {
            return [];
        }

        return [$this->name => $this->value];
    }
}
