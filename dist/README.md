# Distribution Files

This directory contains ready-to-use zip files for skills.

## Generated Files

This directory is automatically created by `make zip-skills` and is **gitignored** (except this README).

### Skills

Individual skill zip files in `skills/` are ready to upload to Claude.ai:

1. Go to **Claude.ai → Settings → Skills → Upload Skill**
2. Select a skill zip file (e.g., `skills/work-on-ticket.zip`)
3. The skill will be available in your Claude.ai account

## Regenerating Distributions

To regenerate skill zip files:

```bash
make zip-skills
```

## CI/CD

These distribution files are automatically created in GitHub Actions and uploaded as artifacts with each build.
