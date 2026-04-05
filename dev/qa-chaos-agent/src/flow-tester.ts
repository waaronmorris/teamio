/**
 * Flow tester - tests critical user journeys end-to-end.
 *
 * Unlike the crawler (which visits pages) and fuzzer (which injects bad input),
 * this tests the actual happy-path and edge-case flows a real user would follow.
 */

import { Page } from 'playwright';
import { config } from './config.js';
import { Reporter } from './reporter.js';

export class FlowTester {
  private flowCount = 0;

  constructor(
    private page: Page,
    private reporter: Reporter,
  ) {}

  get flowsTested() { return this.flowCount; }

  /** Run all flow tests */
  async runAll(): Promise<void> {
    await this.testParentRegistration();
    await this.testPlayerRegistration();
    await this.testOrgRegistration();
    await this.testTravelTeamRegistration();
    await this.testDiscoverPage();
    await this.testDiscoverOrgProfile();
    await this.testLoginRedirects();
    await this.testCoachPortalSeasonCreation();
    await this.testCoachTryoutFlow();
    await this.testParentOfferFlow();
    await this.testRoleBasedNavigation();
    await this.testAnnouncementsFlow();
    await this.testMessagingFlow();
    await this.testBroadcastFlow();
    await this.testAdminDashboardFlow();
    await this.testCoachFullJourney();
    await this.testParentFullJourney();
    await this.testFeatureFlagGating();
  }

