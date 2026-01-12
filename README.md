# SaaS Manager (Work in Progress)

This is an application I've built to try out and showcase. It's built with Ruby on Rails for the backend, and a Vue application for the frontend.

## Tech Stack
### Backend
* Framework - Ruby on Rails
* Database - PostgreSQL
* Authentication - Devise with JWT (JSON Web Tokens)
* Security - Scoped data isolation (Multi-tenancy)
* Well-tested - RSpec with focus on integrationtests

**Features (Currently)**
* JWT Auth
* Multi-tenant architecture: Users are connected to an organization. The API makes sure via current_organization, that you can only edit and see data that is attached to that organization.
* Subscription Management: API-endpoints for managing subscriptions (CRUD), including relations to Vendors

## Roadmap
* [x] JWT Auth & API Scoping
* [ ] Vue3 Frontend Application with a nice dashboard
* [ ] Visualisation with graphs (Possibly Chart.js?)
* [ ] Notifications befroe renewal dates
