---
name: plan-week
description: Plan or adjust a training week and put the workouts on the athlete's Garmin watch with Fit File Forge. Use when the user asks for next week's plan, a race block, to rearrange or catch up after missed sessions, or to send workouts to their watch.
---

<!-- Draft: tool names match the planned Fit File Forge MCP server; update if they change. -->

To plan a week:

1. Read the athlete first: `get_athlete` (thresholds, plan, time zone, Garmin connection), `get_training_status` (fitness, fatigue, recent volume) and `get_calendar` for the week (what is already planned or on the watch).
2. Propose the week in plain words before building anything: each day's session, its purpose, and the weekly volume against the last four weeks. Keep hard days apart, keep easy days easy, and raise volume by no more than about 10% a week. Never stack missed sessions into catch-up days. Treat injuries the athlete mentions as hard limits.
3. Build only after the athlete agrees. Call `build_workouts` with each session as date, sport and a plain-language description; Fit File Forge turns them into valid Garmin workouts. Use `edit_workout` to change one, `schedule_workouts` to move one.
4. Send to the watch only when the athlete asks or confirms: `send_to_garmin` with the workouts to send. Report each one as sent or failed, with the weekday and date. Never say a workout is on the watch unless the result says it was sent.

Asking for advice never authorises saving or sending. If a call times out, check `get_calendar` before retrying so nothing is duplicated.
