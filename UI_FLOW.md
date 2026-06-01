# Doctor App (Patient Portal) — UI Flow Documentation

This document describes how navigation and screens are wired in the Flutter project (`doctor_app`). It reflects the code under `lib/` as of the documentation date.

---

## Architecture Overview

| Layer | Implementation |
|--------|----------------|
| **Routing** | Named routes via `MaterialApp.onGenerateRoute` → `AppGenerateRoute.onGenerateRoute` (`lib/core/app_routes/generate_route.dart`). Routes use **`CupertinoPageRoute`** (iOS-style transitions). |
| **Unknown route** | If `settings.name` does not match any registered route, the app falls back to **`LoginScreen`**. |
| **State** | **flutter_bloc** — global providers are registered in `main.dart` (`MultiBlocProvider`). |
| **Layout scaling** | **flutter_screenutil** with design size `390 × 844`. |
| **Primary shell** | **`NaveBar`** — bottom navigation + indexed body content (not a nested router). |

---

## Application Entry & Bootstrap

1. **`main()`**  
   - Runs `MyApp`, sets portrait orientation, styles the Android system navigation bar, and calls **`LocalStorage.clearAllData()`** on startup (clears persisted local data each cold start — relevant for testing/debug behavior).

2. **`SplashScreen`** (`AppRoutes.splashScreen` → `'/'`)  
   - Shows branding for ~3 seconds.  
   - **`Navigator.pushReplacementNamed(context, AppRoutes.naveBar)`** — user lands on the main shell (`NaveBar`), not returning to splash.

---

## Main Shell: Bottom Navigation (`NaveBar`)

**File:** `lib/screens/nave_bar/nave_bar.dart`

Four tabs (indices `0`–`3`):

| Index | Label (UI) | Logged out (`token == ''`) | Logged in (`token` present) |
|-------|------------|----------------------------|-----------------------------|
| 0 | Home | `HomeScreen` | `DashbordScreen` |
| 1 | My card | `NfcCardPage` | `NfcCardPage` |
| 2 | Records | `SessionRecord` | `SessionRecord` |
| 3 | Account | **`LoginScreen`** | **`ProfileScreen`** |

**Auth behavior**

- `NaveBarBloc` reads the stored auth **`token`** from `ProfileLocalRepo` on each `NaveBarIndexEvent`.
- **Guest:** Tapping tabs **1, 2, or 3** forces index **`3`** (login), except tab **0** which stays home. So guests are pushed to login when leaving Home (except Home itself).
- **Logged in:** All four tabs switch normally.

**Note:** The bottom bar labels are “Home / My card / Records / Account”; there is **no separate tab** named “Packages” or “Billing” in code — packages and invoices are reached from **Home** or **Dashboard** quick actions / stacks.

---

## Guest Flow (Unauthenticated)

### Home (`HomeScreen`)

**File:** `lib/screens/home/home_screen.dart`

- Loads **`HomeBloc`** (`HomeLoadEvent`): sliders + therapy packages from API/local repos.
- **App bar:** `HomeAppBar` — “Guest User”, **Sign In** → **`LoginScreen`** (`AppRoutes.loginScreen`).
- **Therapy Session Packages** section → **View all** → **`AllPackagesScreen`** (`AppRoutes.allPackagesScreen`).
- Package cards (`packages_widget`) → **Book** → **`LoginScreen`** (guest must sign in).
- **Second slider** (video carousel) → tap opens **`VideoPlayerScreen`** with `arguments: {"currentIndex": currentPage}`.
- **FAB:** WhatsApp launcher (`url_launcher`).

### Login (`LoginScreen`)

**File:** `lib/screens/auth_screen/login_screen/login_screen.dart`

- **Forget password?** → **`ResetPasswordScreen`** (`AppRoutes.restPassword`).
- **Success:** **`Navigator.pushNamedAndRemoveUntil(..., AppRoutes.naveBar, ...)`** — clears stack and returns to shell; tab bodies swap to **logged-in** widgets because token is now present.

---

## Authenticated Flow (Logged In)

### Dashboard (`DashbordScreen`) — replaces Home on tab 0

**File:** `lib/screens/dashboard_screen/dashbord_screen.dart`

