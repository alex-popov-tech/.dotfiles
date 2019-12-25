# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.1] - 2018-03-19

### Changed
* Changed version constrain for php-http/httplug to continue supporting 1.x.

### Fixed
* Fixed fatal error by missing php-http/client-common dependency.

## [0.1.0] - 2018-03-18

### Added
* API v2 support for Client Contacts, Clients, Company, Invoice Messages, Invoice Payments, Invoices, Invoice Item Categories, Estimate Messages, Estimates, Estimate Item Categories, Expenses, Expense Categories, Tasks, Time Entries, Project User Assignments, Project Task Assignments, Projects, Roles, User Project Assignments, and Users.
* `AutoPagingIterator` to be used for list requests with automatic pagination.

[Unreleased]: https://github.com/wearerequired/harvest-api-php-client/compare/0.1.1...HEAD
[0.1.1]: https://github.com/wearerequired/harvest-api-php-client/compare/0.1.0...0.1.1
[0.1.0]: https://github.com/wearerequired/harvest-api-php-client/compare/75bc0967f...0.1.0
