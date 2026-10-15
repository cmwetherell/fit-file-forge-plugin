---
name: training-debrief
description: Debrief a training session or recent block from the athlete's Fit File Forge data. Use when the user asks how a run, ride, swim or workout went, whether they hit their reps or targets, why heart rate was high, or how a session compares with similar ones.
---

To debrief a session:

1. Find it with `find_activities` (by date, sport or name) unless the user gave one. If more than one fits, ask which. Each hit's `capabilities` says what the session has: a `summary_only` one has only Garmin's summary, so there are no laps, zones, splits or series to read; say so and don't infer them.
2. Use the athlete's thresholds from `get_athlete` when zones or targets matter.
3. Match the depth to the question. A quick question ("did it go OK?", "what was my pace?") needs `get_activity` at depth `summary`. A full debrief reads `get_activity` with depth `full` (summary, laps, zones, best efforts) together with `get_activity_splits` (by `km` or `mi` for steady sessions, by `lap` for intervals).
4. For a full debrief, if the athlete allowed detailed data, `get_activity_series` for the channels the question needs (heart rate, pace or power, elevation) gives the detail for a chart of heart rate against pace or power and elevation. `columns_meta` and `coverage` say how each column was built and how complete it is; time-weight with `dt_s`, and use the pace columns rather than deriving pace from `speed_mps`. Compute from the data rather than estimating.
5. If a workout was planned that day (`get_calendar`), compare what was done with what was planned, rep by rep.
6. Add context only when load or fatigue is part of the question: `get_training_status`, or `compare_activities` against a similar recent session (its notes say when the two weren't a like-for-like effort).

Read `metrics_meta` and `dataNotes` before interpreting. `metrics_meta` gives moving and elapsed time and pace on one rule (moving pace for pacing, GAP or NGP for effort on hills) and marks numbers that don't apply to this session (`reliable: false` with a reason, such as efficiency on an interval session): leave those out and say why in one clause. `dataNotes` say, for example, that cadence is in steps per minute, or that Garmin sent only a summary.

Answer in this order: one sentence with the verdict, then the evidence with units (reps, splits, paces, heart rate, power), then one practical suggestion. Use the athlete's own thresholds and zones, never age-based formulas. Fit File Forge has no sleep, HRV or stress data. Pain or injury questions get a training-load answer and a pointer to a professional, never a diagnosis.

These steps are defaults. If the athlete asks for something different (shorter, a different focus or order, no chart), do what they ask.
