<?php

namespace Godbout\Alfred\Workflow\Mods;

use Godbout\Alfred\Workflow\Traits\HasIcon;
use Godbout\Alfred\Workflow\Traits\HasVariables;

abstract class Mod
{
    use HasIcon, HasVariables;

    const FIELDS_ALLOWED = [
        'valid',
        'arg',
        'subtitle',
        'icon',
        'variables',
    ];

    private $fields = [];

    public static function create()
    {
        return new static();
    }

    public function valid($validity = true)
    {
        $this->fields['valid'] = (bool) $validity;

        return $this;
    }

    public function __call($name, $arguments)
    {
        if (in_array($name, self::FIELDS_ALLOWED)) {
            $this->fields[$name] = reset($arguments);

            return $this;
        }

        $classShortName = (new \ReflectionClass($this))->getShortName();

        throw new \Exception("'$name' is not a valid $classShortName field.");
    }

    public function toArray()
    {
        if ($this->variables !== null) {
            $this->fields['variables'] = $this->variables;
        }

        return $this->fields;
    }
}
