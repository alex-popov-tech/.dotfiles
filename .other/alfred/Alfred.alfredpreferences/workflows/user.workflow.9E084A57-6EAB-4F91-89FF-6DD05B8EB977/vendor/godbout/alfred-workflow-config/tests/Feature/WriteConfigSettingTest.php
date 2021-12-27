<?php

namespace Tests\Feature;

use Tests\TestCase;
use Godbout\Alfred\Workflow\Config;

class WriteConfigSettingTest extends TestCase
{
    /** @test */
    public function it_can_add_a_setting_in_an_empty_config_file()
    {
        Config::write('car', 'renault');

        $this->assertJsonStringEqualsJsonFile($this->configFile, json_encode(['car' => 'renault']));
    }

    /** @test */
    public function it_can_add_a_setting_in_a_non_empty_config_file()
    {
        $defaultConfig = [
            'country' => 'China'
        ];

        Config::ifEmptyStartWith($defaultConfig);

        Config::write('plane', 'airbus');

        $this->assertJsonStringEqualsJsonFile(
            $this->configFile,
            json_encode(['country' => 'China', 'plane' => 'airbus'])
        );
    }

    /** @test */
    public function it_can_update_a_setting()
    {
        $defaultConfig = [
            'computer' => 'iMac'
        ];

        Config::ifEmptyStartWith($defaultConfig);

        Config::write('computer', 'MacBook');

        $this->assertJsonStringEqualsJsonFile($this->configFile, json_encode(['computer' => 'MacBook']));
    }

    /** @test */
    public function it_can_add_a_nested_setting_using_dot_notation_syntax()
    {
        Config::write('timer.toggl.token', 'the_toggl_token');

        $this->assertJsonStringEqualsJsonFile(
            $this->configFile,
            json_encode(['timer' => ['toggl' => ['token' => 'the_toggl_token']]
            ])
        );
    }

    /** @test */
    public function it_can_add_multiple_settings()
    {
        Config::write('human', true);
        Config::write('author.name', 'Guillaume');
        Config::write('author.age', 37);

        $this->assertJsonStringEqualsJsonFile(
            $this->configFile,
            json_encode(
                [
                    'human' => true,
                    'author' => [
                        'name' => 'Guillaume',
                        'age' => 37,
                    ]
                ]
            )
        );
    }
}
