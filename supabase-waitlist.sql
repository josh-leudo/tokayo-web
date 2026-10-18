-- Tokayo — lista de espera (waitlist) para la landing.
-- Ejecútalo en: Supabase → SQL Editor → New query → Run. Seguro de re-ejecutar.

create table if not exists public.waitlist (
  id         uuid primary key default gen_random_uuid(),
  email      text not null,
  os         text check (os in ('android','ios')),  -- sistema operativo del usuario
  source     text,
  user_agent text,
  created_at timestamptz not null default now(),
  unique (email)
);

-- Si ya existía la tabla de antes, agrega la columna os:
alter table public.waitlist add column if not exists os text;

alter table public.waitlist enable row level security;

-- Cualquiera (visitante anónimo) puede INSERTAR su correo…
drop policy if exists "waitlist_insert_anon" on public.waitlist;
create policy "waitlist_insert_anon"
  on public.waitlist for insert
  to anon, authenticated
  with check (true);

-- …pero NADIE puede LEER la lista por la API (no hay policy de select).
-- Tú ves y exportas los correos desde el dashboard: Table Editor → waitlist.

-- Contador público para el "Únete a N en la lista" (no expone correos).
create or replace function public.waitlist_count()
returns integer
language sql
security definer
stable
set search_path = public
as $$
  select count(*)::int from public.waitlist;
$$;
grant execute on function public.waitlist_count() to anon, authenticated;

-- ── Para ver tus testers de Android (ejecútalo cuando quieras) ──────────────
-- select email, created_at from public.waitlist
-- where os = 'android' order by created_at;
