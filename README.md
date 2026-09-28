# 🎓 EduTrack • Smart Attendance Calculator, OD Simulator & AI Advisor

**EduTrack** is an advanced, unified web application designed to solve academic attendance monitoring, detention risk prediction, and leave planning. Built as an end-to-end integrated solution for **Phase 1 (The Core Calculator)** and **Phase 2 (Visuals, Leaves, & The AI Assistant)**.

---

## 🚀 Live Demo & Quick Launch

### Option 1: Direct Browser Launch (Zero Dependencies)
Simply double-click [`index.html`](file:///d:/projects/attendance-calculator/index.html) or open it in any web browser (Chrome, Edge, Brave, Safari, Firefox).

### Option 2: Run Local Web Server (PowerShell)
Open PowerShell in this directory and execute:
```powershell
powershell -ExecutionPolicy Bypass -File .\server.ps1
```
This starts a lightweight HTTP server on `http://localhost:5500/` and automatically opens your browser.

### Option 3: Instant Live Deployment (For Submission Link)
You can deploy this directory to a live public URL in seconds:
1. **Netlify Drop**: Drag and drop the `attendance-calculator` folder into [app.netlify.com/drop](https://app.netlify.com/drop) for an instant live URL (e.g., `https://edutrack-advisor.netlify.app`).
2. **GitHub Pages**: Push this directory to a GitHub repository and turn on GitHub Pages in repository settings.
3. **Surge.sh**: Run `npx surge .` inside the folder to publish instantly.
4. **Vercel**: Run `npx vercel` or import from GitHub.

---

## 📋 Comprehensive Feature Breakdown

### 🔹 Phase 1: The Core Calculator
1. **10 Class Section Timetable Integration**:
   - Includes real schedules for **10 engineering class sections** (CSE-A, CSE-B, CSE-C, ECE-A, ECE-B, MECH-A, CIVIL-A, IT-A, AI&DS, EEE).
   - Each section has distinct weekly course rosters (including Chemistry, Mathematics, Data Structures, Digital Design, Networks, and practical laboratories).
   - **Google Drive Dataset & Custom JSON Importer**: Allows students or evaluators to sync their own Google Drive dataset URL or paste custom timetable JSON.

2. **Date Intelligence**:
   - **Today's Date Auto-detection**: Reads system date and maps working calendar days against public holidays and weekends.
   - **Preferred Future Date Planning Horizon**: Lets students enter any target date (e.g., mid-terms, symposium week) to calculate milestone attendance targets.
   - **Semester End Date**: Configured before November (**October 31, 2026**).

3. **Core Mathematical Calculations**:
   - **Total Classes Left**: Calculates exact remaining periods per subject and overall across the semester.
   - **Danger Zone Minimum ($\ge 75\%$)**: Calculates the exact number of remaining classes the student must attend to stay out of the danger zone.
   - **Safe Bunk Buffer**: If already safe, indicates exactly how many classes the student can safely skip without falling below 75%.
   - **Elite Target ($\ge 90\%$)**: Calculates classes required to reach or maintain honors attendance ($>90\%$).

4. **The Warning System: "Irreversible Detention" Alert**:
   - If a student's current attendance is mathematically impossible to recover to $75\%$ before November even with 100% attendance in all remaining classes, the system triggers:
     - 🚨 **High-urgency pulsating Crimson Alert Banner**.
     - 🔊 **Synthesized Acoustic Siren (Web Audio API)**.
     - 📊 **Deficit Breakdown Card** specifying the mathematical maximum achievable percentage and shortfall.

---

### 🔹 Phase 2: Visuals, Leaves, & The AI Assistant

1. **Visual Health Dashboard (Chart.js)**:
   - **Subject Comparison Bar Chart**: Side-by-side visualization of current attendance vs. maximum attainable attendance against the 75% danger and 90% elite thresholds.
   - **Semester Breakdown Doughnut Chart**: Interactive distribution of Attended Classes, Missed Classes, and Remaining Semester Classes.
   - **Projected Trajectory Line Chart**: 4-scenario simulation modeling final semester outcomes under 100% attendance, 75% target pace, 50% attendance, and complete bunking.

2. **The OD Simulator (On-Duty & Medical Leaves)**:
   - Input On-Duty days for **Hackathons, Technical Symposiums, Sports Meets, Cultural/NSS**, or **Medical Leaves**.
   - Option to apply credits across all subjects or to a single target course.
   - **Instant Dynamic Recalculation**: Live Before-vs-After comparison table showing percentage delta boost and highlighting courses rescued from detention.

3. **The "Attendance Advisor" Floating AI Chatbot**:
   - Sleek floating AI trigger button with pulse animation and unread status.
   - Natural language query processing engine answering queries such as:
     - *"If I take a 3-day sick leave starting tomorrow, will my Chemistry attendance drop below 75%?"*
     - *"How many classes can I bunk in Maths?"*
     - *"Am I in danger of irreversible detention before November?"*
   - Analyzes real upcoming timetable dates, calculates exact periods, and provides personalized numerical advice and warnings.

---

## 🗂️ Project Directory Structure

```text
d:\projects\attendance-calculator/
├── index.html         # Unified single-page responsive application UI
├── app.js             # Core math calculation engine, OD simulator & AI Advisor
├── timetables.js      # 10 Class Sections timetable dataset & academic calendar
├── styles.css         # Glassmorphism, alert animations & styling
├── server.ps1         # Zero-dependency PowerShell local HTTP server
├── validate.ps1       # Automated verification test script
└── README.md          # Project documentation & deployment guide
```

---

## 🧪 Mathematical Formulation

For any course with $T_c$ classes conducted so far and current attendance $P\%$:
1. Attended classes: $A_c = \text{round}\left(\frac{P \times T_c}{100}\right)$
2. Missed classes: $M_c = T_c - A_c$
3. Remaining classes until semester end: $R$
4. Total semester classes: $T_{sem} = T_c + R$
5. Max attainable percentage: $\text{Max}\% = \frac{A_c + R}{T_{sem}} \times 100$
6. **Irreversible Detention condition**: $\text{Max}\% < 75\%$
7. Classes needed to stay out of danger zone:
   $$N_{75} = \max\left(0, \left\lceil 0.75 \times T_{sem} \right\rceil - A_c\right)$$
   If $N_{75} > R \implies \text{Mathematically Impossible (Detention)}$
   If $N_{75} \le 0 \implies \text{Safe Bunk Buffer} = (A_c + R) - \lceil 0.75 \times T_{sem} \rceil$
