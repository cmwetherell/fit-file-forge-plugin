# Fit File Forge for Claude

> **Status: in development.** Not yet listed in the Claude directory or the ChatGPT Plugin Directory. The connector address below goes live at launch.

Fit File Forge lets you ask about your training and put workouts on your Garmin watch from a conversation. Ask how this morning's intervals went, whether your fitness is building, or what's realistic for Sunday's 10K, and Claude answers from your own data. Describe a workout in plain words ("4 × 8 min at threshold on Thursday") and Fit File Forge builds a valid Garmin workout and, when you confirm, sends it to your watch.

## Use it

1. Install the plugin, then connect **Fit File Forge** from the plugin's Connectors tab and sign in. New accounts start a 14-day trial; the connector is part of Fit File Forge Pro.
2. Ask about a session, a week or a block, for example:
   - "How did my last run go? Did I hit the reps?"
   - "Compare my last four long runs: pace, heart rate and drift."
   - "Plan next week: 6 hours, long run Saturday, travelling Tuesday and Wednesday."
   - "Put a 4 × 8 min threshold run on my watch for Thursday."
3. Nothing is sent to your watch until you confirm it.

The skills in this plugin tell Claude how to debrief a session and how to plan a week safely with Fit File Forge's tools.

## Data

The plugin's connector talks to `mcp.fitfileforge.com` on your behalf after you sign in and agree to share. It returns your training summaries, laps and splits, the metrics Fit File Forge computes (fitness and form, time in zones, best efforts, race predictions), your planned workouts, and, if you allow it, a cleaned time series of heart rate, pace, power, cadence and elevation. It never returns GPS locations, the original activity files, or health data such as sleep or HRV, which Fit File Forge does not collect. What Claude receives is handled under Anthropic's terms and your Claude settings. Disconnect any time in Claude or in Fit File Forge → Settings → Connected apps.

- Privacy policy: https://www.fitfileforge.com/privacy
- Terms: https://www.fitfileforge.com/terms

Garmin and Garmin Connect are trademarks of Garmin Ltd. or its subsidiaries. Fit File Forge is not sponsored or endorsed by Garmin. Training information is informational, not medical advice.

## License

MIT, see [LICENSE](LICENSE).
