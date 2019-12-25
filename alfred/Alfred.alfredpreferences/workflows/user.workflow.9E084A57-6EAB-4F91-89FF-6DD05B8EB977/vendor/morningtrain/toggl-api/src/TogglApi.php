<?php

namespace MorningTrain\TogglApi;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;

/**
 * Wrapper for the Toggl Api.
 *
 * @see https://github.com/toggl/toggl_api_docs/blob/master/toggl_api.md
 */
class TogglApi
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
     * TogglApi constructor.
     *
     * @param string $apiToken
     */
    public function __construct($apiToken)
    {
        $this->apiToken = $apiToken;
        $this->client = new Client([
            'base_uri' => 'https://www.toggl.com/api/v8/',
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
     * Create client.
     *
     * @param array $client
     *
     * Client has the following properties
     *
     * - name: The name of the client (string, required, unique in workspace)
     * - wid: workspace ID, where the client will be used (integer, required)
     * - notes: Notes for the client (string, not required)
     * - hrate: The hourly rate for this client (float, not required, available only for pro workspaces)
     * - cur: The name of the client's currency (string, not required, available only for pro workspaces)
     * - at: timestamp that is sent in the response, indicates the time client was last updated
     *
     * @return bool|mixed|object
     *
     * @see https://github.com/toggl/toggl_api_docs/blob/master/chapters/clients.md
     */
    public function createClient($client)
    {
        return $this->POST('clients', ['client' => $client]);
    }

    /**
     * Update client.
     *
     * @param int   $clientId
     * @param array $client
     *
     * @return bool|mixed|object
     */
    public function updateClient($clientId, $client)
    {
        return $this->PUT('clients/'.$clientId, ['client' => $client]);
    }

    /**
     * Delete client.
     *
     * @param int $clientId
     *
     * @return bool|mixed|object
     */
    public function deleteClient($clientId)
    {
        return $this->DELETE('clients/'.$clientId);
    }

    /**
     * Get clients.
     *
     * @return bool|mixed|object
     */
    public function getClients()
    {
        return $this->GET('clients');
    }

    /**
     * Get client projects.
     *
     * @param int $clientId
     *
     * @return bool|mixed|object
     */
    public function getClientProjects($clientId)
    {
        return $this->GET('clients/'.$clientId.'/projects');
    }

    /**
     * Get active client projects.
     *
     * @param int $clientId
     *
     * @return bool|mixed|object
     */
    public function getActiveClientProjects($clientId)
    {
        return $this->GET('clients/'.$clientId.'/projects?active=true');
    }

    /**
     * Get inactive client projects.
     *
     * @param int $clientId
     *
     * @return bool|mixed|object
     */
    public function getInactiveClientProjects($clientId)
    {
        return $this->GET('clients/'.$clientId.'/projects?active=false');
    }

    /**
     * Get all client projects.
     *
     * @param int $clientId
     *
     * @return bool|mixed|object
     */
    public function getAllClientProjects($clientId)
    {
        return $this->GET('clients/'.$clientId.'/projects?active=both');
    }

    /**
     * Get client by ID.
     *
     * @param int $clientId
     *
     * @return bool|mixed|object
     */
    public function getClientById($clientId)
    {
        return $this->GET('clients/'.$clientId);
    }

    /**
     * Create project user relation.
     *
     * @param array $user
     *
     * Project user has the following properties
     *
     * - pid: project ID (integer, required)
     * - uid: user ID, who is added to the project (integer, required)
     * - wid: workspace ID, where the project belongs to (integer, not-required, project's workspace id is used)
     * - manager: admin rights for this project (boolean, default false)
     * - rate: hourly rate for the project user (float, not-required, only for pro workspaces) in the currency of the project's client or in workspace default currency.
     * - at: timestamp that is sent in the response, indicates when the project user was last updated
     *
     * Workspace id (wid), project id (pid) and user id (uid) can't be changed on update.
     *
     * @return bool|mixed|object
     *
     * @see https://github.com/toggl/toggl_api_docs/blob/master/chapters/project_users.md
     */
    public function createProjectUser($user)
    {
        return $this->POST('project_users', ['project_user' => $user]);
    }

    /**
     * Create multiple project user relations.
     *
     * @param array $user
     *
     * @return bool|mixed|object
     */
    public function createProjectUsers($user)
    {
        return $this->POST('project_users', ['project_user' => $user]);
    }

    /**
     * Update project user relations.
     *
     * @param int   $projectUserId
     * @param array $user
     *
     * @return bool|mixed|object
     */
    public function updateProjectUser($projectUserId, $user)
    {
        return $this->PUT('project_users/'.$projectUserId, ['project_user' => $user]);
    }

    /**
     * Update multiple project user relations.
     *
     * @param array $projectUserIds
     * @param array $user
     *
     * @return bool|mixed|object
     */
    public function updateProjectUsers($projectUserIds, $user)
    {
        return $this->PUT('project_users/'.implode(',', $projectUserIds), ['project_user' => $user]);
    }

    /**
     * Delete project user relation.
     *
     * @param int $projectUserId
     *
     * @return bool|mixed|object
     */
    public function deleteProjectUser($projectUserId)
    {
        return $this->DELETE('project_users/'.$projectUserId);
    }

    /**
     * Delete multiple project user relations.
     *
     * @param array $projectUserIds
     *
     * @return bool|mixed|object
     */
    public function deleteProjectUsers($projectUserIds)
    {
        return $this->DELETE('project_users/'.implode(',', $projectUserIds));
    }

    /**
     * Create Project.
     *
     * @param array $project
     *
     * Project has the following properties:
     * - name: The name of the project (string, required, unique for client and workspace)
     * - wid: workspace ID, where the project will be saved (integer, required)
     * - cid: client ID (integer, not required)
     * - active: whether the project is archived or not (boolean, by default true)
     * - is_private: whether project is accessible for only project users or for all workspace users (boolean, default true)
     * - template: whether the project can be used as a template (boolean, not required)
     * - template_id: id of the template project used on current project's creation
     * - billable: whether the project is billable or not (boolean, default true, available only for pro workspaces)
     * - auto_estimates: whether the estimated hours is calculated based on task estimations or is fixed manually (boolean, default false, not required, premium functionality)
     * - estimated_hours: if auto_estimates is true then the sum of task estimations is returned, otherwise user inserted hours (integer, not required, premium functionality)
     * - at: timestamp that is sent in the response for PUT, indicates the time task was last updated (read-only)
     * - color: id of the color selected for the project
     * - rate: hourly rate of the project (float, not required, premium functionality)
     * - created_at: timestamp indicating when the project was created (UTC time), read-only
     *
     * @return bool|mixed|object
     *
     * @see https://github.com/toggl/toggl_api_docs/blob/master/chapters/projects.md
     */
    public function createProject($project)
    {
        return $this->POST('projects', ['project' => $project]);
    }

    /**
     * Update a project.
     *
     * @param int   $projectId
     * @param array $project
     *
     * @return bool|mixed|object
     */
    public function updateProject($projectId, $project)
    {
        return $this->PUT('projects/'.$projectId, ['project' => $project]);
    }

    /**
     * Delete project.
     *
     * @param int $projectId
     *
     * @return bool|mixed|object
     */
    public function deleteProject($projectId)
    {
        return $this->DELETE('projects/'.$projectId);
    }

    /**
     * Delete multiple projects.
     *
     * @param array $projectIds
     *
     * @return bool|mixed|object
     */
    public function deleteProjects($projectIds)
    {
        return $this->DELETE('projects/'.implode(',', $projectIds));
    }

    /**
     * Get project user relations.
     *
     * @param int $projectId
     *
     * @return bool|mixed|object
     */
    public function getProjectUserRelations($projectId)
    {
        return $this->GET('projects/'.$projectId.'/project_users');
    }

    /**
     * Get project tasks.
     *
     * @param int $projectId
     *
     * @return bool|mixed|object
     */
    public function getProjectTasks($projectId)
    {
        return $this->GET('projects/'.$projectId.'/tasks');
    }

    /**
     * Get project.
     *
     * @param int $projectId
     *
     * @return bool|mixed|object
     */
    public function getProject($projectId)
    {
        return $this->GET('projects/'.$projectId);
    }

    /**
     * Get dashboard for workspace.
     *
     * @param int $workspaceId
     *
     * @return bool|mixed|object
     *
     * Dashboard's main purpose is to give an overview of what users in the workspace are doing and have been doing.
     * Dashboard request returns two objects:
     * - `activity`: Activity
     * - `most_active_user`: Most active user
     *
     * The activity object holds the data of 10 latest actions in the workspace.
     *Activity object has the following properties
     *
     * - user_id: user ID
     * - project_id: project ID (ID is 0 if time entry doesn'y have project connected to it)
     * - duration: time entry duration in seconds. If the time entry is currently running, the duration attribute contains a negative value, denoting the start of the time entry in seconds since epoch (Jan 1 1970). The correct duration can be calculated as current_time + duration, where current_time is the current time in seconds since epoch.
     * - description: (Description property is not present if time entry description is empty)
     * - stop: time entry stop time (ISO 8601 date and time. Stop property is not present when time entry is still running)
     * - tid: task id, if applicable
     *
     * The most active user object holds the data of the top 5 users who have tracked the most time during last 7 days.
     * Most active user object has the following properties
     * - user_id: user ID
     * - duration: Sum of time entry durations that have been created during last 7 days
     *
     * @see https://github.com/toggl/toggl_api_docs/blob/master/chapters/dashboard.md)
     */
    public function getDashboardForWorkspace($workspaceId)
    {
        return $this->GET('dashboard/'.$workspaceId);
    }

    /**
     * Get current user.
     *
     * @param bool $related
     *
     * @return bool|mixed|object
     *
     * User has the following properties:
     * - api_token: (string)
     * - default_wid: default workspace id (integer)
     * - email: (string)
     * - jquery_timeofday_format: (string)
     * - jquery_date_format:(string)
     * - timeofday_format: (string)
     * - date_format: (string)
     * - store_start_and_stop_time: whether start and stop time are saved on time entry (boolean)
     * - beginning_of_week: (integer 0-6, Sunday=0)
     * - language: user's language (string)
     * - image_url: url with the user's profile picture(string)
     * - sidebar_piechart: should a piechart be shown on the sidebar (boolean)
     * - at: timestamp of last changes
     * - new_blog_post: an object with toggl blog post title and link
     * - send_product_emails: (boolean) Toggl can send newsletters over e-mail to the user
     * - send_weekly_report: (boolean) if user receives weekly report
     * - send_timer_notifications: (boolean) email user about long-running (more than 8 hours) tasks
     * - openid_enabled: (boolean) google signin enabled
     * - timezone: (string) timezone user has set on the "My profile" page ( IANA TZ timezones )
     *
     * @see https://github.com/toggl/toggl_api_docs/blob/master/chapters/users.md
     */
    public function getMe($related = false)
    {
        return $this->GET('me', ['with_related_data' => $related]);
    }

    /**
     * Update current user.
     *
     * @param array $user
     *
     * @return bool|mixed|object
     */
    public function updateMe($user)
    {
        return $this->PUT('me', ['user' => $user]);
    }

    /**
     * Signup user.
     *
     * @param array $user
     *
     * @return bool|mixed|object
     */
    public function signup($user)
    {
        return $this->POST('signups', ['user' => $user]);
    }

    /**
     * Reset API Token for current user.
     *
     * @return bool|mixed|object
     */
    public function resetApiToken()
    {
        return $this->POST('reset_token');
    }

    /**
     * Get available workspaces for the user.
     *
     *  Workspace has the following properties:
     * - name: the name of the workspace (string)
     * - premium: If it's a pro workspace or not. Shows if someone is paying for the workspace or not (boolean)
     * - admin: shows whether currently requesting user has admin access to the workspace (boolean)
     * - default_hourly_rate: default hourly rate for workspace, won't be shown to non-admins if the only_admins_see_billable_rates flag is set to true (float)
     * - default_currency: default currency for workspace (string)
     * - only_admins_may_create_projects: whether only the admins can create projects or everybody (boolean)
     * - only_admins_see_billable_rates: whether only the admins can see billable rates or everybody (boolean)
     * - rounding: type of rounding (integer)
     * - rounding_minutes: round up to nearest minute (integer)
     * - at: timestamp that indicates the time workspace was last updated
     * - logo_url: URL pointing to the logo (if set, otherwise omited) (string)
     *
     * @return bool|mixed|object
     *
     * @see https://github.com/toggl/toggl_api_docs/blob/master/chapters/workspaces.md
     */
    public function getWorkspaces()
    {
        return $this->GET('workspaces');
    }

    /**
     * Get single workspace.
     *
     * @param int $wid
     *
     * @return bool|mixed|object
     */
    public function getWorkspace($wid)
    {
        return $this->GET('workspaces/'.$wid);
    }

    /**
     * Update workspace.
     *
     * @param int   $wid
     * @param array $workspace
     *
     * @return bool|mixed|object
     */
    public function updateWorkspace($wid, $workspace)
    {
        return $this->PUT('workspaces/'.$wid, ['workspace' => $workspace]);
    }

    /**
     * Get workspaces users.
     *
     * @param int $wid
     *
     * @return bool|mixed|object
     */
    public function getWorkspaceUsers($wid)
    {
        return $this->GET('workspaces/'.$wid.'/users');
    }

    /**
     * Get workspace clients.
     *
     * @param int $wid
     *
     * @return bool|mixed|object
     */
    public function getWorkspaceClients($wid)
    {
        return $this->GET('workspaces/'.$wid.'/clients');
    }

    /**
     * Get workspace projects.
     *
     * @param int   $wid
     * @param array $options
     *
     * @return bool|mixed|object
     */
    public function getWorkspaceProjects($wid, $options = [])
    {
        return $this->GET('workspaces/'.$wid.'/projects', $options);
    }

    /**
     * Get workspace tasks.
     *
     * @param int   $wid
     * @param array $options
     *
     * @return bool|mixed|object
     */
    public function getWorkspaceTasks($wid, $options = [])
    {
        return $this->GET('workspaces/'.$wid.'/tasks', $options);
    }

    /**
     * Get workspace tags.
     *
     * @param int $wid
     *
     * @return bool|mixed|object
     */
    public function getWorkspaceTags($wid)
    {
        return $this->GET('workspaces/'.$wid.'/tags');
    }

    /**
     * Invite users to workspace.
     *
     * @param int    $wid
     * @param string $emails
     *
     * @return bool|mixed|object
     *
     */
    public function inviteUsersToWorkspace($wid, $emails)
    {
        return $this->POST('workspaces/'.$wid.'/invite', ['emails' => $emails]);
    }

    /**
     * Update workspace user.
     *
     * @param int   $workspaceUserId
     * @param array $user
     *
     * Workspace user has the following properties:
     * - id: workspace user id (integer)
     * - uid: user id of the workspace user (integer)
     * - admin: if user is workspace admin (boolean)
     * - active: if the workspace user has accepted the invitation to this workspace (boolean)
     * - invite_url: if user has not accepted the invitation the url for accepting his/her invitation is sent when the request is made by workspace_admin
     *
     * @return bool|mixed|object
     *
     * @see https://github.com/toggl/toggl_api_docs/blob/master/chapters/workspace_users.md
     */
    public function updateWorkspaceUser($workspaceUserId, $user)
    {
        return $this->PUT('workspace_users/'.$workspaceUserId, ['workspace_user' => $user]);
    }

    /**
     * Delete worksapce user.
     *
     * @param int $workspaceUserId
     *
     * @return bool|mixed|object
     */
    public function deleteWorkspaceUser($workspaceUserId)
    {
        return $this->DELETE('workspace_users/'.$workspaceUserId);
    }

    /**
     * Get worksapce user relations.
     *
     * @param int $wid
     *
     * @return bool|mixed|object
     */
    public function getWorkspaceUserRelations($wid)
    {
        return $this->GET('workspaces/'.$wid.'/workspace_users');
    }

    /**
     * Create tag.
     *
     * @param array $tag
     * Tag has the following properties
     * - name: The name of the tag (string, required, unique in workspace)
     * - wid: workspace ID, where the tag will be used (integer, required)
     *
     * @return bool|mixed|object
     *
     * @see https://github.com/toggl/toggl_api_docs/blob/master/chapters/tags.md
     */
    public function createTag($tag)
    {
        return $this->POST('tags', ['tag' => $tag]);
    }

    /**
     * Update tag.
     *
     * @param int   $tagId
     * @param array $tag
     *
     * @return bool|mixed|object
     */
    public function updateTag($tagId, $tag)
    {
        return $this->PUT('tags/'.$tagId, ['tag' => $tag]);
    }

    /**
     * Delete tag.
     *
     * @param int $tagId
     *
     * @return bool|mixed|object
     */
    public function deleteTag($tagId)
    {
        return $this->DELETE('tags/'.$tagId);
    }

    /*  TAGS (https://github.com/toggl/toggl_api_docs/blob/master/chapters/tags.md)





    */

    /**
     * Get task.
     *
     * Tasks are available only for pro workspaces.
     *
     * @param int $taskId
     *
     * @return bool|mixed|object
     * Task has the following properties:
     * - name: The name of the task (string, required, unique in project)
     * - pid: project ID for the task (integer, required)
     * - wid: workspace ID, where the task will be saved (integer, project's workspace id is used when not supplied)
     * - uid: user ID, to whom the task is assigned to (integer, not required)
     * - estimated_seconds: estimated duration of task in seconds (integer, not required)
     * - active: whether the task is done or not (boolean, by default true)
     * - at: timestamp that is sent in the response for PUT, indicates the time task was last updated
     * - tracked_seconds: total time tracked (in seconds) for the task
     *
     * Workspace id (wid) and project id (pid) can't be changed on update.
     *
     * @see https://github.com/toggl/toggl_api_docs/blob/master/chapters/tasks.md
     */
    public function getTask($taskId)
    {
        return $this->GET('tasks/'.$taskId);
    }

    /**
     * Create task.
     *
     * @param array $task
     *
     * @return bool|mixed|object
     */
    public function createTask($task)
    {
        return $this->POST('tasks', ['task' => $task]);
    }

    /**
     * Update task.
     *
     * @param int   $taskId
     * @param array $task
     *
     * @return bool|mixed|object
     */
    public function updateTask($taskId, $task)
    {
        return $this->PUT('tasks/'.$taskId, ['task' => $task]);
    }

    /**
     * Update multiple tasks.
     *
     * @param array $taskIds
     * @param array $task
     *
     * @return bool|mixed|object
     */
    public function updateTasks($taskIds, $task)
    {
        return $this->PUT('tasks/'.implode(',', $taskIds), ['task' => $task]);
    }

    /**
     * Delete task.
     *
     * @param int $taskId
     *
     * @return bool|mixed|object
     */
    public function deleteTask($taskId)
    {
        return $this->DELETE('tasks/'.$taskId);
    }

    /**
     * Delete multiple tasks.
     *
     * @param int $taskIds
     *
     * @return bool|mixed|object
     */
    public function deleteTasks($taskIds)
    {
        return $this->DELETE('tasks/'.implode(',', $taskIds));
    }

    /**     TIME ENTRIES ()


    */

    /**
     * Create time entry.
     *
     * The requests are scoped with the user whose API token is used. Only his/her time entries are updated, retrieved and created.
     *
     * @param array $entry
     * Time entry has the following properties
     * - description: (string, strongly suggested to be used)
     * - wid: workspace ID (integer, required if pid or tid not supplied)
     * - pid: project ID (integer, not required)
     * - tid: task ID (integer, not required)
     * - billable: (boolean, not required, default false, available for pro workspaces)
     * - start: time entry start time (string, required, ISO 8601 date and time)
     * - stop: time entry stop time (string, not required, ISO 8601 date and time)
     * - duration: time entry duration in seconds. If the time entry is currently running, the duration attribute contains a negative value, denoting the start of the time entry in seconds since epoch (Jan 1 1970). The correct duration can be calculated as current_time + duration, where current_time is the current time in seconds since epoch. (integer, required)
     * - created_with: the name of your client app (string, required)
     * - tags: a list of tag names (array of strings, not required)
     * - duronly: should Toggl show the start and stop time of this time entry? (boolean, not required)
     * - at: timestamp that is sent in the response, indicates the time item was last updated
     *
     * @return bool|mixed|object
     *
     * @see https://github.com/toggl/toggl_api_docs/blob/master/chapters/time_entries.md
     */
    public function createTimeEntry($entry)
    {
        return $this->POST('time_entries', ['time_entry' => $entry]);
    }

    /**
     * Start time entry.
     *
     * @param array $entry
     *
     * @return bool|mixed|object
     */
    public function startTimeEntry($entry)
    {
        return $this->POST('time_entries/start', ['time_entry' => $entry]);
    }

    /**
     * Stop time entry.
     *
     * @param int $timeEntryId
     *
     * @return bool|mixed|object
     */
    public function stopTimeEntry($timeEntryId)
    {
        return $this->PUT('time_entries/'.$timeEntryId.'/stop');
    }

    /**
     * Get time entry.
     *
     * @param int $timeEntryId
     *
     * @return bool|mixed|object
     */
    public function getTimeEntry($timeEntryId)
    {
        return $this->GET('time_entries/'.$timeEntryId);
    }

    /**
     * Get running time entry.
     *
     * @return bool|mixed|object
     */
    public function getRunningTimeEntry()
    {
        return $this->GET('time_entries/current');
    }

    /**
     * Get time entries.
     *
     * @return bool|mixed|object
     */
    public function getTimeEntries()
    {
        return $this->GET('time_entries');
    }

    /**
     * Get time entries in range.
     *
     * @param string $start ISO 8601 date and time string
     * @param string $end   ISO 8601 date and time string
     *
     * @return bool|mixed|object
     */
    public function getTimeEntriesInRange($start, $end)
    {
        return $this->GET('time_entries', ['start_date' => $start, 'end_date' => $end]);
    }

    /**
     * Update tags for time entries.
     *
     * @param array $timeEntryIds
     * @param array $entry
     *
     * @return bool|mixed|object
     */
    public function updateTagsForTimeEntries($timeEntryIds, $entry)
    {
        return $this->PUT('time_entries/'.implode(',', $timeEntryIds), ['time_entry' => $entry]);
    }

    /**
     * Update time entry.
     *
     * @param int   $timeEntryId
     * @param array $entry
     *
     * @return bool|mixed|object
     */
    public function updateTimeEntry($timeEntryId, $entry)
    {
        return $this->PUT('time_entries/'.$timeEntryId, ['time_entry' => $entry]);
    }

    /**
     * Delete time entry.
     *
     * @param int $timeEntryId
     *
     * @return bool|mixed|object
     */
    public function deleteTimeEntry($timeEntryId)
    {
        return $this->DELETE('time_entries/'.$timeEntryId);
    }

    /**
     * Helper for client get command.
     *
     * @param string $endpoint
     * @param array $body
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
                'message' => $e->getResponse()->getBody()->getContents(),
            ];
        }
    }

    /**
     * Wrapper for client post command.
     *
     * @param string $endpoint
     * @param array $body
     * @param array $query
     *
     * @return bool|mixed|object
     */
    private function POST($endpoint, $body = array(), $query = array())
    {
        try {
            $response = $this->client->post($endpoint, ['body' => json_encode($body), 'query' => $query]);

            return $this->checkResponse($response);
        } catch (ClientException $e) {
            return (object) [
                'success' => false,
                'message' => $e->getResponse()->getBody()->getContents(),
            ];
        }
    }

    /**
     * Helper for client put command.
     *
     * @param string $endpoint
     * @param array $body
     * @param array $query
     *
     * @return bool|mixed|object
     */
    private function PUT($endpoint, $body = array(), $query = array())
    {
        try {
            $response = $this->client->put($endpoint, ['body' => json_encode($body), 'query' => $query]);

            return $this->checkResponse($response);
        } catch (ClientException $e) {
            return (object) [
                'success' => false,
                'message' => $e->getResponse()->getBody()->getContents(),
            ];
        }
    }

    /**
     * Helper for client delete command.
     *
     * @param $endpoint
     * @param array $body
     * @param array $query
     *
     * @return bool|mixed|object
     */
    private function DELETE($endpoint, $body = array(), $query = array())
    {
        try {
            $response = $this->client->delete($endpoint, ['body' => json_encode($body), 'query' => $query]);

            return $this->checkResponse($response);
        } catch (ClientException $e) {
            return (object) [
                'success' => false,
                'message' => $e->getResponse()->getBody()->getContents(),
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
