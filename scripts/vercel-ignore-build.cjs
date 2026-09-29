const blockedProjectId = 'prj_FWjgAAZfZnNT8fg98jlpFfiWRWn7';

if (process.env.VERCEL_PROJECT_ID === blockedProjectId) {
  console.log('Skipping build: interactive-map must not deploy to jeopardy-generator.');
  process.exit(0);
}

process.exit(1);
