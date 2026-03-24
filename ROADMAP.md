# TeamIO Development Roadmap

## Current Status

The core features of the TeamIO sports league management platform are implemented:

### Completed Features

| Feature | Backend | Frontend | Notes |
|---------|:-------:|:--------:|-------|
| Authentication | ✅ | ✅ | JWT tokens, login, registration |
| User Management | ✅ | ✅ | List, edit, deactivate/reactivate users |
| Leagues CRUD | ✅ | ✅ | Create, edit, delete leagues |
| Teams CRUD | ✅ | ✅ | Team management with colors |
| Field Management | ✅ | ✅ | Fields with amenities, availability |
| Player Rosters | ✅ | ✅ | Team roster management |
| Draft System | ✅ | ✅ | Real-time drafts with WebSocket |
| Calendar Subscriptions | ✅ | ✅ | iCal feed generation |
| Registrations | ✅ | ✅ | Registration workflow |
| Schedule/Events | ✅ | ✅ | Game and practice scheduling |
| Dashboard Navigation | - | ✅ | Sidebar and breadcrumbs |
| Settings | ✅ | ✅ | Persistent user preferences |
| Registration Forms | ✅ | ✅ | Configurable form builder + templates |
| User Invites | ✅ | ✅ | Email invitations with token-based flow |
| Game Scoring | ✅ | ✅ | Score entry, standings calculations |
| Reports & Analytics | ✅ | ✅ | Standings, results, event/registration stats |
| Mobile Responsiveness | - | ✅ | Scroll tables, responsive grids, mobile-first |
| Testing | - | ✅ | 32 unit + 27 E2E tests (Vitest + Playwright) |
| OrbStack Deployment | ✅ | ✅ | Production Docker build with nginx proxy |
| Invite Acceptance | ✅ | ✅ | /invite/:token page with account creation |
| Notification Center | - | ✅ | Bell icon popover with unread badges |
| Player Stats | ✅ | ✅ | Stat types, leaderboards, player season stats |
| Messaging | ✅ | ✅ | Inbox, conversations, compose, mark-as-read |
| Audit Logging | ✅ | ✅ | Track admin actions with filtering |
| PWA Support | - | ✅ | Web manifest, service worker, installable app |
| Dark Mode | - | ✅ | Light/dark/system theme from user settings |
| Dashboard Home | ✅ | ✅ | Live stats, standings, quick actions (no mock data) |
| User Profile | ✅ | ✅ | Edit info, change password, account details |
| Photo Gallery | ✅ | ✅ | Upload, grid view, album filtering, cloud storage abstraction |
| CSV Data Export | - | ✅ | Export standings, users, events, registrations to CSV |
| Season Management | ✅ | ✅ | Season list, status filtering, stats cards |
| API Documentation | ✅ | - | Swagger UI at /swagger-ui with OpenAPI spec |
| Payment Processing | ✅ | ✅ | Abstract provider: Stripe, PayPal, Square, Manual/Cash |
| Coach Portal | ✅ | ✅ | Team roster, events, results, certification info |
| Parent Portal | ✅ | ✅ | Player management, registrations, payments, waivers |
| Role-Based Sidebar | - | ✅ | Coach/Parent/Admin sections based on user role |
| RSVP/Availability | ✅ | ✅ | Parents RSVP yes/no/maybe for events |
| Volunteer Duties | ✅ | ✅ | Snack duty, scorekeeper, field setup assignments |
| Attendance Tracking | ✅ | ✅ | Coaches mark present/absent/late/excused |
| Event Detail Page | ✅ | ✅ | Full event view with RSVP, duties, attendance tabs |
| Game Day Mode | ✅ | ✅ | Mobile-friendly timer, one-tap attendance, score |
| Weather Broadcasts | ✅ | ✅ | Emergency cancellations and schedule change alerts |
| Map Directions | ✅ | ✅ | Google Maps links from field locations |
| Global Search | - | ✅ | Cmd+K search across users, seasons, events |
| Print Views | - | ✅ | Print-friendly output for reports and rosters |
| Multi-Tenant Isolation | ✅ | ✅ | Subdomain routing, OrgContext middleware, org-scoped queries |
| Inter-League Events | ✅ | ✅ | External org linking with search + manual fallback |
| Extended Event Types | ✅ | ✅ | Team meetings, parent meetings, parties, fundraisers |
| Parent Event Creation | ✅ | ✅ | Parents can create social events for their child's team |
| Tournament Brackets | ✅ | ✅ | Single elimination with seeding, byes, auto-advancement |
| Public Org Pages | ✅ | ✅ | Public landing page at org subdomain with schedule/registration |
| CI/CD Pipeline | ✅ | - | GitHub Actions for tests, lint, Docker image builds |
| Email Notifications | ✅ | - | SMTP queue with templates, auto-reminders, background worker |
| Season Cloning | ✅ | - | Clone season structure (teams, divisions, forms) for new year |
| Stripe Connect | ✅ | ✅ | Managed payments with 2% platform fee, Express onboarding |
| Stripe-Backed Pricing | ✅ | ✅ | Dynamic pricing from Stripe, 30-min cache, fallback defaults |
| Field Rental Invoicing | ✅ | ✅ | Generate/send/void invoices via Stripe Invoice API |
| Auto Rental Charges | ✅ | - | Auto-create charges when events booked with fee schedules |
| Payment → Registration Sync | ✅ | - | Auto-update registration payment_status on payment completion |
| Dispute/Chargeback Handling | ✅ | - | Webhook for disputes, admin email notifications, status tracking |
| System Admin Portal | ✅ | ✅ | Full operational dashboard (see below) |

