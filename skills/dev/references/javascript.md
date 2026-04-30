# JavaScript / TypeScript

**Only use `bun`. Never use `npm`, `yarn`, `pnpm`, or `npx`.**

- Project commands: `bun run`, `bun install`, `bun add`, `bun remove`
- One-off scripts: `bun run script.ts`
- On the fly: `bun -e "code"` (e.g. `bun -e "console.log(await fetch('https://httpbin.org/ip').then(r => r.json()))"`)
- For CLI tools: `bunx <tool>` (e.g. `bunx prettier --write .`)
