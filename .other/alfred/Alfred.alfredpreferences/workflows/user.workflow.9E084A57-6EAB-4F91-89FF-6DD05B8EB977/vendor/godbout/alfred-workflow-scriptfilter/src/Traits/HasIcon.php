<?php

namespace Godbout\Alfred\Workflow\Traits;

use Godbout\Alfred\Workflow\Icon;

trait HasIcon
{
    public function icon(Icon $icon)
    {
        $this->fields['icon'] = $icon->toArray();

        return $this;
    }
}
