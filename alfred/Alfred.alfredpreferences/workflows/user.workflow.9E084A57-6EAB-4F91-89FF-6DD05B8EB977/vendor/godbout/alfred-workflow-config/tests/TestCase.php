<?php

namespace Tests;

use ReflectionClass;
use Godbout\Alfred\Workflow\Config;
use PHPUnit\Framework\TestCase as BaseTestCase;

class TestCase extends BaseTestCase
{
    protected $workflowDataFolder = './tests/mo.com.sleeplessmind.alfred-workflow-config';

    protected $configFile = null;


    protected function setUp(): void
    {
        parent::setUp();

        $this->configFile = $this->workflowDataFolder . '/config.json';

        putenv("alfred_workflow_data={$this->workflowDataFolder}");
    }

    protected function tearDown(): void
    {
        parent::tearDown();

        $this->resetConfigSingleton();

        if (file_exists($this->configFile)) {
            unlink($this->configFile);
        }

        if (file_exists($this->workflowDataFolder)) {
            rmdir($this->workflowDataFolder);
        }
    }

    private function resetConfigSingleton()
    {
        $config = Config::getInstance();
        $reflection = new ReflectionClass($config);
        $instance = $reflection->getProperty('instance');
        $instance->setAccessible(true);
        $instance->setValue(null, null);
        $instance->setAccessible(false);
    }
}