---

## System Admin Portal (Complete)

Internal admin portal at `/system-admin` for `@getteamio.com` users only.

### Phase 1: Organization Management & Promo Codes ✅

| Feature | Backend | Frontend | Notes |
|---------|:-------:|:--------:|-------|
| System admin route guard | ✅ | ✅ | Only `@getteamio.com` users with `admin` role |
| Organization list | ✅ | ✅ | Search, filter by plan/status, pagination |
| Org detail view | ✅ | ✅ | Members, activity stats, plan/trial override |
| Manual plan override | ✅ | ✅ | Upgrade/downgrade any org, bypass Stripe |
| Impersonate org dashboard | ✅ | ✅ | View any org's dashboard via ?admin_view |
| Promo code CRUD | ✅ | ✅ | %, fixed $, free months, trial extension |
| Promo code redemption history | ✅ | ✅ | View redemptions per code |
| Email queue dashboard | ✅ | ✅ | Stats, failed emails table, per-row retry |

### Phase 2: User Management & Analytics ✅

| Feature | Backend | Frontend | Notes |
|---------|:-------:|:--------:|-------|
| User list (cross-org) | ✅ | ✅ | Search by name/email, filter by role |
| Password reset on behalf | ✅ | ✅ | Generates temp password, emails user |
| Email verification override | ✅ | ✅ | Mark user verified without email |
| Revenue dashboard | ✅ | ✅ | MRR from Stripe, plan distribution donut |
| Signup funnel | ✅ | ✅ | Registered → Active → League → Events → Paid |
| Signups trend chart | ✅ | ✅ | 30-day line chart with recharts |

### Phase 3: Communication & System Health ✅

| Feature | Backend | Frontend | Notes |
|---------|:-------:|:--------:|-------|
| System announcements | ✅ | ✅ | Dismissible banners on all dashboards |
| Broadcast email | ✅ | ✅ | Email org admins, filter by plan tier |
| System health dashboard | ✅ | ✅ | Email queue, registrations, events, seasons |
| Audit log viewer | ✅ | ✅ | Cross-org audit trail with action/resource filters |
| Quick actions | - | ✅ | Promo codes, Stripe, Sentry links |

---

## Payment & Billing System

