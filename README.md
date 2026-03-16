# Interactive Map App (Supabase)

## Run Locally

```bash
npm install
npm run dev -- --host 127.0.0.1 --port 5174
```

Open: `http://127.0.0.1:5174`

## Enable Cloud Save (Supabase)

This app stores maps by `teacherId` so the same teacher can open maps from another browser.

### 1. Create Supabase project

1. Open https://supabase.com/dashboard
2. Create a new project.
3. In **Settings -> API**, copy:
   - `Project URL`
   - `anon public` key

### 2. Configure this app

Edit `public/supabase-config.js`:

```js
window.APP_ID = "interactive-map";
window.SUPABASE_PROJECTS_TABLE = "teacher_projects";
window.SUPABASE_URL = "https://YOUR_PROJECT_REF.supabase.co";
window.SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_KEY";
```

If URL/key are empty, app falls back to local browser storage.

### 3. Create table in Supabase SQL Editor

```sql
create table if not exists public.teacher_projects (
  id text primary key,
  app_id text not null,
  teacher_id text not null,
  payload jsonb not null,
  updated_at timestamptz not null default now()
);

create index if not exists teacher_projects_app_teacher_updated_idx
  on public.teacher_projects (app_id, teacher_id, updated_at desc);
```

### 4. Enable RLS + policies (simple mode)

```sql
alter table public.teacher_projects enable row level security;

drop policy if exists teacher_projects_select on public.teacher_projects;
drop policy if exists teacher_projects_insert on public.teacher_projects;
drop policy if exists teacher_projects_update on public.teacher_projects;
drop policy if exists teacher_projects_delete on public.teacher_projects;

create policy teacher_projects_select
on public.teacher_projects
for select
to anon, authenticated
using (true);

create policy teacher_projects_insert
on public.teacher_projects
for insert
to anon, authenticated
with check (true);

create policy teacher_projects_update
on public.teacher_projects
for update
to anon, authenticated
using (true)
with check (true);

create policy teacher_projects_delete
on public.teacher_projects
for delete
to anon, authenticated
using (true);
```

Note: this is intentionally permissive to keep setup simple. For production, add stricter per-teacher auth rules.

### 5. Test

1. Run app.
2. Enter a teacher ID (e.g. `mora-rina`).
3. Create + save map.
4. Open another browser and enter the same teacher ID.
5. The map should appear.

## Build

```bash
npm run build
```
