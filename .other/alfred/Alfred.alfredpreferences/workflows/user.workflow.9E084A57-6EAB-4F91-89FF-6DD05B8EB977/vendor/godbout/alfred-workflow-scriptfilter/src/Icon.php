<?php

namespace Godbout\Alfred\Workflow;

class Icon
{
    const TYPES_ALLOWED = [
        'fileicon',
        'filetype',
    ];

    private $fields = [];

    private function __construct($path = null, $type = null)
    {
        if ($path !== null) {
            $this->fields['path'] = $path;
        }

        if ($type !== null) {
            $this->fields['type'] = $type;
        }
    }

    public static function create($path = null)
    {
        return new self($path);
    }

    public static function createFileicon($path = null)
    {
        return new self($path, 'fileicon');
    }

    public static function createFiletype($path = null)
    {
        return new self($path, 'filetype');
    }

    public function path($path)
    {
        $this->fields['path'] = $path;

        return $this;
    }

    public function __call($name, $arguments)
    {
        if (in_array($name, self::TYPES_ALLOWED)) {
            $this->fields['type'] = $name;
        }

        return $this;
    }

    public function toArray()
    {
        return $this->fields;
    }
}
