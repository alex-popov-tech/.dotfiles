<?php

namespace Godbout\Alfred\Workflow\Traits;

use Godbout\Alfred\Workflow\Variable;

trait HasVariables
{
    public $variables = null;

    public function variable(...$arguments)
    {
        if (! $arguments[0] instanceof Variable) {
            $arguments[0] = Variable::create($arguments[0], $arguments[1]);
        }

        $this->variables = array_merge((array) $this->variables, $arguments[0]->toArray());

        return $this;
    }

    public function variables(Variable ...$variables)
    {
        foreach ($variables as $variable) {
            $this->variable($variable);
        }

        return $this;
    }
}