Loaded after login when **Home** tab shows dashboard instead of `HomeScreen`.

**Header row**

- Avatar / name → **`MyProfileScreen`** (`AppRoutes.myProfileScreen`).
- Search icon → **`SearchScreen`** (`AppRoutes.searchScreen`) — placeholder UI (search field only).

**Balance card**

- Wallet balance (toggle visibility), totals (total / paid / remaining), circular progress (paid vs total).

**Quick Overview** — five tiles; taps navigate **by name**:

| Tile label | Route constant | Screen |
|------------|----------------|--------|
| Visits | `visitsDetailScreen` | `VisitsDetailScreen` |
| Active packages | `packagesDetailScreen` | `PackagesScreen` |
| Assessments | `assessmentScreen` | `AssessmentDetailScreen` |
| Invoice | `invoiceDetailScreen` | `InvoiceDetailScreen` |
| Sessions | `sessionsDetailScreen` | `SessionDetailScreen` |

**Session progress** section

- Shows package/session progress using patient stats (implementation in same file).

**Pull-to-refresh:** dispatches **`DashboardRefreshDataEvent`**.

---

### Records Tab (`SessionRecord`)

**File:** `lib/screens/session_record/session_record.dart`

- Loads **`ProfileBloc`** (`MyProfileEvent`) for **`CurrentPatientModel`** and visit list.
- **Two inner modes** controlled by local state `isVisitDetail`:
  - **`Session Records`**: summary + session progress style blocks.
  - **`Total visits`**: list of visits with therapist, date, type, **Visit Details** button.
- **Visit Details** → **`Navigator.push`** to **`SessionNotes`** (not only named route; instantiated with **`visitId`** and **`isConsultation`** derived from visit: `consultant != null` ⇒ consultation visit).

**Back behavior:** `PopScope` sends **`NaveBarIndexEvent(index: 0)`** to return to first tab when appropriate.

---

### Visit Detail Hub (`SessionNotes`)

**File:** `lib/screens/session_record/session_notes.dart`

Title: **“Visit detail”**. Routes registered as `AppRoutes.notesScreen` map to **`SessionNotes()`** without constructor args in **`generate_route.dart`**; **in-app navigation uses `CupertinoPageRoute` with parameters**, which is the path that supplies `visitId` / `isConsultation`.

**Rows (consultation visits only for first two)**

1. **History Tracker** — dispatches **`HistoryTrackerEvent`** with `visitId` + token, then **`Navigator.pushNamed` → `historyTrackerScreen`** (`HistoryTrackerScreen`).
2. **Consultant Assessment** — **`Navigator.pushNamed` → `assessmentScreen`** with **`arguments: visitId`** (string).
3. **Therapy Session** — **`Navigator.pushNamed` → `sessionsDetailScreen`** with **`arguments: visitId`**.

*(Assistant Manager route exists in comments only.)*

---

### Standalone Routed Screens (from `generate_route.dart`)

| Route name | Widget | Typical entry |
|------------|--------|----------------|
| `allPackagesScreen` | `AllPackagesScreen` | Guest Home → View all |
| `packagesDetailScreen` | `PackagesScreen` | Dashboard tile |
| `videoPlayerScreen` | `VideoPlayerScreen` | Home second slider |
| `updateProfile` | `UpdateProfile` | My Profile → edit |
| `profileScreen` | `ProfileScreen` | Registered; shell uses same widget instance pattern via `NaveBar` list |
| `loginScreen` | `LoginScreen` | Guest home / packages |
| `restPassword` | `ResetPasswordScreen` | Login |
| `myNFCCardScreen` | `NfcCardPage` | Named route exists; tab also embeds `NfcCardPage` |
| `myProfileScreen` | `MyProfileScreen` | Dashboard avatar, Profile → My Profile |
| `notesScreen` | `SessionNotes()` | Registered without args; **functional navigation uses push with args** |
| `visitsDetailScreen` | `VisitsDetailScreen` | Dashboard Visits tile |
| `invoiceDetailScreen` | `InvoiceDetailScreen` | Dashboard Invoice tile |
| `assessmentScreen` | `AssessmentDetailScreen` | Dashboard Assessments tile + Visit detail |
| `mapScreen` | `LocationScreen` | Profile → Location |
| `sessionsDetailScreen` | `SessionDetailScreen` | Dashboard Sessions tile + Visit detail |
| `historyTrackerScreen` | `HistoryTrackerScreen` | Visit detail → History Tracker |
| `searchScreen` | `SearchScreen` | Dashboard search |

