---
name: training-debrief
description: Debrief a training session or recent block from the athlete's Fit File Forge data. Use when the user asks how a run, ride, swim or workout went, whether they hit their reps or targets, why heart rate was high, or how a session compares with similar ones.
---

<!-- Draft: tool names match the planned Fit File Forge MCP server; update if they change. -->

To debrief a session:

1. Find it with `find_activities` (by date, sport or name) unless the user gave one. Confirm which session if more than one fits.
2. Call `get_activity` with the depth the question needs: laps for interval sessions, splits for steady runs, zones and drift for aerobic work.
3. If a planned workout existed for that day (`get_calendar`), compare what was run with what was planned, rep by rep.
4. For custom analysis or a chart, call `get_activity_series` for only the channels needed, then analyse it in code. Never estimate numbers you could compute.
5. Put the session in context with `get_training_status` only when load or fatigue is part of the question.

Answer in this order: one sentence with the verdict, then the evidence (reps, paces, heart rate, with units), then one practical suggestion. Use the athlete's own thresholds and zones from `get_athlete`, not age-based formulas. Name the data's limits plainly: no sleep, HRV or stress data is available. Pain or injury questions get a training-load answer and a pointer to a professional, never a diagnosis.