| Feature | Status | Notes |
|---------|--------|-------|
| Manual/Cash payments | ✅ | Default provider, admin marks complete |
| Stripe (BYOK) | ✅ | League provides own API key, direct payment intents |
| TeamIO Managed Payments | ✅ | Stripe Connect Express, 2% platform fee |
| Connect onboarding | ✅ | Hosted onboarding flow, webhook completion |
| Field rental fee schedules | ✅ | Hourly/daily/flat/seasonal, light surcharge, non-resident markup |
| Auto charge on booking | ✅ | Charges created when events booked with fields |
| Invoice generation | ✅ | Bundle charges into invoices, draft → send → paid |
| Stripe Invoice API | ✅ | Auto-send via Stripe, hosted payment page |
| Invoice webhooks | ✅ | invoice.paid, invoice.payment_failed auto-sync |
| Dispute handling | ✅ | charge.dispute.created/closed, admin email alerts |
| Registration payment sync | ✅ | Auto-update payment_status on completion |
| PayPal | ⚠️ | Placeholder — needs REST SDK integration |
| Square | ⚠️ | Placeholder — needs SDK integration |

---

## Multi-Tenant Organization Isolation (Implemented)

Subdomain-based multi-tenancy with full org isolation:

| Layer | Implementation | Status |
|-------|---------------|--------|
| Org Slugs | `organizations.slug` column, auto-generated, unique | ✅ |
| JWT Claims | `org_id` in token, set to primary org on login | ✅ |
| TenantContext Middleware | `OrgContext` / `OptionalOrgContext` extractors | ✅ |
| List Endpoint Isolation | All list endpoints filter by org (join-based for transitive resources) | ✅ |
| GET-by-ID Isolation | All GET endpoints verify resource belongs to user's org (returns 404) | ✅ |
| Mutation Isolation | All update/delete endpoints verify resource org before modifying | ✅ |
| Org Resolution Methods | `get_team_org_id`, `get_player_org_id`, etc. on AuthorizationService | ✅ |
| Performance Cache | DashMap-based in-memory cache (60s TTL) for org lookups + membership | ✅ |
| Nginx Subdomain Routing | `*.getteamio.com` → `X-Org-Slug` header extraction | ✅ |
| Frontend API Client | Auto-sends `X-Org-Id` or `X-Org-Slug` on every request | ✅ |
| Subdomain Detection | `getOrgSlugFromHostname()` utility | ✅ |
| OrgSwitcher | Redirects to new subdomain when switching orgs | ✅ |
| Subdomain Guard | `ProtectedRoute` blocks access to wrong org, shows org links | ✅ |
| CORS | Configurable via `CORS_ORIGIN` env var | ✅ |
| Org Admin Permissions | Org admins can manage their own org (not just system admins) | ✅ |
| Workflow Auth | All workflow handlers secured with RequireAdmin/RequireCoach | ✅ |
| Cross-Org Tests | Integration test suite validating isolation | ✅ |
| Inter-League Events | `external_organization_id` FK + org search + manual fallback | ✅ |

### Deployment Requirements
- Wildcard DNS: `*.getteamio.com` → application server
- Wildcard SSL cert (Let's Encrypt or ACM)
- Set `CORS_ORIGIN` env var in production (e.g., `https://*.getteamio.com`)

---

## Technical Debt

- ~~CSS Warning~~ - Fixed (moved @import before @tailwind)
- Browserslist Update - Run `npx update-browserslist-db@latest`
- Type Improvements - Add stricter TypeScript types for API responses
- Stripe Webhook Events - Register: `charge.dispute.created`, `charge.dispute.closed`, `invoice.paid`, `invoice.payment_failed`, `account.updated` in Stripe Dashboard

---

## Future Considerations

- ~~Multi-organization support~~ - Done (subdomain-based multi-tenancy with full isolation)
- ~~Payment processing~~ - Done (Stripe BYOK + Managed with Connect)
- ~~Photo galleries~~ - Done (abstract storage: local, S3, GCS, Azure)
- ~~API documentation~~ - Done (Swagger UI at /swagger-ui)
- ~~Dark mode~~ - Done (Light/dark/system theme)
- ~~Dashboard home improvements~~ - Done (stats, standings, quick actions)
- **Feature flags** - Toggle features per org for gradual rollouts
- **PayPal/Square** - Real SDK integrations for additional payment providers
- **Sentry integration** - Error summary in system admin dashboard
- **E2E test coverage** - Tests for system admin, payments, invoicing
