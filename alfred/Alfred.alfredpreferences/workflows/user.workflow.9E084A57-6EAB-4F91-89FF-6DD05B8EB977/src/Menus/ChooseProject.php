<?php

namespace Godbout\Alfred\Time\Menus;

use Godbout\Alfred\Time\Workflow;
use Godbout\Alfred\Workflow\Icon;
use Godbout\Alfred\Workflow\Item;
use Godbout\Alfred\Workflow\ScriptFilter;

class ChooseProject extends Menu
{
    public static function scriptFilter()
    {
        $service = Workflow::serviceEnabled();

        if ($service->allowsEmptyProject) {
            ScriptFilter::add(self::getNoProject());
        }

        foreach (self::getServiceProjects($service) as $project) {
            ScriptFilter::add($project);
        }

        if (self::userInput()) {
            ScriptFilter::filterItems(self::userInput());
        }

        ScriptFilter::sortItems('asc', 'match');
    }

    private static function getNoProject()
    {
        return Item::create()
            ->match('')
            ->arg('do')
            ->variable('timer_action', 'start');
    }

    private static function getServiceProjects($service)
    {
        $projects = [];

        foreach ($service->projects() as $id => $name) {
            $projects[] = Item::create()
                ->title($name)
                ->variable('timer_project_id', $id)
                ->variable('timer_project_name', $name)
                ->match($name)
                ->arg('do')
                ->variable('timer_action', 'start');
        }

        return $projects;
    }
}
