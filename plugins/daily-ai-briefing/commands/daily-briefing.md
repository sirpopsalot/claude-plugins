---
name: daily-briefing
description: Generate a daily AI news briefing by scanning major tech sources, filtering for significance, and producing a structured markdown summary.
---

# Daily AI Briefing

This command generates a daily AI news briefing by scanning major sources, filtering for significance, and writing a structured markdown summary.

## Date Argument

This command accepts an optional date argument. Examples:

- `/daily-briefing` — uses today's date
- `/daily-briefing 2026-02-20` — generates the briefing for February 20, 2026

If a date argument is provided, use that date instead of today for:
1. Which day's news to search for (look for articles published on that date)
2. The output filename (`YYYY-MM-DD-ai-briefing.md`)
3. The briefing title date

If no date argument is provided, default to today's date.

---

## Instructions

Run the following steps in order.

### Step 1: Scan Sources for AI News

Search each of the following 10 sources for AI-related articles published on the **target date**. Scan all sources — if a source is unavailable or has no AI news that day, skip it silently and move on.

**Sources:**
1. The Verge — search for AI news at theverge.com
2. TechCrunch — search for AI news at techcrunch.com
3. Ars Technica — search for AI news at arstechnica.com
4. Reuters — search for technology/AI news at reuters.com
5. AI News — search for articles at artificialintelligence-news.com
6. Anthropic Blog — check blog.anthropic.com for new posts
7. OpenAI Blog — check openai.com/blog for new posts
8. Google DeepMind Blog — check deepmind.google/blog for new posts
9. VentureBeat — search for AI news at venturebeat.com/ai
10. MIT Technology Review — search for AI news at technologyreview.com

**How to identify AI articles:**
- Article headline or content contains AI-related keywords: AI, artificial intelligence, machine learning, LLM, GPT, neural network, deep learning, generative AI, ChatGPT, Claude, Gemini, foundation model, large language model, NLP, computer vision, AI agent, AI model, transformer, diffusion model
- OR article appears in the source's AI/technology section

**Exclude articles that are primarily about:**
- Cryptocurrency or blockchain
- Robotics (unless directly AI-focused)
- Semiconductors or chip manufacturing (unless directly AI-focused)

**Output from this step:** A candidate list of articles, each with: headline, URL, source name, and publication date.

---

### Step 2: Filter for Significance

Review the full candidate list from Step 1. Select the most significant stories based on these criteria:

- **Industry impact** — Does this affect a large number of people, companies, or the AI field broadly?
- **Novelty** — Is this genuinely new, or a rehash of old news?
- **Scale of announcement** — Major product launch vs. minor update?
- **Relevance to practitioners** — Would someone working in or with AI care about this?

**Rules:**
- No fixed number of stories — include whatever clears the significance bar
- All AI topics are weighted equally (no preference for LLMs over computer vision, etc.)
- Deduplicate: if the same story appears across multiple sources, flag it as a multi-source story (it will be merged later)
- On slow news days with only 1-2 stories, still proceed — produce the briefing anyway

**Output from this step:** A curated shortlist of significant articles with duplicates flagged.

---

### Step 3: Read and Extract Key Details

For each article on the curated shortlist, read the full article and extract detailed structured notes.

**For each article, capture:**
- Headline
- Source name and publication date
- Detailed summary (3-5 sentences)
- Key facts: who is involved, what happened, why it matters
- Notable quotes or data points
- Implications: what this means going forward

**If an article is paywalled or the full text is unavailable:** Extract the headline and whatever summary/blurb is publicly available. Do not skip the article entirely.

**Output from this step:** Structured notes for each article.

---

### Step 4: Synthesize into Structured Summary

Using the structured notes from Step 3, draft the daily briefing.

**Grouping and merging rules:**
- If the same story was covered by multiple sources, merge into a single entry and cite all sources
- If stories are closely related but distinct (e.g., two companies announcing similar features), group them under a shared theme heading
- If stories don't cluster into clear themes, list them individually ordered by significance

**Writing guidelines:**
- **Tone:** Neutral and concise. Informative, not opinionated.
- Each story gets a "**Why it matters:**" line explaining its significance
- Order stories by significance (most important first)
- Write a one-sentence overview at the top that captures the day's dominant theme or biggest story

**Structure the briefing as:**
1. **Top Story** (if one story clearly dominates the day) — full summary with why it matters
2. **Themed sections** — grouped stories under descriptive theme headings
3. **Quick Hits** — minor but noteworthy items as one-liners

**Output from this step:** A cohesive daily briefing draft.

---

### Step 5: Write to Markdown File

Format the briefing draft into a clean `.md` file using this exact template structure:

```markdown
# Daily AI Briefing — [Full Date, e.g., February 9, 2026]

> [One-sentence daily overview]

**Sources checked:** [comma-separated list of sources that had articles] | **Stories covered:** [count]

---

## Top Story
### [Headline]
[Detailed summary — 3-5 sentences]

**Why it matters:** [1-2 sentences on significance and implications]

*Sources: [source1], [source2]*

---

## [Theme Heading]
### [Headline]
[Summary — 2-4 sentences]

**Why it matters:** [1-2 sentences]

*Source: [source]*

---

## Quick Hits
- **[Headline]** — [One-line summary] (*[Source]*)
- **[Headline]** — [One-line summary] (*[Source]*)
```

**File naming convention:** `YYYY-MM-DD-ai-briefing.md` (using the target date)

**Save location:** Write the file to `/Users/ericahruby/code/daily-ai-briefing/outputs/YYYY-MM-DD-ai-briefing.md`

**Output from this step:** A formatted `.md` file saved to disk.

---

## Output Format

The workflow produces a single file:

- **File:** `/Users/ericahruby/code/daily-ai-briefing/outputs/YYYY-MM-DD-ai-briefing.md`
- **Format:** Markdown
- **Structure:** Title -> one-sentence overview -> metadata line -> Top Story -> themed sections -> Quick Hits
- **Tone:** Neutral, concise, with "why it matters" per story
- **Links:** Each story links to the original article(s)
