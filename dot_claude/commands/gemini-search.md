## Gemini Search

`gemini` is google gemini cli.

**MUST** When this command is called, ALWAYS use gemini cli for search.

**DO NOT** use Claude Code built-in `Web_Search` tool.

When web search is needed, you MUST use `gemini --prompt` via Task Tool.

Run web search via Task Tool with `gemini --prompt 'WebSearch: <query>'`

Run

```bash
gemini --prompt "WebSearch: <query>"
```
