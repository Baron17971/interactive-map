-- Run this in Supabase SQL Editor

create table if not exists public.teacher_projects (
  id text primary key,
  app_id text not null,
  teacher_id text not null,
  payload jsonb not null,
  updated_at timestamptz not null default now()
);

create index if not exists teacher_projects_app_teacher_updated_idx
  on public.teacher_projects (app_id, teacher_id, updated_at desc);

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

-- Optional quick check:
-- select * from public.teacher_projects limit 5;
