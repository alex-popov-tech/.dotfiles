# About

PHP class to connect with the Toggl API.

This was coded on an early http://morningtrain.dk

# Installation

It can be installed with composer

```
composer require morningtrain/toggl-api
```

# Dependencies

It depends on guzzlehttp/guzzle ver.6.

Guzzle can be added with the following composer snippet:
(or automatically when installing through composer)

```
{
    "require": {
        "guzzlehttp/guzzle": "^6.0"
    }
}
```

# Changelog
### 30/06/17 
- Changed function name from getDashboadForWorkspace to getDashboardForWorkspace, if your system is using getDashboadForWorkspace please change it to getDashboardForWorkspace.

# Examples

For details about the different objects required in the Toggl Api, take a look at their documentation:
https://github.com/toggl/toggl_api_docs

## Toggl API

### Initialization

```
$toggl = new MorningTrain\TogglApi\TogglApi('my-api-token');
```

### Get available endpoints

```
$toggl->getAvailableEndpoints();
```

### Clients

https://github.com/toggl/toggl_api_docs/blob/master/chapters/clients.md

#### Creating a client

```
$toggl->createClient($clientObject);
```

#### Updating a client

```
$toggl->updateClient($clientId, $clientObject);
```

#### Deleting a client

```
$toggl->deleteClient($clientId);
```

#### Get all clients

```
$toggl->getClients();
```

#### Get all projects for a client

```
$toggl->getClientProjects($clientId);
```

#### Get all active projects for a client

```
$toggl->getActiveClientProjects($clientId);
```

#### Get all inactive projects for a client

```
$toggl->getInactiveClientProjects($clientId);
```

#### Get both active and inactive projects for a client

```
$toggl->getAllClientProjects($clientId);
```

#### Get client by id

```
$toggl->getClientById($clientId);
```

### Project users

https://github.com/toggl/toggl_api_docs/blob/master/chapters/project_users.md

#### Create project user

```
$toggl->createProjectUser($projectUserObject);
```

#### Create project users

```
$toggl->createProjectUsers($projectUserObject);
```

#### Update project user

```
$toggl->updateProjectUser($projectUserId, $projectUserObject);
```

#### Update project users

```
$toggl->updateProjectUsers($projectUserIds, $projectUserObject);
```

#### Create project users

```
$toggl->deleteProjectUser($projectUserId);
```

#### Create project users

```
$toggl->deleteProjectUsers($projectUserIds);
```

### Projects
https://github.com/toggl/toggl_api_docs/blob/master/chapters/projects.md

#### Create project

```
$toggl->createProject($projectObject);
```

#### Update project

```
$toggl->updateProject($projectId, $projectObject);
```

#### Delete project

```
$toggl->deleteProject($projectId);
```

#### Delete projects

```
$toggl->deleteProjects($projectIds);
```

#### Get users for project

```
$toggl->getProjectUserRelations($projectId);
```

#### Get project tasks

```
$toggl->getProjectTasks($projectId);
```

#### Get project by ID

```
$toggl->getProject($projectId);
```

### Dashboard
https://github.com/toggl/toggl_api_docs/blob/master/chapters/dashboard.md

#### Get dashboard for workspace

```
$toggl->getDashboardForWorkspace($workspaceId);
```

### Users
https://github.com/toggl/toggl_api_docs/blob/master/chapters/users.md

#### Get me
$related defaults to false. Set it to true, to get related data
```
$toggl->getMe($related);
```

#### Update me
```
$toggl->updateMe($userObject);
```

#### Sign up
```
$toggl->signup($userObject);
```

#### Reset API Token
```
$toggl->resetApiToken();
```

### Workspaces
https://github.com/toggl/toggl_api_docs/blob/master/chapters/workspaces.md

#### Get workspaces
```
$toggl->getWorkspaces();
```

#### Get workspace by ID
```
$toggl->getWorkspace($workspaceId);
```

#### Update workspace
```
$toggl->updateWorkspace($workspaceId, $workspaceObject);
```

#### Get workspace users
```
$toggl->getWorkspaceUsers($workspaceId);
```

#### Get workspace clients
```
$toggl->getWorkspaceClients($workspaceId);
```

#### Get workspace projects
```
$toggl->getWorkspaceProjects($workspaceId);
```

#### Get workspace tasks
```
$toggl->getWorkspaceTasks($workspaceId);
```

#### Get workspace tags
```
$toggl->getWorkspaceTags($workspaceId);
```

### Workspace users
https://github.com/toggl/toggl_api_docs/blob/master/chapters/workspace_users.md

#### Invite users to workspace
```
$toggl->inviteUsersToWorkspace($workspaceId, $emails);
```

#### Update workspace user
```
$toggl->updateWorkspaceUser($workspaceUserId, $userObject);
```

#### Delete workspace user
```
$toggl->deleteWorkspaceUser($workspaceUserId);
```

#### Get workspace users for workspace
```
$toggl->getWorkspaceUserRelations($workspaceId);
```

### Tags
https://github.com/toggl/toggl_api_docs/blob/master/chapters/tags.md

#### Create tag
```
$toggl->createTag($tagObject);
```

#### Update tag
```
$toggl->updateTag($tagId, $tagObject);
```

#### Delete tag
```
$toggl->deleteTag($tagId);
```

### Tasks
https://github.com/toggl/toggl_api_docs/blob/master/chapters/tags.md

#### Get task
```
$toggl->getTask($taskId);
```

#### Create task
```
$toggl->createTask($taskObject);
```

#### Update task
```
$toggl->updateTask($taskId, $taskObject);
```

#### Update tasks
```
$toggl->updateTasks($taskId, $taskObject);
```

#### Delete task
```
$toggl->deleteTask($taskId);
```

#### Delete tasks
```
$toggl->deleteTasks($taskIds);
```

### Time entries
https://github.com/toggl/toggl_api_docs/blob/master/chapters/time_entries.md

#### Create time entry
```
$toggl->createTimeEntry($timeEntryObject);
```

#### Start time entry
```
$toggl->startTimeEntry($timeEntryObject);
```

#### Stop time entry
```
$toggl->stopTimeEntry($timeEntryIds);
```

#### Get time entry
```
$toggl->getTimeEntry($timeEntryIds);
```

#### Get running time entry
```
$toggl->getRunningTimeEntry();
```

#### Get time entries
```
$toggl->getTimeEntries();
```

#### Get time entries in range
```
$toggl->getTimeEntriesInRange($start, $end);
```

#### Update tags for time entries
```
$toggl->updateTagsForTimeEntries($timeEntryIds, $timeEntryObject);
```

#### Update time entry
```
$toggl->updateTimeEntry($timeEntryIds, $timeEntryObject);
```

#### Delete time entry
```
$toggl->deleteTimeEntry($timeEntryIds);
```

## Reports API
https://github.com/toggl/toggl_api_docs/blob/master/reports.md

### Initialization

```
$toggl = new MorningTrain\TogglApi\TogglReportsApi('my-api-token');
```

### Get available endpoints

```
$toggl->getAvailableEndpoints();
```

### Methods

#### Get project report
```
$toggl->getProjectReport($query);
```

#### Get summary report
```
$toggl->getSummaryReport($query);
```

#### Get details report
```
$toggl->getDetailsReport($query);
```

#### Get weekly report
```
$toggl->getWeeklyReport($query);
```
