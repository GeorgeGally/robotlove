BOTS = {
    "GPTBot": {
        "owner": "OpenAI",
        "intent": "LLM training",
        "relationship": "arrived 2023, took everything, never asked",
        "default_rule": "Disallow",
        "tone": "complicated",
    },
    "CCBot": {
        "owner": "Common Crawl",
        "intent": "LLM training corpus",
        "relationship": "fed your words to GPT-3 before GPT-3 existed",
        "default_rule": "Disallow",
        "tone": "resigned",
    },
    "archive.org_bot": {
        "owner": "Internet Archive",
        "intent": "preservation",
        "relationship": "oldest visitor, has snapshots going back to 2003",
        "default_rule": "Allow",
        "tone": "warm",
    },
    "Googlebot": {
        "owner": "Google",
        "intent": "search indexing",
        "relationship": "purely transactional, longest commercial relationship",
        "default_rule": "Allow",
        "tone": "neutral",
    },
    "ClaudeBot": {
        "owner": "Anthropic",
        "intent": "LLM training",
        "relationship": "awkward — the tool being used to write this also sends this bot",
        "default_rule": "Disallow",
        "tone": "self-referential",
    },
    "Bingbot": {
        "owner": "Microsoft",
        "intent": "search indexing",
        "relationship": "always there, never the point",
        "default_rule": "Allow",
        "tone": "barely acknowledged",
    },
}

BOT_NAMES = list(BOTS.keys())
