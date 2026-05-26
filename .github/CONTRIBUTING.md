# Contributing

Thanks for your interest in contributing to claude-security-agents!

## Adding a New Agent

1. Create a Markdown file in `agents/` with the category prefix: `blue-`, `red-`, `purple-`, `devsecops-`, `grc-`, `ir-`
2. Follow the frontmatter format:
   ```yaml
   ---
   name: category-short-name
   description: "Triggered by 'keyword1', 'keyword2'. One-line purpose."
   tools: Read, Grep, Glob
   model: sonnet
   ---
   ```
3. Include these body sections in order:
   - **Role** — What this agent does (2-3 sentences)
   - **Methodology** — Numbered steps
   - **Output Format** — What the agent produces
   - **Constraints** — Hard rules and boundaries
   - **Completion Criteria** — Definition of done
   - **Anti-Patterns** — What NOT to do
4. Keep it between 40-80 lines
5. Write in English
6. No hardcoded IPs, paths, or environment-specific references
7. Add the agent to the `ALL_AGENTS` array in `install.sh`
8. Add it to the appropriate table in `README.md`
9. Add it to `docs/TIER-SYSTEM.md`

## Improving an Existing Agent

- Fix methodology gaps or add missing steps
- Add coverage for tools or techniques not yet mentioned
- Improve output format templates
- Fix anti-patterns based on real-world usage

## Pull Request Guidelines

- One agent per PR (unless they're closely related)
- Test that `install.sh` still works after your changes
- Explain your security domain expertise in the PR description
- Include an example prompt that demonstrates routing to your agent

## Tier Assignment

- **Tier 1**: Agent only analyzes, advises, or produces documents. No `Bash` tool, no target interaction.
- **Tier 2**: Agent can execute commands or write files. If offensive (red/purple), must reference `_scope-guard.md` in Constraints.

## Code of Conduct

Be respectful. These tools are for authorized security work only. PRs adding agents for malicious purposes will be rejected.
