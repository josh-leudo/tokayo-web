# Tokayo — Waitlist

Landing de lista de espera para promover Tokayo antes del lanzamiento.
Sitio estático (un solo `index.html`), hospedado en GitHub Pages.

## Puesta en marcha

1. **Supabase** — ejecuta `supabase-waitlist.sql` en el SQL Editor (crea la
   tabla `waitlist` y la policy de insert).
2. **Llave** — en `index.html`, reemplaza `__PEGA_AQUI_TU_SUPABASE_PUBLISHABLE_KEY__`
   por tu *publishable key* (`sb_publishable_...`), que está en
   Supabase → Project Settings → API. Es pública: está pensada para el cliente.
3. **Publicar** — sube este repo a GitHub y activa Pages (Settings → Pages →
   branch `main` / `/root`).

## Ver los correos

Supabase → Table Editor → `waitlist` → Export to CSV.
La columna `wants_android_test = true` son tus candidatos a tester de Android.