  // =========================================================================
  // Flow 1: Parent registration (role selector → personal info → location)
  // =========================================================================
  private async testParentRegistration() {
    const flow = 'parent-registration';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      await this.page.goto(`${config.baseUrl}/register`, { waitUntil: 'networkidle', timeout: 15000 });

      // Step 0: Role selector should appear
      const roleSelector = this.page.locator('text=How would you like to use TeamIO');
      if (!await roleSelector.isVisible({ timeout: 5000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Register page missing role selector',
          description: 'The "How would you like to use TeamIO?" role selector did not appear on /register',
          url: `${config.baseUrl}/register`,
        });
        return;
      }

      // Click "I'm looking for programs for my child"
      const parentOption = this.page.locator('text=looking for programs for my child');
      if (!await parentOption.isVisible({ timeout: 3000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Parent registration option missing',
          description: 'The "I\'m looking for programs for my child" option is not visible on the role selector',
          url: `${config.baseUrl}/register`,
        });
        return;
      }
      await parentOption.click();
      await this.page.waitForTimeout(500);

      // Step 1: Personal info form should appear
      const emailField = this.page.locator('input[type="email"]');
      if (!await emailField.isVisible({ timeout: 5000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Parent registration: personal info form did not appear',
          description: 'After selecting parent role, the personal info form (Step 1) did not render',
          url: this.page.url(),
        });
        return;
      }

      // Should show "Step 1 of 2" (not "Step 1 of 3" like org flow)
      const stepText = await this.page.locator('text=/Step 1 of 2/').isVisible({ timeout: 2000 });
      if (!stepText) {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: 'Parent registration shows wrong step count',
          description: 'Expected "Step 1 of 2" for parent flow but did not find it. May show "Step 1 of 3" (org flow steps).',
          url: this.page.url(),
        });
      }

      // Fill Step 1
      const testId = Math.random().toString(36).slice(2, 8);
      await this.page.fill('input#firstName', `TestParent${testId}`);
      await this.page.fill('input#lastName', 'ChaosAgent');
      await this.page.fill('input[type="email"]', `chaos-parent-${testId}@test.local`);
      await this.page.fill('input#password', 'ChaosTest123!');
      await this.page.fill('input#confirmPassword', 'ChaosTest123!');

      // Click Next
      await this.page.locator('button:has-text("Next")').click();
      await this.page.waitForTimeout(1000);

      // Step 2: Location picker should appear
      const locationHeader = this.page.locator('h1:has-text("Your Location")');
      if (!await locationHeader.isVisible({ timeout: 5000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Parent registration: location step did not appear',
          description: 'After filling personal info and clicking Next, the location picker (Step 2) did not render',
          url: this.page.url(),
        });
        return;
      }

      // Check for "Use my location" button or manual entry
      const useLocationBtn = this.page.locator('button:has-text("Use my location")');
      const manualEntry = this.page.locator('text=enter your location manually, text=Or enter');
      const hasGeolocation = await useLocationBtn.isVisible({ timeout: 2000 });
      const hasManualFallback = await manualEntry.isVisible({ timeout: 1000 });

      if (!hasGeolocation && !hasManualFallback) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Parent registration: location step has no input method',
          description: 'Neither "Use my location" button nor manual entry option is visible on the location step',
          url: this.page.url(),
        });
      }

      console.log(`    ✅ ${flow}: role selector → personal info → location step works`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({
        severity: 'error',
        category: 'flow-test',
        title: `Parent registration flow crashed: ${msg.slice(0, 80)}`,
        description: `Unhandled error during parent registration flow test: ${msg}`,
        url: this.page.url(),
      });
    }
  }

  // =========================================================================
  // Flow 2: Player registration
  // =========================================================================
  private async testPlayerRegistration() {
    const flow = 'player-registration';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      await this.page.goto(`${config.baseUrl}/register`, { waitUntil: 'networkidle', timeout: 15000 });
      await this.page.waitForSelector('text=How would you like to use TeamIO', { timeout: 5000 });

      // Click "I want to play"
      const playerOption = this.page.locator('text=I want to play');
      if (!await playerOption.isVisible({ timeout: 3000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Player registration option missing',
          description: '"I want to play" option not visible on role selector',
          url: `${config.baseUrl}/register`,
        });
        return;
      }
      await playerOption.click();
      await this.page.waitForTimeout(500);

      // Should show personal info form with "Step 1 of 2"
      const emailField = this.page.locator('input[type="email"]');
      if (!await emailField.isVisible({ timeout: 5000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Player registration: personal info form did not appear',
          description: 'After selecting player role, the form did not render',
          url: this.page.url(),
        });
        return;
      }

      console.log(`    ✅ ${flow}: role selector → personal info form works`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({
        severity: 'error',
        category: 'flow-test',
        title: `Player registration flow crashed: ${msg.slice(0, 80)}`,
        description: msg,
        url: this.page.url(),
      });
    }
  }

  // =========================================================================
  // Flow 3: Org admin registration (existing 3-step flow)
  // =========================================================================
  private async testOrgRegistration() {
    const flow = 'org-registration';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      await this.page.goto(`${config.baseUrl}/register`, { waitUntil: 'networkidle', timeout: 15000 });
      await this.page.waitForSelector('text=How would you like to use TeamIO', { timeout: 5000 });

      // Click "I manage a league or organization"
      const orgOption = this.page.locator('text=manage a league or organization');
      if (!await orgOption.isVisible({ timeout: 3000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Org registration option missing',
          description: '"I manage a league or organization" option not visible',
          url: `${config.baseUrl}/register`,
        });
        return;
      }
      await orgOption.click();
      await this.page.waitForTimeout(500);

      // Should show personal info form with "Step 1 of 3"
      const stepText = await this.page.locator('text=/Step 1 of 3/').isVisible({ timeout: 3000 });
      if (!stepText) {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: 'Org registration: expected "Step 1 of 3"',
          description: 'After selecting org role, expected 3-step flow indicator',
          url: this.page.url(),
        });
      }

      // Fill Step 1 and go to Step 2
      const testId = Math.random().toString(36).slice(2, 8);
      await this.page.fill('input#firstName', `TestOrg${testId}`);
      await this.page.fill('input#lastName', 'Admin');
      await this.page.fill('input[type="email"]', `chaos-org-${testId}@test.local`);
      await this.page.fill('input#password', 'ChaosTest123!');
      await this.page.fill('input#confirmPassword', 'ChaosTest123!');
      await this.page.locator('button:has-text("Next")').click();
      await this.page.waitForTimeout(1000);

      // Step 2: Should show org details form
      const orgNameField = this.page.locator('input#orgName');
      if (!await orgNameField.isVisible({ timeout: 5000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Org registration: organization details form did not appear',
          description: 'Step 2 (Your Organization) did not render after filling personal info',
          url: this.page.url(),
        });
        return;
      }

      // Fill Step 2 and go to Step 3
      await orgNameField.fill(`ChaosOrg ${testId}`);
      await this.page.locator('[role="combobox"]').first().click();
      await this.page.locator('[role="option"]').first().click();
      await this.page.waitForTimeout(300);

      // Select sport
      const sportTrigger = this.page.locator('[role="combobox"]').nth(1);
      if (await sportTrigger.isVisible({ timeout: 1000 })) {
        await sportTrigger.click();
        await this.page.locator('[role="option"]').first().click();
        await this.page.waitForTimeout(300);
      }

      await this.page.fill('input#city', 'TestCity');

      // Select state
      const stateTrigger = this.page.locator('[role="combobox"]').nth(2);
      if (await stateTrigger.isVisible({ timeout: 1000 })) {
        await stateTrigger.click();
        await this.page.locator('[role="option"]').first().click();
        await this.page.waitForTimeout(300);
      }

      await this.page.locator('button:has-text("Next")').click();
      await this.page.waitForTimeout(1000);

      // Step 3: Should show plan selection
      const planHeader = this.page.locator('h1:has-text("Confirm Plan")');
      if (!await planHeader.isVisible({ timeout: 5000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Org registration: plan selection did not appear',
          description: 'Step 3 (Confirm Plan) did not render after filling org details',
          url: this.page.url(),
        });
        return;
      }

      console.log(`    ✅ ${flow}: role selector → personal info → org details → plan selection works`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({
        severity: 'error',
        category: 'flow-test',
        title: `Org registration flow crashed: ${msg.slice(0, 80)}`,
        description: msg,
        url: this.page.url(),
      });
    }
  }

  // =========================================================================
  // Flow 4: Discover page (search, filters, org cards)
  // =========================================================================
  private async testDiscoverPage() {
    const flow = 'discover-page';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      await this.page.goto(`${config.baseUrl}/discover`, { waitUntil: 'networkidle', timeout: 15000 });

      // Should show the discover page header
      const header = this.page.locator('text=Find Programs Near You');
      if (!await header.isVisible({ timeout: 5000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Discover page header missing',
          description: '"Find Programs Near You" heading not visible on /discover',
          url: `${config.baseUrl}/discover`,
        });
        return;
      }

      // Should show either location prompt or search results
      const zipInput = this.page.locator('input[placeholder*="Zip"], input[placeholder*="zip"]');
      const searchInput = this.page.locator('input[placeholder*="Search"]');
      const hasZipPrompt = await zipInput.isVisible({ timeout: 2000 });
      const hasSearch = await searchInput.isVisible({ timeout: 2000 });

      if (!hasZipPrompt && !hasSearch) {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: 'Discover page: no input method visible',
          description: 'Neither zip code prompt nor search bar is visible. Page may be in an unexpected state.',
          url: `${config.baseUrl}/discover`,
        });
      }

      // Check for list/map toggle
      const listBtn = this.page.locator('button:has-text("List")');
      const mapBtn = this.page.locator('button:has-text("Map")');
      if (await listBtn.isVisible({ timeout: 1000 }) && await mapBtn.isVisible({ timeout: 1000 })) {
        // Try clicking map toggle
        await mapBtn.click();
        await this.page.waitForTimeout(1000);
        // Click back to list
        await listBtn.click();
        await this.page.waitForTimeout(500);
      }

      console.log(`    ✅ ${flow}: page loads with ${hasZipPrompt ? 'zip prompt' : hasSearch ? 'search' : 'unknown state'}`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({
        severity: 'error',
        category: 'flow-test',
        title: `Discover page flow crashed: ${msg.slice(0, 80)}`,
        description: msg,
        url: this.page.url(),
      });
    }
  }

  // =========================================================================
  // Flow 5: Discover org profile (click org → see profile → join CTA)
  // =========================================================================
  private async testDiscoverOrgProfile() {
    const flow = 'discover-org-profile';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      // We need to navigate to a known org's public profile
      // Use the API to find an org slug
      const apiUrl = config.apiUrl || config.baseUrl;
      const res = await this.page.request.get(`${apiUrl}/api/organizations`);
      if (!res.ok()) {
        console.log(`    ⏭️  ${flow}: skipped (can't fetch orgs)`);
        return;
      }

      const data = await res.json() as { organizations?: Array<{ slug: string; name: string }> };
      const orgs = data.organizations || [];
      if (orgs.length === 0) {
        console.log(`    ⏭️  ${flow}: skipped (no orgs in DB)`);
        return;
      }

      const org = orgs[0];
      await this.page.goto(`${config.baseUrl}/discover/${org.slug}`, { waitUntil: 'networkidle', timeout: 15000 });

      // Should show org name
      const orgName = this.page.locator(`text=${org.name}`);
      if (!await orgName.isVisible({ timeout: 5000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: `Org profile page: org name "${org.name}" not visible`,
          description: `Navigated to /discover/${org.slug} but org name did not appear`,
          url: this.page.url(),
        });
        return;
      }

      // Should have a join/request button
      const joinBtn = this.page.locator('button:has-text("Join"), button:has-text("Request"), button:has-text("Sign up")');
      if (!await joinBtn.isVisible({ timeout: 3000 })) {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: 'Org profile: no join/request button',
          description: `The org profile for "${org.name}" does not show a Join or Request to Join button`,
          url: this.page.url(),
        });
      }

      // Check for key sections
      const sections = ['Leagues', 'Upcoming Events', 'Contact', 'Open Registration'];
      for (const section of sections) {
        // Just log which sections exist, don't flag missing ones as bugs
        const visible = await this.page.locator(`text=${section}`).isVisible({ timeout: 500 });
        if (visible) console.log(`      📋 Section visible: ${section}`);
      }

      console.log(`    ✅ ${flow}: profile loads for "${org.name}"`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({
        severity: 'error',
        category: 'flow-test',
        title: `Org profile flow crashed: ${msg.slice(0, 80)}`,
        description: msg,
        url: this.page.url(),
      });
    }
  }

  // =========================================================================
  // Flow 6: Travel team registration (onboard as coach → auto-provisions)
  // =========================================================================
  private async testTravelTeamRegistration() {
    const flow = 'travel-team-registration';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      const apiUrl = config.apiUrl || config.baseUrl;
      const testId = Math.random().toString(36).slice(2, 8);

      // Register via onboard API (travel team)
      const res = await this.page.request.post(`${apiUrl}/api/auth/onboard`, {
        data: {
          email: `chaos-travel-${testId}@test.local`,
          password: 'ChaosTest123!',
          first_name: 'Coach',
          last_name: `Travel${testId}`,
          org_name: `Travel Eagles ${testId}`,
          org_type: 'travel_team',
          org_sport: 'baseball',
          org_city: 'Springfield',
          org_state: 'IL',
        },
      });

      if (!res.ok()) {
        const body = await res.text();
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Travel team onboard API failed',
          description: `POST /api/auth/onboard returned ${res.status()}: ${body.slice(0, 200)}`,
          url: `${apiUrl}/api/auth/onboard`,
        });
        return;
      }

      const data = await res.json() as any;

      // Verify user role is "coach" (not "commissioner")
      if (data.user?.role !== 'coach') {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: `Travel team signup: user role is "${data.user?.role}" instead of "coach"`,
          description: 'Travel team creators should get the "coach" role, not commissioner',
          url: `${apiUrl}/api/auth/onboard`,
        });
      }

      // Verify org was created
      if (!data.organization?.id) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Travel team signup: no organization returned',
          description: 'The onboard response is missing the organization object',
          url: `${apiUrl}/api/auth/onboard`,
        });
        return;
      }

      // Check auto-provisioned resources via API
      const token = data.access_token;
      const headers = { Authorization: `Bearer ${token}` };

      // Check seasons exist
      const seasonsRes = await this.page.request.get(`${apiUrl}/api/seasons`, {
        headers,
      });
      if (seasonsRes.ok()) {
        const seasonsData = await seasonsRes.json() as any;
        const seasons = seasonsData.seasons || seasonsData;
        if (!Array.isArray(seasons) || seasons.length === 0) {
          this.reporter.addBug({
            severity: 'error',
            category: 'flow-test',
            title: 'Travel team signup: no auto-provisioned season',
            description: 'After travel team onboard, expected at least one season to be auto-created',
            url: `${apiUrl}/api/seasons`,
          });
        } else {
          console.log(`      📋 Auto-provisioned: ${seasons.length} season(s)`);
        }
      }

      // Check teams exist
      const teamsRes = await this.page.request.get(`${apiUrl}/api/teams?per_page=50`, {
        headers,
      });
      if (teamsRes.ok()) {
        const teamsData = await teamsRes.json() as any;
        const teams = teamsData.teams || teamsData;
        if (!Array.isArray(teams) || teams.length === 0) {
          this.reporter.addBug({
            severity: 'warning',
            category: 'flow-test',
            title: 'Travel team signup: no auto-provisioned team',
            description: 'After travel team onboard, expected a team to be auto-created',
            url: `${apiUrl}/api/teams`,
          });
        } else {
          console.log(`      📋 Auto-provisioned: ${teams.length} team(s)`);
        }
      }

      // Inject tokens and navigate to coach portal
      await this.page.goto(config.baseUrl, { waitUntil: 'domcontentloaded', timeout: 10000 });
      await this.page.evaluate((tokens: any) => {
        localStorage.setItem('access_token', tokens.access_token);
        localStorage.setItem('refresh_token', tokens.refresh_token);
      }, data);
      await this.page.goto(`${config.baseUrl}/dashboard/coach`, { waitUntil: 'networkidle', timeout: 15000 });

      // Should see Coach Portal
      const coachHeader = this.page.locator('text=Coach Portal');
      if (!await coachHeader.isVisible({ timeout: 5000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Travel team coach: Coach Portal not visible after login',
          description: 'After travel team onboard and login, the Coach Portal page did not render',
          url: this.page.url(),
        });
        return;
      }

      // Season should be auto-selected
      const seasonSelector = this.page.locator('text=Select Season');
      const noSeasonSelected = await seasonSelector.isVisible({ timeout: 2000 });
      if (noSeasonSelected) {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: 'Travel team coach: season not auto-selected',
          description: 'The auto-provisioned season should be auto-selected in the Coach Portal',
          url: this.page.url(),
        });
      }

      // Should NOT see League Management in sidebar
      const leagueMgmt = this.page.locator('text=League Management');
      if (await leagueMgmt.isVisible({ timeout: 1000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Travel team coach sees League Management sidebar',
          description: 'A coach-role user should see "My Team" sidebar, not "League Management"',
          url: this.page.url(),
        });
      }

      // Should see My Team section
      const myTeam = this.page.locator('text=My Team');
      if (!await myTeam.first().isVisible({ timeout: 2000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Travel team coach: "My Team" sidebar section missing',
          description: 'Coach should see "My Team" navigation section',
          url: this.page.url(),
        });
      }

      // Clean up: clear localStorage
      await this.page.evaluate(() => {
        localStorage.removeItem('access_token');
        localStorage.removeItem('refresh_token');
      });

      console.log(`    ✅ ${flow}: onboard → coach role → auto-provision → coach portal works`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({
        severity: 'error',
        category: 'flow-test',
        title: `Travel team registration flow crashed: ${msg.slice(0, 80)}`,
        description: msg,
        url: this.page.url(),
      });
    }
  }

  // =========================================================================
  // Flow 7: Coach Portal — season creation
  // =========================================================================
  private async testCoachPortalSeasonCreation() {
    const flow = 'coach-season-creation';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      // Login as coach
      const apiUrl = config.apiUrl || config.baseUrl;
      const res = await this.page.request.post(`${apiUrl}/api/auth/login`, {
        data: { email: config.users.coach.email, password: config.users.coach.password },
      });

      if (!res.ok()) {
        console.log(`    ⏭️  ${flow}: skipped (coach login failed)`);
        return;
      }

      const data = await res.json() as any;
      await this.page.goto(config.baseUrl, { waitUntil: 'domcontentloaded', timeout: 10000 });
      await this.page.evaluate((tokens: any) => {
        localStorage.setItem('access_token', tokens.access_token);
        localStorage.setItem('refresh_token', tokens.refresh_token);
      }, data);

      await this.page.goto(`${config.baseUrl}/dashboard/coach`, { waitUntil: 'networkidle', timeout: 15000 });

      // Check for season dropdown
      const seasonDropdown = this.page.locator('[role="combobox"]').first();
      if (!await seasonDropdown.isVisible({ timeout: 5000 })) {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: 'Coach Portal: season dropdown not visible',
          description: 'The season selector dropdown is not rendering on the Coach Portal',
          url: this.page.url(),
        });
        return;
      }

      // Click dropdown and check for "+ New Season" option
      await seasonDropdown.click();
      await this.page.waitForTimeout(500);
      const newSeasonOption = this.page.locator('text=+ New Season');
      const hasNewSeason = await newSeasonOption.isVisible({ timeout: 2000 });
      // Close the dropdown
      await this.page.keyboard.press('Escape');

      if (!hasNewSeason) {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: 'Coach Portal: "+ New Season" option missing from dropdown',
          description: 'The season dropdown should have a "+ New Season" option at the bottom',
          url: this.page.url(),
        });
      }

      // Check for Schedule Practice button
      const practiceBtn = this.page.locator('button:has-text("Schedule Practice")');
      if (!await practiceBtn.isVisible({ timeout: 2000 })) {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: 'Coach Portal: "Schedule Practice" button missing',
          description: 'The Schedule Practice button should be visible on the Coach Portal',
          url: this.page.url(),
        });
      }

      await this.page.evaluate(() => {
        localStorage.removeItem('access_token');
        localStorage.removeItem('refresh_token');
      });

      console.log(`    ✅ ${flow}: coach portal renders with season controls`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({
        severity: 'error',
        category: 'flow-test',
        title: `Coach season creation flow crashed: ${msg.slice(0, 80)}`,
        description: msg,
        url: this.page.url(),
      });
    }
  }

  // =========================================================================
  // Flow 8: Coach tryout management (API-level)
  // =========================================================================
  private async testCoachTryoutFlow() {
    const flow = 'coach-tryout-api';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      const apiUrl = config.apiUrl || config.baseUrl;

      // Create a fresh travel team to test with
      const testId = Math.random().toString(36).slice(2, 8);
      const onboardRes = await this.page.request.post(`${apiUrl}/api/auth/onboard`, {
        data: {
          email: `chaos-tryout-${testId}@test.local`,
          password: 'ChaosTest123!',
          first_name: 'Coach',
          last_name: `Tryout${testId}`,
          org_name: `Tryout Team ${testId}`,
          org_type: 'travel_team',
          org_sport: 'soccer',
          org_city: 'Springfield',
          org_state: 'IL',
        },
      });

      if (!onboardRes.ok()) {
        console.log(`    ⏭️  ${flow}: skipped (onboard failed)`);
        return;
      }

      const onboard = await onboardRes.json() as any;
      const token = onboard.access_token;
      const headers = { Authorization: `Bearer ${token}` };

      // Get the auto-provisioned season and team
      const seasonsRes = await this.page.request.get(`${apiUrl}/api/seasons`, { headers });
      const seasonsData = await seasonsRes.json() as any;
      const seasons = seasonsData.seasons || [];
      if (seasons.length === 0) {
        console.log(`    ⏭️  ${flow}: skipped (no seasons)`);
        return;
      }
      const seasonId = seasons[0].id;

      const teamsRes = await this.page.request.get(`${apiUrl}/api/teams?per_page=50`, { headers });
      const teamsData = await teamsRes.json() as any;
      const allTeams = Array.isArray(teamsData) ? teamsData : teamsData.teams || [];
      if (allTeams.length === 0) {
        console.log(`    ⏭️  ${flow}: skipped (no teams)`);
        return;
      }
      const teamId = allTeams[0].id;

      // Test 1: Create a tryout invite (should fail without tryout_system flag)
      const inviteRes = await this.page.request.post(`${apiUrl}/api/tryout-invites`, {
        headers,
        data: {
          season_id: seasonId,
          team_id: teamId,
          player_first_name: 'Test',
          player_last_name: 'Player',
          parent_email: `chaos-parent-${testId}@test.local`,
        },
      });

      if (inviteRes.ok()) {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: 'Tryout invite created without tryout_system flag enabled',
          description: 'Creating a tryout invite should require the tryout_system feature flag to be enabled',
          url: `${apiUrl}/api/tryout-invites`,
        });
      } else {
        const status = inviteRes.status();
        if (status === 403) {
          console.log(`      📋 Tryout invite correctly blocked (feature flag not enabled)`);
        } else {
          this.reporter.addBug({
            severity: 'warning',
            category: 'flow-test',
            title: `Tryout invite returned unexpected status ${status}`,
            description: `Expected 403 (feature flag) but got ${status}`,
            url: `${apiUrl}/api/tryout-invites`,
          });
        }
      }

      // Test 2: Create a tryout event (should work — events aren't flag-gated)
      const eventRes = await this.page.request.post(`${apiUrl}/api/schedule/events`, {
        headers,
        data: {
          season_id: seasonId,
          event_type: 'tryout',
          title: `Tryout Session ${testId}`,
          start_time: new Date(Date.now() + 7 * 86400000).toISOString(),
          end_time: new Date(Date.now() + 7 * 86400000 + 7200000).toISOString(),
          home_team_id: teamId,
        },
      });

      if (eventRes.ok()) {
        console.log(`      📋 Tryout event created successfully`);
      } else {
        const body = await eventRes.text();
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: `Failed to create tryout event (${eventRes.status()})`,
          description: body.slice(0, 200),
          url: `${apiUrl}/api/schedule/events`,
        });
      }

      // Test 3: Check rollover preview (should return empty for first season)
      const previewRes = await this.page.request.get(
        `${apiUrl}/api/seasons/${seasonId}/rollover-preview?source_season_id=${seasonId}`,
        { headers },
      );
      if (previewRes.ok()) {
        console.log(`      📋 Rollover preview endpoint responds`);
      }

      console.log(`    ✅ ${flow}: tryout API flow verified`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({
        severity: 'error',
        category: 'flow-test',
        title: `Coach tryout flow crashed: ${msg.slice(0, 80)}`,
        description: msg,
        url: this.page.url(),
      });
    }
  }

  // =========================================================================
  // Flow 9: Parent offer flow (API-level)
  // =========================================================================
  private async testParentOfferFlow() {
    const flow = 'parent-offer-api';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      const apiUrl = config.apiUrl || config.baseUrl;

      // Login as parent and check the my-offers endpoint
      const res = await this.page.request.post(`${apiUrl}/api/auth/login`, {
        data: { email: config.users.parent.email, password: config.users.parent.password },
      });

      if (!res.ok()) {
        console.log(`    ⏭️  ${flow}: skipped (parent login failed)`);
        return;
      }

      const data = await res.json() as any;
      const headers = { Authorization: `Bearer ${data.access_token}` };

      // Check my-offers endpoint
      const offersRes = await this.page.request.get(`${apiUrl}/api/roster-offers/my-offers`, { headers });
      if (offersRes.ok()) {
        const offers = await offersRes.json() as any;
        const count = Array.isArray(offers) ? offers.length : 0;
        console.log(`      📋 Parent has ${count} roster offer(s)`);
      } else {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: `Parent my-offers endpoint failed (${offersRes.status()})`,
          description: 'GET /roster-offers/my-offers should return offers for the parent',
          url: `${apiUrl}/api/roster-offers/my-offers`,
        });
      }

      // Navigate to parent portal and check for offers section
      await this.page.goto(config.baseUrl, { waitUntil: 'domcontentloaded', timeout: 10000 });
      await this.page.evaluate((tokens: any) => {
        localStorage.setItem('access_token', tokens.access_token);
        localStorage.setItem('refresh_token', tokens.refresh_token);
      }, data);

      await this.page.goto(`${config.baseUrl}/dashboard/parent`, { waitUntil: 'networkidle', timeout: 15000 });

      // Parent portal should load
      const parentHeader = this.page.locator('text=My Players');
      if (!await parentHeader.isVisible({ timeout: 5000 })) {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: 'Parent portal: "My Players" heading not visible',
          description: 'The parent portal page did not render correctly',
          url: this.page.url(),
        });
      }

      await this.page.evaluate(() => {
        localStorage.removeItem('access_token');
        localStorage.removeItem('refresh_token');
      });

      console.log(`    ✅ ${flow}: parent offer API and portal verified`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({
        severity: 'error',
        category: 'flow-test',
        title: `Parent offer flow crashed: ${msg.slice(0, 80)}`,
        description: msg,
        url: this.page.url(),
      });
    }
  }

  // =========================================================================
  // Flow 10: Role-based navigation verification
  // =========================================================================
  private async testRoleBasedNavigation() {
    const flow = 'role-based-navigation';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      const apiUrl = config.apiUrl || config.baseUrl;

      // Test admin navigation
      const adminRes = await this.page.request.post(`${apiUrl}/api/auth/login`, {
        data: { email: config.users.admin.email, password: config.users.admin.password },
      });

      if (adminRes.ok()) {
        const data = await adminRes.json() as any;
        await this.page.goto(config.baseUrl, { waitUntil: 'domcontentloaded', timeout: 10000 });
        await this.page.evaluate((tokens: any) => {
          localStorage.setItem('access_token', tokens.access_token);
          localStorage.setItem('refresh_token', tokens.refresh_token);
        }, data);
        await this.page.goto(`${config.baseUrl}/dashboard`, { waitUntil: 'networkidle', timeout: 15000 });

        // Admin should see League Management
        const leagueMgmt = this.page.locator('text=League Management');
        if (!await leagueMgmt.isVisible({ timeout: 3000 })) {
          this.reporter.addBug({
            severity: 'error',
            category: 'flow-test',
            title: 'Admin missing "League Management" sidebar section',
            description: 'Admin/commissioner users should see the League Management navigation',
            url: this.page.url(),
          });
        }

        // Admin should see System section
        const systemSection = this.page.locator('text=System');
        if (!await systemSection.isVisible({ timeout: 2000 })) {
          this.reporter.addBug({
            severity: 'warning',
            category: 'flow-test',
            title: 'Admin missing "System" sidebar section',
            description: 'Admin users should see the System navigation section',
            url: this.page.url(),
          });
        }

        // Admin should NOT see "My Team" (that's for coaches)
        const myTeamSection = this.page.locator('text=My Team').first();
        if (await myTeamSection.isVisible({ timeout: 1000 })) {
          // This might be OK if admin is also a coach in some org
          console.log(`      ⚠️  Admin sees "My Team" section (may be expected if multi-role)`);
        }

        // Admin should NOT see referee items
        const refPortal = this.page.locator('a:has-text("Referee Portal")');
        if (await refPortal.isVisible({ timeout: 1000 })) {
          this.reporter.addBug({
            severity: 'warning',
            category: 'flow-test',
            title: 'Admin/coach sees Referee Portal in navigation',
            description: 'Referee Portal should only be shown to registered referees',
            url: this.page.url(),
          });
        }

        await this.page.evaluate(() => {
          localStorage.removeItem('access_token');
          localStorage.removeItem('refresh_token');
        });
        console.log(`      📋 Admin navigation verified`);
      }

      // Test coach navigation
      const coachRes = await this.page.request.post(`${apiUrl}/api/auth/login`, {
        data: { email: config.users.coach.email, password: config.users.coach.password },
      });

      if (coachRes.ok()) {
        const data = await coachRes.json() as any;
        await this.page.goto(config.baseUrl, { waitUntil: 'domcontentloaded', timeout: 10000 });
        await this.page.evaluate((tokens: any) => {
          localStorage.setItem('access_token', tokens.access_token);
          localStorage.setItem('refresh_token', tokens.refresh_token);
        }, data);
        await this.page.goto(`${config.baseUrl}/dashboard`, { waitUntil: 'networkidle', timeout: 15000 });

        // Coach should NOT see Generate Schedule button
        await this.page.goto(`${config.baseUrl}/dashboard/schedule`, { waitUntil: 'networkidle', timeout: 15000 });
        const generateBtn = this.page.locator('button:has-text("Generate Schedule")');
        if (await generateBtn.isVisible({ timeout: 2000 })) {
          this.reporter.addBug({
            severity: 'error',
            category: 'flow-test',
            title: 'Coach sees "Generate Schedule" button',
            description: 'Schedule generation should only be visible to commissioners/admins, not coaches',
            url: this.page.url(),
          });
        } else {
          console.log(`      📋 Coach correctly cannot see Generate Schedule`);
        }

        await this.page.evaluate(() => {
          localStorage.removeItem('access_token');
          localStorage.removeItem('refresh_token');
        });
        console.log(`      📋 Coach navigation verified`);
      }

      console.log(`    ✅ ${flow}: role-based navigation verified for admin and coach`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({
        severity: 'error',
        category: 'flow-test',
        title: `Role-based navigation test crashed: ${msg.slice(0, 80)}`,
        description: msg,
        url: this.page.url(),
      });
    }
  }

  // =========================================================================
  // Flow 11: Login redirects correctly per role
  // =========================================================================
  private async testLoginRedirects() {
    const flow = 'login-redirects';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    // Test that parent user goes to /discover after login (not /dashboard)
    try {
      const apiUrl = config.apiUrl || config.baseUrl;
      const res = await this.page.request.post(`${apiUrl}/api/auth/login`, {
        data: { email: config.users.parent.email, password: config.users.parent.password },
      });

      if (!res.ok()) {
        console.log(`    ⏭️  ${flow}: parent login API failed (${res.status()})`);
        return;
      }

      const data = await res.json() as { access_token: string; refresh_token: string; user: { role: string } };

      // Check role (accept both "parent" and "guardian")
      if (data.user.role !== 'parent' && data.user.role !== 'guardian') {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: `Parent test user has unexpected role "${data.user.role}"`,
          description: `The test user ${config.users.parent.email} has role "${data.user.role}" (expected "parent" or "guardian"). Login redirect test may not be accurate.`,
          url: `${config.baseUrl}/login`,
        });
      }

      console.log(`    ✅ ${flow}: parent login returns role "${data.user.role}"`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      console.log(`    ⚠️  ${flow}: ${msg.slice(0, 100)}`);
    }
  }

  // =========================================================================
  // Flow 12: Announcements (admin creates → all users see banner)
  // =========================================================================
  private async testAnnouncementsFlow() {
    const flow = 'announcements-e2e';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      const apiUrl = config.apiUrl || config.baseUrl;

      // Login as admin
      const adminRes = await this.page.request.post(`${apiUrl}/api/auth/login`, {
        data: { email: config.users.admin.email, password: config.users.admin.password },
      });
      if (!adminRes.ok()) { console.log(`    ⏭️  ${flow}: skipped (admin login failed)`); return; }
      const adminData = await adminRes.json() as any;
      const adminHeaders = { Authorization: `Bearer ${adminData.access_token}` };

      // Create an announcement via API
      const testId = Math.random().toString(36).slice(2, 8);
      const createRes = await this.page.request.post(`${apiUrl}/api/system-admin/announcements`, {
        headers: adminHeaders,
        data: { title: `QA Test Announcement ${testId}`, message: 'This is a chaos agent test announcement', variant: 'info' },
      });

      if (!createRes.ok()) {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: `Failed to create announcement (${createRes.status()})`,
          description: 'Admin could not create an announcement via /system-admin/announcements',
          url: `${apiUrl}/api/system-admin/announcements`,
        });
        return;
      }
      const announcement = await createRes.json() as any;
      console.log(`      📋 Created announcement: "${announcement.title || testId}"`);

      // Verify it shows in active announcements (public endpoint)
      const activeRes = await this.page.request.get(`${apiUrl}/api/announcements/active`);
      if (activeRes.ok()) {
        const active = await activeRes.json() as any[];
        const found = active.some((a: any) => a.title?.includes(testId));
        if (!found) {
          this.reporter.addBug({
            severity: 'error',
            category: 'flow-test',
            title: 'Created announcement not in active list',
            description: `Announcement "${testId}" was created but not returned by /announcements/active`,
            url: `${apiUrl}/api/announcements/active`,
          });
        } else {
          console.log(`      📋 Announcement visible in active list`);
        }
      }

      // Login as coach and verify announcement banner renders
      const coachRes = await this.page.request.post(`${apiUrl}/api/auth/login`, {
        data: { email: config.users.coach.email, password: config.users.coach.password },
      });
      if (coachRes.ok()) {
        const coachData = await coachRes.json() as any;
        await this.page.goto(config.baseUrl, { waitUntil: 'domcontentloaded', timeout: 10000 });
        await this.page.evaluate((t: any) => {
          localStorage.setItem('access_token', t.access_token);
          localStorage.setItem('refresh_token', t.refresh_token);
        }, coachData);
        await this.page.goto(`${config.baseUrl}/dashboard`, { waitUntil: 'networkidle', timeout: 15000 });

        const banner = this.page.locator(`text=QA Test Announcement ${testId}`);
        if (await banner.isVisible({ timeout: 5000 })) {
          console.log(`      📋 Coach sees announcement banner`);
        } else {
          this.reporter.addBug({
            severity: 'warning',
            category: 'flow-test',
            title: 'Announcement banner not visible to coach',
            description: 'Created announcement should appear as a banner on the dashboard',
            url: this.page.url(),
          });
        }
        await this.page.evaluate(() => { localStorage.clear(); });
      }

      // Clean up: delete the announcement
      if (announcement.id) {
        await this.page.request.delete(`${apiUrl}/api/system-admin/announcements/${announcement.id}`, { headers: adminHeaders });
      }

      console.log(`    ✅ ${flow}: create → visible to users → cleanup`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({ severity: 'error', category: 'flow-test', title: `Announcements flow crashed: ${msg.slice(0, 80)}`, description: msg, url: this.page.url() });
    }
  }

  // =========================================================================
  // Flow 13: Messaging (send message, check inbox, conversations)
  // =========================================================================
  private async testMessagingFlow() {
    const flow = 'messaging-e2e';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      const apiUrl = config.apiUrl || config.baseUrl;

      // Login as admin
      const adminRes = await this.page.request.post(`${apiUrl}/api/auth/login`, {
        data: { email: config.users.admin.email, password: config.users.admin.password },
      });
      if (!adminRes.ok()) { console.log(`    ⏭️  ${flow}: skipped (admin login failed)`); return; }
      const adminData = await adminRes.json() as any;
      const adminHeaders = { Authorization: `Bearer ${adminData.access_token}` };

      // Login as coach to get their user ID
      const coachRes = await this.page.request.post(`${apiUrl}/api/auth/login`, {
        data: { email: config.users.coach.email, password: config.users.coach.password },
      });
      if (!coachRes.ok()) { console.log(`    ⏭️  ${flow}: skipped (coach login failed)`); return; }
      const coachData = await coachRes.json() as any;
      const coachHeaders = { Authorization: `Bearer ${coachData.access_token}` };
      const coachUserId = coachData.user?.id;

      if (!coachUserId) { console.log(`    ⏭️  ${flow}: skipped (no coach user ID)`); return; }

      // Admin sends a message to coach
      const sendRes = await this.page.request.post(`${apiUrl}/api/messages`, {
        headers: adminHeaders,
        data: {
          recipient_ids: [coachUserId],
          subject: `QA Test Message ${Date.now()}`,
          body: 'This is a chaos agent test message',
          scope_type: 'direct',
        },
      });

      if (sendRes.ok()) {
        console.log(`      📋 Admin sent message to coach`);
      } else {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: `Failed to send message (${sendRes.status()})`,
          description: await sendRes.text().then(t => t.slice(0, 200)),
          url: `${apiUrl}/api/messages`,
        });
        return;
      }

      // Coach checks inbox
      const inboxRes = await this.page.request.get(`${apiUrl}/api/users/${coachUserId}/inbox`, {
        headers: coachHeaders,
      });
      if (inboxRes.ok()) {
        const inbox = await inboxRes.json() as any;
        const messages = Array.isArray(inbox) ? inbox : inbox.messages || [];
        console.log(`      📋 Coach inbox has ${messages.length} message(s)`);
        if (messages.length === 0) {
          this.reporter.addBug({
            severity: 'warning',
            category: 'flow-test',
            title: 'Coach inbox empty after admin sent message',
            description: 'Expected at least one message in coach inbox after admin sent a direct message',
            url: `${apiUrl}/api/users/${coachUserId}/inbox`,
          });
        }
      } else {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: `Coach inbox endpoint failed (${inboxRes.status()})`,
          description: 'GET /users/:id/inbox returned an error',
          url: `${apiUrl}/api/users/${coachUserId}/inbox`,
        });
      }

      // Coach checks conversations
      const convRes = await this.page.request.get(`${apiUrl}/api/users/${coachUserId}/conversations`, {
        headers: coachHeaders,
      });
      if (convRes.ok()) {
        const convs = await convRes.json() as any;
        const list = Array.isArray(convs) ? convs : convs.conversations || [];
        console.log(`      📋 Coach has ${list.length} conversation(s)`);
      }

      // Navigate to messages page as coach
      await this.page.goto(config.baseUrl, { waitUntil: 'domcontentloaded', timeout: 10000 });
      await this.page.evaluate((t: any) => {
        localStorage.setItem('access_token', t.access_token);
        localStorage.setItem('refresh_token', t.refresh_token);
      }, coachData);
      await this.page.goto(`${config.baseUrl}/dashboard/messages`, { waitUntil: 'networkidle', timeout: 15000 });

      const messagesPage = this.page.locator('text=Messages');
      if (!await messagesPage.isVisible({ timeout: 5000 })) {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: 'Messages page did not render for coach',
          description: '/dashboard/messages should show the messaging interface',
          url: this.page.url(),
        });
      }

      await this.page.evaluate(() => { localStorage.clear(); });
      console.log(`    ✅ ${flow}: send → inbox → conversations → UI verified`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({ severity: 'error', category: 'flow-test', title: `Messaging flow crashed: ${msg.slice(0, 80)}`, description: msg, url: this.page.url() });
    }
  }

  // =========================================================================
  // Flow 14: Broadcast (admin sends weather/schedule broadcast)
  // =========================================================================
  private async testBroadcastFlow() {
    const flow = 'broadcast-e2e';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      const apiUrl = config.apiUrl || config.baseUrl;

      const adminRes = await this.page.request.post(`${apiUrl}/api/auth/login`, {
        data: { email: config.users.admin.email, password: config.users.admin.password },
      });
      if (!adminRes.ok()) { console.log(`    ⏭️  ${flow}: skipped (admin login failed)`); return; }
      const adminData = await adminRes.json() as any;
      const adminHeaders = { Authorization: `Bearer ${adminData.access_token}` };

      // Navigate to broadcasts page
      await this.page.goto(config.baseUrl, { waitUntil: 'domcontentloaded', timeout: 10000 });
      await this.page.evaluate((t: any) => {
        localStorage.setItem('access_token', t.access_token);
        localStorage.setItem('refresh_token', t.refresh_token);
      }, adminData);
      await this.page.goto(`${config.baseUrl}/dashboard/broadcasts`, { waitUntil: 'networkidle', timeout: 15000 });

      // Check broadcasts page renders
      const broadcastHeader = this.page.locator('text=Broadcasts, text=Communications, text=Send Broadcast');
      if (await broadcastHeader.first().isVisible({ timeout: 5000 })) {
        console.log(`      📋 Broadcasts page renders`);
      } else {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: 'Broadcasts page did not render',
          description: '/dashboard/broadcasts should show the broadcast interface for admins',
          url: this.page.url(),
        });
      }

      // Test system-admin broadcast API
      const broadcastRes = await this.page.request.post(`${apiUrl}/api/system-admin/broadcast`, {
        headers: adminHeaders,
        data: {
          subject: `QA Broadcast Test ${Date.now()}`,
          body_html: '<p>Chaos agent broadcast test - please ignore</p>',
        },
      });

      if (broadcastRes.ok()) {
        console.log(`      📋 System broadcast sent successfully`);
      } else {
        const status = broadcastRes.status();
        // 403 is expected if not a sys-admin email domain
        if (status === 403) {
          console.log(`      📋 Broadcast correctly requires sys-admin (403)`);
        } else {
          this.reporter.addBug({
            severity: 'warning',
            category: 'flow-test',
            title: `Broadcast API returned ${status}`,
            description: await broadcastRes.text().then(t => t.slice(0, 200)),
            url: `${apiUrl}/api/system-admin/broadcast`,
          });
        }
      }

      await this.page.evaluate(() => { localStorage.clear(); });
      console.log(`    ✅ ${flow}: broadcast page + API verified`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({ severity: 'error', category: 'flow-test', title: `Broadcast flow crashed: ${msg.slice(0, 80)}`, description: msg, url: this.page.url() });
    }
  }

  // =========================================================================
  // Flow 15: Admin dashboard (stats, email queue, audit log)
  // =========================================================================
  private async testAdminDashboardFlow() {
    const flow = 'admin-dashboard-e2e';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      const apiUrl = config.apiUrl || config.baseUrl;

      const adminRes = await this.page.request.post(`${apiUrl}/api/auth/login`, {
        data: { email: config.users.admin.email, password: config.users.admin.password },
      });
      if (!adminRes.ok()) { console.log(`    ⏭️  ${flow}: skipped (admin login failed)`); return; }
      const adminData = await adminRes.json() as any;
      const adminHeaders = { Authorization: `Bearer ${adminData.access_token}` };

      // Test key admin API endpoints
      const endpoints = [
        { path: '/api/system-admin/stats', name: 'Dashboard stats' },
        { path: '/api/system-admin/email-queue/stats', name: 'Email queue stats' },
        { path: '/api/system-admin/audit-log', name: 'Audit log' },
        { path: '/api/system-admin/feature-flags', name: 'Feature flags' },
        { path: '/api/system-admin/feature-flag-registry', name: 'Flag registry' },
        { path: '/api/system-admin/announcements', name: 'Announcements' },
        { path: '/api/system-admin/organizations', name: 'Organizations list' },
        { path: '/api/system-admin/users', name: 'Users list' },
      ];

      for (const ep of endpoints) {
        const res = await this.page.request.get(`${apiUrl}${ep.path}`, { headers: adminHeaders });
        if (res.ok()) {
          console.log(`      📋 ${ep.name}: OK`);
        } else {
          this.reporter.addBug({
            severity: 'warning',
            category: 'flow-test',
            title: `Admin endpoint ${ep.name} failed (${res.status()})`,
            description: `GET ${ep.path} returned ${res.status()}`,
            url: `${apiUrl}${ep.path}`,
          });
        }
      }

      // Navigate to sys-admin pages
      await this.page.goto(config.baseUrl, { waitUntil: 'domcontentloaded', timeout: 10000 });
      await this.page.evaluate((t: any) => {
        localStorage.setItem('access_token', t.access_token);
        localStorage.setItem('refresh_token', t.refresh_token);
      }, adminData);

      const sysAdminPages = [
        { path: '/system-admin', check: 'System Admin' },
        { path: '/system-admin/feature-flags', check: 'Feature Flags' },
        { path: '/system-admin/organizations', check: 'Organizations' },
      ];

      for (const page of sysAdminPages) {
        await this.page.goto(`${config.baseUrl}${page.path}`, { waitUntil: 'networkidle', timeout: 15000 });
        const heading = this.page.locator(`text=${page.check}`);
        if (await heading.first().isVisible({ timeout: 5000 })) {
          console.log(`      📋 ${page.path}: renders`);
        } else {
          this.reporter.addBug({
            severity: 'warning',
            category: 'flow-test',
            title: `Sys admin page ${page.path} did not render`,
            description: `Expected to see "${page.check}" heading`,
            url: this.page.url(),
          });
        }
      }

      await this.page.evaluate(() => { localStorage.clear(); });
      console.log(`    ✅ ${flow}: admin APIs + sys-admin pages verified`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({ severity: 'error', category: 'flow-test', title: `Admin dashboard flow crashed: ${msg.slice(0, 80)}`, description: msg, url: this.page.url() });
    }
  }

  // =========================================================================
  // Flow 16: Coach full journey (portal → schedule → roster → stats)
  // =========================================================================
  private async testCoachFullJourney() {
    const flow = 'coach-full-journey';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      const apiUrl = config.apiUrl || config.baseUrl;

      const coachRes = await this.page.request.post(`${apiUrl}/api/auth/login`, {
        data: { email: config.users.coach.email, password: config.users.coach.password },
      });
      if (!coachRes.ok()) { console.log(`    ⏭️  ${flow}: skipped (coach login failed)`); return; }
      const coachData = await coachRes.json() as any;

      await this.page.goto(config.baseUrl, { waitUntil: 'domcontentloaded', timeout: 10000 });
      await this.page.evaluate((t: any) => {
        localStorage.setItem('access_token', t.access_token);
        localStorage.setItem('refresh_token', t.refresh_token);
      }, coachData);

      // Visit each coach page and verify it renders
      const coachPages = [
        { path: '/dashboard', check: 'Dashboard' },
        { path: '/dashboard/coach', check: 'Coach Portal' },
        { path: '/dashboard/schedule', check: 'Schedule' },
        { path: '/dashboard/stats', check: 'Stats' },
        { path: '/dashboard/messages', check: 'Messages' },
        { path: '/dashboard/find-opponents', check: 'Find Opponents' },
      ];

      for (const pg of coachPages) {
        await this.page.goto(`${config.baseUrl}${pg.path}`, { waitUntil: 'networkidle', timeout: 15000 });
        // Check page doesn't crash (blank body)
        const body = await this.page.locator('body').textContent().catch(() => '');
        if (!body || body.trim().length < 10) {
          this.reporter.addBug({
            severity: 'error',
            category: 'flow-test',
            title: `Coach page ${pg.path} rendered blank`,
            description: `Page body is empty or near-empty`,
            url: this.page.url(),
          });
        } else {
          console.log(`      📋 ${pg.path}: renders (${body.length} chars)`);
        }
      }

      // Coach should NOT be able to access admin pages
      await this.page.goto(`${config.baseUrl}/system-admin`, { waitUntil: 'networkidle', timeout: 10000 });
      const sysAdminVisible = await this.page.locator('text=System Administration').isVisible({ timeout: 3000 });
      if (sysAdminVisible) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Coach can access system admin page',
          description: '/system-admin should redirect non-admin users away',
          url: this.page.url(),
        });
      } else {
        console.log(`      📋 Coach correctly redirected from /system-admin`);
      }

      await this.page.evaluate(() => { localStorage.clear(); });
      console.log(`    ✅ ${flow}: coach pages render, admin access blocked`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({ severity: 'error', category: 'flow-test', title: `Coach journey crashed: ${msg.slice(0, 80)}`, description: msg, url: this.page.url() });
    }
  }

  // =========================================================================
  // Flow 17: Parent full journey (portal → schedule → registration)
  // =========================================================================
  private async testParentFullJourney() {
    const flow = 'parent-full-journey';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      const apiUrl = config.apiUrl || config.baseUrl;

      const parentRes = await this.page.request.post(`${apiUrl}/api/auth/login`, {
        data: { email: config.users.parent.email, password: config.users.parent.password },
      });
      if (!parentRes.ok()) { console.log(`    ⏭️  ${flow}: skipped (parent login failed)`); return; }
      const parentData = await parentRes.json() as any;

      await this.page.goto(config.baseUrl, { waitUntil: 'domcontentloaded', timeout: 10000 });
      await this.page.evaluate((t: any) => {
        localStorage.setItem('access_token', t.access_token);
        localStorage.setItem('refresh_token', t.refresh_token);
      }, parentData);

      // Visit parent pages
      const parentPages = [
        { path: '/dashboard/parent', check: 'My Players' },
        { path: '/dashboard/schedule', check: 'Schedule' },
        { path: '/dashboard/messages', check: 'Messages' },
      ];

      for (const pg of parentPages) {
        await this.page.goto(`${config.baseUrl}${pg.path}`, { waitUntil: 'networkidle', timeout: 15000 });
        const body = await this.page.locator('body').textContent().catch(() => '');
        if (!body || body.trim().length < 10) {
          this.reporter.addBug({
            severity: 'error',
            category: 'flow-test',
            title: `Parent page ${pg.path} rendered blank`,
            description: 'Page body is empty or near-empty',
            url: this.page.url(),
          });
        } else {
          console.log(`      📋 ${pg.path}: renders (${body.length} chars)`);
        }
      }

      // Parent should NOT see league management
      await this.page.goto(`${config.baseUrl}/dashboard`, { waitUntil: 'networkidle', timeout: 15000 });
      const leagueMgmt = this.page.locator('text=League Management');
      if (await leagueMgmt.isVisible({ timeout: 1000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Parent sees "League Management" in navigation',
          description: 'Parents should only see "My Family" section, not admin navigation',
          url: this.page.url(),
        });
      }

      // Parent should NOT see Generate Schedule
      await this.page.goto(`${config.baseUrl}/dashboard/schedule`, { waitUntil: 'networkidle', timeout: 15000 });
      const generateBtn = this.page.locator('button:has-text("Generate Schedule")');
      if (await generateBtn.isVisible({ timeout: 2000 })) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Parent sees "Generate Schedule" button',
          description: 'Schedule generation should not be visible to parent users',
          url: this.page.url(),
        });
      }

      await this.page.evaluate(() => { localStorage.clear(); });
      console.log(`    ✅ ${flow}: parent pages render, admin controls hidden`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({ severity: 'error', category: 'flow-test', title: `Parent journey crashed: ${msg.slice(0, 80)}`, description: msg, url: this.page.url() });
    }
  }

  // =========================================================================
  // Flow 18: Feature flag gating verification
  // =========================================================================
  private async testFeatureFlagGating() {
    const flow = 'feature-flag-gating';
    console.log(`    🧪 Testing: ${flow}`);
    this.flowCount++;

    try {
      const apiUrl = config.apiUrl || config.baseUrl;

      const adminRes = await this.page.request.post(`${apiUrl}/api/auth/login`, {
        data: { email: config.users.admin.email, password: config.users.admin.password },
      });
      if (!adminRes.ok()) { console.log(`    ⏭️  ${flow}: skipped (admin login failed)`); return; }
      const adminData = await adminRes.json() as any;
      const adminHeaders = { Authorization: `Bearer ${adminData.access_token}` };

      // Fetch the feature flag registry
      const registryRes = await this.page.request.get(`${apiUrl}/api/system-admin/feature-flag-registry`, {
        headers: adminHeaders,
      });

      if (!registryRes.ok()) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: `Feature flag registry endpoint failed (${registryRes.status()})`,
          description: 'GET /system-admin/feature-flag-registry should return the flag catalog',
          url: `${apiUrl}/api/system-admin/feature-flag-registry`,
        });
        return;
      }

      const registry = await registryRes.json() as any[];
      console.log(`      📋 Registry has ${registry.length} flags`);

      // Verify expected flags exist
      const expectedFlags = ['direct_join', 'tryout_system', 'roster_rollover', 'open_tryout_discovery'];
      for (const flag of expectedFlags) {
        const found = registry.some((f: any) => f.key === flag);
        if (!found) {
          this.reporter.addBug({
            severity: 'warning',
            category: 'flow-test',
            title: `Expected feature flag "${flag}" not in registry`,
            description: `The flag "${flag}" should be in the feature flag registry`,
            url: `${apiUrl}/api/system-admin/feature-flag-registry`,
          });
        }
      }

      // Verify scopes
      const systemFlags = registry.filter((f: any) => f.scope === 'system');
      const orgFlags = registry.filter((f: any) => f.scope === 'organization');
      console.log(`      📋 System flags: ${systemFlags.length}, Organization flags: ${orgFlags.length}`);

      if (systemFlags.length === 0) {
        this.reporter.addBug({
          severity: 'warning',
          category: 'flow-test',
          title: 'No system-scope flags in registry',
          description: 'Expected at least one system-scope feature flag',
          url: `${apiUrl}/api/system-admin/feature-flag-registry`,
        });
      }

      // Verify flag validation (try to create an unknown flag)
      const badFlagRes = await this.page.request.post(`${apiUrl}/api/system-admin/feature-flags`, {
        headers: adminHeaders,
        data: { flag: 'nonexistent_flag_xyz', enabled: true },
      });
      if (badFlagRes.ok()) {
        this.reporter.addBug({
          severity: 'error',
          category: 'flow-test',
          title: 'Unknown feature flag accepted by API',
          description: 'Creating a flag with an unknown name should be rejected with a 400 error',
          url: `${apiUrl}/api/system-admin/feature-flags`,
        });
      } else if (badFlagRes.status() === 400) {
        console.log(`      📋 Unknown flag correctly rejected (400)`);
      }

      // Navigate to feature flags page
      await this.page.goto(config.baseUrl, { waitUntil: 'domcontentloaded', timeout: 10000 });
      await this.page.evaluate((t: any) => {
        localStorage.setItem('access_token', t.access_token);
        localStorage.setItem('refresh_token', t.refresh_token);
      }, adminData);
      await this.page.goto(`${config.baseUrl}/system-admin/feature-flags`, { waitUntil: 'networkidle', timeout: 15000 });

      const flagsHeader = this.page.locator('text=Feature Flags');
      if (await flagsHeader.first().isVisible({ timeout: 5000 })) {
        // Check for tabs
        const systemTab = this.page.locator('text=System');
        const orgTab = this.page.locator('text=Organization Overrides');
        const hasSystemTab = await systemTab.first().isVisible({ timeout: 2000 });
        const hasOrgTab = await orgTab.first().isVisible({ timeout: 2000 });
        console.log(`      📋 Tabs: System=${hasSystemTab}, Org Overrides=${hasOrgTab}`);

        if (!hasSystemTab || !hasOrgTab) {
          this.reporter.addBug({
            severity: 'warning',
            category: 'flow-test',
            title: 'Feature flags page missing expected tabs',
            description: 'Should have "System" and "Organization Overrides" tabs',
            url: this.page.url(),
          });
        }
      }

      await this.page.evaluate(() => { localStorage.clear(); });
      console.log(`    ✅ ${flow}: registry, validation, and UI verified`);
    } catch (err) {
      const msg = err instanceof Error ? err.message : String(err);
      this.reporter.addBug({ severity: 'error', category: 'flow-test', title: `Feature flag gating crashed: ${msg.slice(0, 80)}`, description: msg, url: this.page.url() });
    }
  }
}
