<?php

namespace MorningTrain\TogglApi;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;

/**
 * Wrapper for the Toggl Reports Api.
 *
 * @see https://github.com/toggl/toggl_api_docs/blob/master/reports.md
 */
class TogglReportsApi
{

    /**
     * @var string
     */
    protected $apiToken = '';

    /**
     * @var \GuzzleHttp\Client
     */
    protected $client;

    /**
     * TogglReportsApi constructor.
     *
     * @param string $apiToken
     */
    public function __construct($apiToken)
    {
        $this->apiToken = $apiToken;
        $this->client = new Client([
            'base_uri' => 'https://www.toggl.com/reports/api/v2/',
            'auth' => [$this->apiToken, 'api_token'],
        ]);
    }

    /**
     * Get available endpoints.
     *
     * @return bool|mixed|object
     */
    public function getAvailableEndpoints()
    {
        return $this->get('');
    }

    /**
     * Get project report.
     *
     * @param string $query
     *
     * @return bool|mixed|object
     */
    public function getProjectReport($query)
    {
        return $this->get('project', $query);
    }

    /**
     * Get summary report.
     *
     * @param string $query
     *
     * @return bool|mixed|object
     */
    public function getSummaryReport($query)
    {
        return $this->get('summary', $query);
    }

    /**
     * Get details report.
     *
     * @param string $query
     *
     * @return bool|mixed|object
     */
    public function getDetailsReport($query)
    {
        return $this->get('details', $query);
    }

    /**
     * Get weekly report.
     *
     * @param string $query
     *
     * @return bool|mixed|object
     */
    public function getWeeklyReport($query)
    {
        return $this->get('weekly', $query);
    }

    /**
     * Helper for client get command.
     *
     * @param string $endpoint
     * @param array $query
     *
     * @return bool|mixed|object
     */
    private function GET($endpoint, $query = array())
    {
        try {
            $response = $this->client->get($endpoint, ['query' => $query]);

            return $this->checkResponse($response);
        } catch (ClientException $e) {
            return (object) [
                'success' => false,
                'message' => $e->getMessage(),
            ];
        }
    }

    /**
     * Helper for client post command.
     *
     * @param string $endpoint
     * @param array $query
     *
     * @return bool|mixed|object
     */
    private function POST($endpoint, $query = array())
    {
        try {
            $response = $this->client->post($endpoint, ['query' => $query]);

            return $this->checkResponse($response);
        } catch (ClientException $e) {
            return (object) [
                'success' => false,
                'message' => $e->getMessage(),
            ];
        }
    }

    /**
     * Helper for client put command.
     *
     * @param string $endpoint
     * @param array $query
     *
     * @return bool|mixed|object
     */
    private function PUT($endpoint, $query = array())
    {
        try {
            $response = $this->client->put($endpoint, ['query' => $query]);

            return $this->checkResponse($response);
        } catch (ClientException $e) {
            return (object) [
                'success' => false,
                'message' => $e->getMessage(),
            ];
        }
    }

    /**
     * Helper for client delete command.
     *
     * @param string $endpoint
     * @param array $query
     *
     * @return bool|mixed|object
     */
    private function DELETE($endpoint, $query = array())
    {
        try {
            $response = $this->client->delete($endpoint, ['query' => $query]);

            return $this->checkResponse($response);
        } catch (ClientException $e) {
            return (object) [
                'success' => false,
                'message' => $e->getMessage(),
            ];
        }
    }

    /**
     * Helper for checking http response.
     *
     * @param \Psr\Http\Message\ResponseInterface $response
     *
     * @return bool|mixed
     */
    private function checkResponse($response)
    {
        if ($response->getStatusCode() == 200) {
            $data = json_decode($response->getBody());
            if (is_object($data) && isset($data->data)) {
                $data = $data->data;
            }

            return $data;
        }

        return false;
    }
}
