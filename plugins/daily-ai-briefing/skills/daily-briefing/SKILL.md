---
name: Daily AI Briefing
description: This skill should be used when the user asks to "run my daily briefing", "generate today's AI briefing", "get the daily AI news", "morning briefing", "AI briefing", or mentions wanting a daily AI news summary. It generates a structured markdown briefing by scanning major tech and AI news sources.
---

# Daily AI Briefing

Generate a structured daily briefing of the most significant AI and technology news. Scan 10+ major sources including The Verge, TechCrunch, Ars Technica, Hacker News, MIT Technology Review, VentureBeat, OpenAI blog, Anthropic blog, Google AI blog, DeepMind blog, and other relevant outlets.

## Output

Save the finished briefing to:

```
/Users/ericahruby/code/daily-ai-briefing/outputs/YYYY-MM-DD-ai-briefing.md
```

Accept an optional date argument. Default to today's date if none is provided.

## Workflow

1. **Scan sources** -- Fetch headlines and summaries from AI/tech news sources.
2. **Filter for significance** -- Keep only stories with meaningful impact on the AI/tech landscape. Discard minor updates, routine product patches, and low-signal content.
3. **Extract details** -- For each significant story, gather key facts, quotes, and context.
4. **Synthesize summary** -- Write a concise, structured markdown briefing covering the top stories.
5. **Write markdown file** -- Save the final briefing to the outputs directory using the date-based filename.

## Usage

Run the `/daily-briefing` command to trigger this same workflow directly. The skill and the command invoke the same process.

## Notes

- Do not git commit the output. The scheduled automation handles commits separately.
- Keep the briefing factual and concise. Avoid editorializing.
