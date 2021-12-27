<?php

namespace Godbout\Alfred\Workflow;

class Config
{
    private static $instance = null;

    private $workflowDataFolder;

    private $configFile;


    private function __construct(array $defaultConfig = [])
    {
        $this->workflowDataFolder = getenv('alfred_workflow_data');
        $this->configFile = $this->workflowDataFolder . '/config.json';

        $this->createAlfredWorkflowDataFolderIfNeeded();
        $this->createConfigFileIfNeeded($defaultConfig);
    }

    public static function getInstance(array $defaultConfig = [])
    {
        if (is_null(self::$instance)) {
            self::$instance = new self($defaultConfig);
        }

        return self::$instance;
    }

    public static function ifEmptyStartWith(array $defaultConfig = [])
    {
        return self::getInstance($defaultConfig);
    }

    public static function read($key)
    {
        $dot = dot(self::getInstance()->getConfigFileContentAsArray());

        return $dot->get($key);
    }

    public static function write($key, $value)
    {
        $dot = dot(self::getInstance()->getConfigFileContentAsArray());

        $dot->set($key, $value);

        self::getInstance()->writeArrayToConfigFileContent($dot->all());
    }

    private function getConfigFileContentAsArray()
    {
        return json_decode(file_get_contents(self::getInstance()->configFile), true);
    }

    private function writeArrayToConfigFileContent(array $config = [])
    {
        file_put_contents(self::getInstance()->configFile, json_encode($config, JSON_PRETTY_PRINT));
    }

    private function createAlfredWorkflowDataFolderIfNeeded()
    {
        if (! file_exists($this->workflowDataFolder)) {
            mkdir($this->workflowDataFolder);
        }
    }

    private function createConfigFileIfNeeded(array $config)
    {
        if (! file_exists($this->configFile)) {
            file_put_contents($this->configFile, json_encode($config, JSON_PRETTY_PRINT));
        }
    }

    public static function destroy()
    {
        self::getInstance()->reset();

        self::$instance = null;
    }

    private function reset()
    {
        self::getInstance()->workflowDataFolder = null;
        self::getInstance()->configFile = null;
    }
}
