-- O家畢業遊：喺 Supabase SQL Editor 貼晒落去撳 Run（只需要做一次）

create table if not exists public.trip (
  id text primary key,
  state jsonb not null default '{}'::jsonb,
  ver integer not null default 0,
  updated_at timestamptz not null default now()
);

alter table public.trip enable row level security;

drop policy if exists "trip read" on public.trip;
create policy "trip read" on public.trip for select to anon using (id = 'o-family');

drop policy if exists "trip update" on public.trip;
create policy "trip update" on public.trip for update to anon
  using (id = 'o-family') with check (id = 'o-family');

insert into public.trip (id, state)
values ('o-family', '{"votes":{"s14l":{"0":["l"]},"s14d":{"0":["l"]},"s15n":{"0":["l"]},"s16a":{"1":["l"]},"s16p":{"2":["l"]},"s16d":{"0":["l"]},"s17a":{"1":["l"]},"s17p":{"0":["l"]},"s17n":{"0":["l"]},"s18z":{"0":["l"]}},"done":{"car":"l"},"notes":[],"photos":[],"custom":[]}'::jsonb)
on conflict (id) do nothing;

-- 相簿：公開讀取、可以上載，唔可以刪除或者覆蓋
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('photos', 'photos', true, 15728640, array['image/jpeg','image/png','image/webp','image/heic','image/heif','image/gif'])
on conflict (id) do nothing;

drop policy if exists "photos upload" on storage.objects;
create policy "photos upload" on storage.objects for insert to anon
  with check (bucket_id = 'photos' and (storage.foldername(name))[1] = 'o-family');