**Deep screens**

- **`VisitsDetailScreen`**: list of visits from **`VisitDetailBloc`**; **My visit** app bar; refresh.
- **`AssessmentDetailScreen`**, **`SessionDetailScreen`**, **`InvoiceDetailScreen`**: consume **`ModalRoute.of(context)?.settings.arguments`** where implemented (visit id passed from dashboard or visit detail).
- **`HistoryTrackerScreen`**: loads via bloc event with visit id from **`SessionNotes`** navigation.

---

### Profile Tab (`ProfileScreen`)

**File:** `lib/screens/profile_screens/profile_screen.dart`

- **`My Profile`** → **`MyProfileScreen`**.
- **`My Card`** → **`Navigator.push` → `NfcCardPage(fromProfile: true)`** (not the named route).
- **`Location`** → **`LocationScreen`** (`mapScreen`).
- **Logout** → uses **`LoginBloc`** / **`NaveBarBloc`** pattern (see file; clears session and resets nav).

**Back:** `PopScope` switches bottom nav to index **0** when system back would exit.

---

### My Profile (`MyProfileScreen`)

**File:** `lib/screens/profile_screens/my_profile.dart`

- Avatar edit affordance → **`UpdateProfile`** (`updateProfile`).
- Displays patient fields from **`ProfileBloc`** / **`CurrentPatientModel`**.

---

### NFC Card (`NfcCardPage`)

**File:** `lib/screens/nfc_card/nfc_card.dart`

- Shown as tab **My card** and optionally from Profile with **`fromProfile`** for behavior/UI tweaks.

---

## Data & UI Coupling (High Level)

- **Patient / dashboard aggregate:** `DashboardBloc` + `PatientRepoImpl` / local stores — **`DashbordScreen`**.
- **Profile + visits list on Records:** **`ProfileBloc`** + **`MyProfileEvent`** — **`SessionRecord`**, **`ProfileScreen`**, **`MyProfileScreen`**.
- **All visits list (dashboard tile):** **`VisitDetailBloc`** — **`VisitsDetailScreen`**.
- **History:** **`HistoryTrackerBloc`** + repo — **`HistoryTrackerScreen`**.
- **Consultant assessment:** **`ConsultantAssessmentBloc`** — **`AssessmentDetailScreen`**.
- **Therapy sessions:** **`TherapySessionBloc`** — **`SessionDetailScreen`**.
- **Invoices:** **`InvoiceDetailScreen`** + dashboard patient **`recentInvoices`**.
- **Home marketing content:** **`HomeBloc`** — sliders + **`AllPackagesWidget`**.

Exact API endpoints are centralized under `lib/core/app_keys/api_keys.dart` and `lib/data/api_service/`.

---

## Diagram (Simplified)

```
Splash (/)
   └── replace → NaveBar (shell)
            ├── Tab0: HomeScreen (guest) | DashbordScreen (auth)
            ├── Tab1: NfcCardPage
            ├── Tab2: SessionRecord → SessionNotes (visit detail) → History / Assessment / Sessions
            └── Tab3: LoginScreen (guest) | ProfileScreen (auth)

Guest: Home → Login | All Packages | Video | WhatsApp FAB
Auth: Dashboard → My Profile | Search | Quick tiles (Visits, Packages, Assessment, Invoice, Sessions)
Profile → My Profile | NFC Card | Location | Logout
```

---

## Files Worth Reading First

| Purpose | Path |
|---------|------|
| Route table | `lib/core/app_routes/generate_route.dart` |
| Route name constants | `lib/core/app_routes/routes_name.dart` |
| Bottom shell | `lib/screens/nave_bar/nave_bar.dart` |
| App entry | `lib/main.dart` |

---

*Canonical copy also lives at `docs/UI_FLOW.md`. Generated from codebase structure; adjust if routes or widgets are renamed.*
